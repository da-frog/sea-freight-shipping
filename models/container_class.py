from .base import BaseModel


class ContainerClass(BaseModel):
    instances = []
    fields = (
        'Container Class Key',
        'ISO Size Type',
        'Tare Weight',
        'Inside_Length',
        'Inside',
        'Width',
        'Inside',
        'Height',
        'Capacity
    )

    def __init__(self):
        self.iso_size_type: str = ''
        self.tare_weight: float = None
        self.inside_length: float = None
        self.inside_width: float = None
        self.inside_height: float = None
        self.capacity: float = None

    @property
    def container_class_key(self) -> int:
        return self.key

