class BaseModel:
    instances = []  # Don't forget to overwrite this
    fields = ()  # Don't forget to overwrite this

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
        pass

    @classmethod
    def load_from_csv(cls, filename: str):
        pass


class Bridge(BaseModel):

    @classmethod
    def dump_to_csv(cls, filename: str):
        pass

    @classmethod
    def load_from_csv(cls, filename: str):
        pass