from .base import BaseModel


class Container(BaseModel):
    instances = []
    fields = (
        'Container Key',
        'Container Number',
        'Container Class Key'
    )

    def __init__(self):
        self.container_number: str = ''
        self.container_class_key: int = None
