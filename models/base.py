from __future__ import annotations

from typing import Sequence
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


class BaseModel:
    instances = []  # Don't forget to overwrite this
    fields = ()  # Don't forget to overwrite this

    def __new__(cls, *args, **kwargs):
        obj = super().__new__(cls)
        cls.instances.append(obj)
        return obj

    def __init__(self, **kwargs):
        raise NotImplementedError('You must subclass this class as a dataclass')

    @classmethod
    def init_from_dict(cls, dct: dict) -> BaseModel:
        kwargs = {}
        for field in cls.fields:
            if isinstance(field, str):
                if common_name_to_snake_case(field) in cls.__annotations__:
                    kwargs[common_name_to_snake_case(field)] = field
            elif isinstance(field, tuple):
                assert isinstance(field[0], str)
                assert isinstance(field[1], str)
                if common_name_to_snake_case(field[1]) in cls.__annotations__:
                    kwargs[field[1]] = dct[field[0]]
            else:
                raise AssertionError("Wrong fields format")
        return cls(**kwargs)  # its subclasses will be dataclasses
        # TODO: deal with lists

    @classmethod
    def get_instance_by_key(cls, key: int):
        if not cls.instances:
            raise IndexError(f"No instances yet! Can't get {key}")
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
                instance = cls()
                instance.__dict__.update(dct)

    def as_json(self) -> dict:
        d = {
            '@class': self.__class__.__name__,
            '@module': 'models',
        }
        d.update(self.__dict__)
        return d


class Bridge(BaseModel):

    @classmethod
    def dump_to_csv(cls, filename: str):
        pass

    @classmethod
    def load_from_csv(cls, filename: str):
        pass