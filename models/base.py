from typing import Sequence, List, ClassVar, Tuple, TypeVar, Type
import typing

import csv
import json

from jsoncompat import JSONEncoder, JSONDecoder, Date

T = TypeVar('T')


def common_name_to_snake_case(s: str):
    """ 'Bill-Of-Lading Key' -> 'bill_of_lading_key' """
    chars = []
    for c in s:
        if c.isalnum():
            chars.append(c)
        else:
            if c in (' ', '-', '_'):
                chars.append(' ')
    # TODO: deal with numbers in front
    return ''.join(chars).replace(' ', '_').replace('-', '_').lower()


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
        namespace['_instances'] = []
        return super().__new__(mcs, name, bases, namespace)


class BaseModel(metaclass=BaseModelMeta):
    _instances: ClassVar[list] = []  # Don't forget to overwrite this
    fields: ClassVar[Tuple[str, ...]] = ()  # Don't forget to overwrite this

    def __new__(cls, *args, **kwargs):
        obj = super().__new__(cls)
        cls._instances.append(obj)
        return obj

    def __init__(self, **kwargs):
        raise AssertionError('You must subclass this class as a dataclass')

    @classmethod
    def get_dict_keys(cls) -> List[str]:
        keys = []
        for field in cls.fields:
            if isinstance(field, str):
                keys.append(field)
            elif isinstance(field, tuple):
                assert isinstance(field[0], str), "Wrong fields format"
                assert isinstance(field[1], str), "Wrong fields format"
                keys.append(field[0])
        return keys

    @classmethod
    def get_attr_names(cls) -> List[str]:
        attrs = []
        for field in cls.fields:
            if isinstance(field, str):
                attrs.append(common_name_to_snake_case(field))
            elif isinstance(field, tuple):
                assert isinstance(field[0], str), "Wrong fields format"
                assert isinstance(field[1], str), "Wrong fields format"
                attrs.append(field[1])
        return attrs

    @classmethod
    def init_from_dict(cls, dct: dict) -> 'BaseModel':
        kwargs = {}
        for key, attr in zip(cls.get_dict_keys(), cls.get_attr_names()):
            if dct[key] == '' or dct[key] == 'NULL':
                kwargs[attr] = None
                continue
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
                    if type_ in [List, dict]:
                        kwargs[attr] = json.loads(dct[key], cls=JSONDecoder)
                        continue
                    elif type_ == Date:
                        kwargs[attr] = Date.fromisoformat(dct[key])
                        continue
                    kwargs[attr] = type_(dct[key])
            except KeyError:
                pass
        return cls(**kwargs)  # its subclasses will be dataclasses

    @classmethod
    def get_instance_by_key(cls: Type[T], key: int) -> T:
        if not cls._instances:
            raise IndexError(f"No instances yet! Can't get key={key}")
        try:
            return cls._instances[key - 1]
        except IndexError:
            print(key)
            raise

    @property
    def key(self) -> int:
        return self.__class__._instances.index(self) + 1

    @classmethod
    def dump_to_csv(cls, filename: str):
        with open(filename, 'w', encoding='utf-8', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, cls.get_dict_keys())
            writer.writeheader()

            for instance in cls._instances:
                dct = {}
                for key, attr in zip(cls.get_dict_keys(), cls.get_attr_names()):
                    value = getattr(instance, attr)
                    if isinstance(value, list):
                        value = json.dumps(value)
                    elif isinstance(value, dict):
                        value = json.dumps(value)
                    elif isinstance(value, Date):
                        value = value.isoformat()
                    dct[key] = value
                writer.writerow(dct)

    @classmethod
    def load_from_csv(cls, filename: str, *, clear_instances=True, limit=None):
        # not recommended
        if clear_instances:
            cls._instances.clear()
        with open(filename, 'r', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            count = 0
            for row in reader:
                if limit is not None:
                    if count == limit:
                        break
                cls.init_from_dict(dct=row)
                count += 1

    @classmethod
    def dump_to_json(cls, filename: str):
        with open(filename, 'w', encoding='utf-8') as f:
            lst = [instance.__dict__ for instance in cls._instances]
            f.write(json.dumps(lst, cls=JSONEncoder))

    @classmethod
    def load_from_json(cls, filename: str, *, clear_instances=True):
        if clear_instances:
            cls._instances.clear()
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

    def __getitem__(self, item: str):
        for key, attr in zip(self.get_dict_keys(), self.get_attr_names()):
            if key == item:
                return getattr(self, attr)
        else:
            raise KeyError(f"Key '{item}' is not found")
