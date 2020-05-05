from dataclasses import dataclass

from .base import BaseModel


@dataclass
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

    hs_code: str = ''
    # String/NULL
    description: str = ''
    package_size: float = None
    package_weight: float = None
    densities: float = None

    @property
    def commodity_key(self) -> int:
        return self.key
