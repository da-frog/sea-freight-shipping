from .base import BaseModel


class Commodity(BaseModel):
    instances = []
    fields = (
        'Commodity Key',
        'HS Code',
        'Description',
        'Package Size',
        'Package Weight',
        'Densities',
    )

    def __init__(self):
        self.hs_code: str = ''
        # String/NULL
        self.description: str = ''
        self.package_size: float = None
        self.package_weight: float = None
        self.densities: float = None

    @property
    def commodity_key(self) -> int:
        return self.key
