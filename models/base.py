from typing import Sequence, List, ClassVar, Tuple
import typing

import csv
import json

from jsoncompat import JSONEncoder, JSONDecoder


def common_name_to_snake_case(s: str):
    """ 'Bill-Of-Lading Key' -> 'bill_of_lading_key' """
    chars = []
    for c in s:
        if c.isalnum():
            chars.append(c)
        else:
            if c in (' ', '-', '_'):
                chars.append(c)
    # TODO: deal with numbers in front
    return s.replace(' ', '_').replace('-', '_').lower()


class BaseModelMeta(type):
    def __new__(mcs, name: str, bases: tuple, namespace: dict):
        if name not in ('BaseModel', 'Bridge'):
            try:
                if namespace['fields'] == ():
                    raise AttributeError(f"class attribute 'fields' is not "
                                         f'defined in {name}')
            except KeyError:
                raise AttributeError(f"class attribute 'fields' is not "
                                     f'defined in {name}') from None
            try:
                if namespace['instances']:
                    raise AttributeError(f"class attribute 'instances' is not "
                                         f'defined in {name}')
            except KeyError:
                raise AttributeError(f"class attribute 'instances' is not "
                                     f'defined in {name}') from None
        return super().__new__(mcs, name, bases, namespace)


class BaseModel(metaclass=BaseModelMeta):
    instances: ClassVar[list] = []  # Don't forget to overwrite this
    fields: ClassVar[Tuple[str, ...]] = ()  # Don't forget to overwrite this

    def __new__(cls, *args, **kwargs):
        obj = super().__new__(cls)
        cls.instances.append(obj)
        return obj

    def __init__(self, **kwargs):
        raise AssertionError('You must subclass this class as a dataclass')

    @classmethod
    def init_from_dict(cls, dct: dict) -> 'BaseModel':
        kwargs = {}
        for field in cls.fields:
            if isinstance(field, str):
                attr = common_name_to_snake_case(field)
                key = field
            elif isinstance(field, tuple):
                assert isinstance(field[0], str)
                assert isinstance(field[1], str)
                attr = common_name_to_snake_case(field[1])
                key = field[0]
            else:
                raise AssertionError("Wrong fields format")

            try:
                type_ = cls.__annotations__[attr]
                if isinstance(type_, str):
                    raise NotImplementedError('string annotations cannot be used '
                                              'to convert type, and is not supported yet')
                try:
                    if type_.__origin__ == list:
                        kwargs[attr] = json.loads(dct[key])
                    elif type_.__origin__ == ClassVar:
                        continue
                except AttributeError:
                    kwargs[attr] = type_(dct[key])
            except KeyError:
                pass
        return cls(**kwargs)  # its subclasses will be dataclasses
        # TODO: deal with lists

    @classmethod
    def get_instance_by_key(cls, key: int):
        if not cls.instances:
            raise IndexError(f"No instances yet! Can't get key={key}")
        return cls.instances[key - 1]

    @property
    def key(self) -> int:
        return self.__class__.instances.index(self)

    @classmethod
    def dump_to_csv(cls, filename: str):
        with open(filename, 'w', encoding='utf-8', newline='') as csvfile:
            keys = []
            for field in cls.fields:
                if isinstance(field, str):
                    keys.append(field)
                elif isinstance(field, tuple):
                    keys.append(field[0])
                else:
                    raise AssertionError('field format is wrong')
            writer = csv.DictWriter(csvfile, keys)
            writer.writeheader()
            for instance in cls.instances:
                dct = {}
                for field in cls.fields:
                    key = None  # insurance, to not use old values
                    if isinstance(field, str):
                        key = field
                        value = getattr(instance, common_name_to_snake_case(field))
                        if isinstance(value, Sequence):
                            value = json.dumps(value)
                        elif isinstance(value, dict):
                            value = json.dumps(value)
                        # else:
                        #     raise AssertionError(f'WHY? {value} is an object [{cls.__name__}]: {instance}')
                    elif isinstance(field, tuple):
                        assert isinstance(field[0], str)
                        assert isinstance(field[1], str)
                        key = field[0]
                        value = getattr(instance, field[1])
                    else:
                        raise AssertionError('field format is wrong')
                    dct[key] = value
                writer.writerow(dct)

    @classmethod
    def load_from_csv(cls, filename: str, *, clear_instances=True):
        # not recommended
        if clear_instances:
            cls.instances.clear()
        with open(filename, 'r', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                cls.init_from_dict(dct=row)

    @classmethod
    def dump_to_json(cls, filename: str):
        with open(filename, 'w', encoding='utf-8') as f:
            lst = [instance.__dict__ for instance in cls.instances]
            f.write(json.dumps(lst, cls=JSONEncoder))

    @classmethod
    def load_from_json(cls, filename: str, *, clear_instances=True):
        if clear_instances:
            cls.instances.clear()
        with open(filename, 'r', encoding='utf-8') as f:
            lst = json.loads(f.read(), cls=JSONDecoder)
            for dct in lst:
                cls(**dct)  # shouldn't fail if it's a dataclass

    def as_json(self) -> dict:
        d = {
            '@class': self.__class__.__name__,
            '@module': 'models',
        }
        d.update(self.__dict__)
        return d
