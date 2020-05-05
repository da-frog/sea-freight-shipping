from dataclasses import dataclass

from .base import BaseModel


@dataclass
class ContainerModel(BaseModel):
    instances = []
    fields = (
        'Container Class Key',
        'ISO Size Type',
        'Tare Weight',
        'Inside_Length',
        'Inside_Width',
        'Inside_Height',
        'Capacity',
    )

    iso_size_type: str = ''
    tare_weight: float = None
    inside_length: float = None
    inside_width: float = None
    inside_height: float = None
    capacity: float = None

    @property
    def container_class_key(self) -> int:
        return self.key
