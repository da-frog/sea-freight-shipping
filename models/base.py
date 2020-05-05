from typing import Sequence
import csv
import json


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
        obj = super().__new__(*args, **kwargs)
        cls.instances.append(obj)
        return obj

    def __init__(self, *, dct: dict = None):
        if dct is not None:
            for field in self.fields:
                if isinstance(field, str):
                    setattr(self, common_name_to_snake_case(field), dct[field])
                elif isinstance(field, tuple):
                    assert isinstance(field[0], str)
                    assert isinstance(field[1], str)
                    setattr(self, field[1], dct[field[0]])
                else:
                    raise AssertionError("Wrong fields format")
            # TODO: deal with lists


    @classmethod
    def get_instance_by_key(cls, key: int):
        return cls.instances[key - 1]

    @property
    def key(self) -> int:
        return self.__class__.instances.index(self)

    # def __getitem__(self, item):
    #     try:
    #         return self.__dict__[item]
    #     except KeyError:
    #         raise
    #
    # def __setitem__(self, key, value):
    #     self.__dict__[key] = value

    @classmethod
    def dump_to_csv(cls, filename: str):
        with open(filename, 'w', encoding='utf-8', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, cls.fields)
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
                        else:
                            raise AssertionError(f'WHY? {value} is an object [{cls.__name__}]: {instance}')
                    elif instance(field, tuple):
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
                cls(dct=row)

    @classmethod
    def dump_to_json(cls, filename: str):
        with open(filename, 'w', encoding='utf-8') as f:
            lst = [instance.__dict__ for instance in cls.instances]
            f.write(json.dumps(lst))
            # TODO: deal with unserializable date

    @classmethod
    def load_from_json(cls, filename: str, *, clear_instances=True):
        if clear_instances:
            cls.instances.clear()
        with open(filename, 'r', encoding='utf-8') as f:
            lst = json.loads(f.read())
            for dct in lst:
                instance = cls()
                instance.__dict__.update(dct)


class Bridge(BaseModel):

    @classmethod
    def dump_to_csv(cls, filename: str):
        pass

    @classmethod
    def load_from_csv(cls, filename: str):
        pass