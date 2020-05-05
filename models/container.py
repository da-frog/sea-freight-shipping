from dataclasses import dataclass
from .base import BaseModel
from .container_class import ContainerModel


@dataclass
class Container(BaseModel):
    instances = []
    fields = (
        'Container Key',
        'Container Number',
        'Container Class Key'
    )

    container_number: str = ''
    container_class_key: int = None

    @property
    def container_key(self) -> int:
        return self.key

    @property
    def container_class(self) -> ContainerModel:
        return ContainerModel.get_instance_by_key(self.container_class_key)
