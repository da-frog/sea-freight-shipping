from dataclasses import dataclass
from .base import BaseModel
from .container_model import ContainerModel


@dataclass
class Container(BaseModel):
    _instances = []
    fields = (
        'Container Key',
        'Owner Code',
        'Serial Number',
        'Check Digit',
        'ISO Size Code',
        'ISO Type Code'
    )

    container_number: str = ''
    container_class_key: int = None

    @property
    def container_key(self) -> int:
        return self.key

    @property
    def container_class(self) -> ContainerModel:
        return ContainerModel.get_instance_by_key(self.container_class_key)
