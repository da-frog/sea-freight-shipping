from dataclasses import dataclass

from .base import BaseModel


@dataclass
class Commodity(BaseModel):
    _instances = []
    fields = (
        'Commodity Key',
        'HS Code',
        'Description',
        ('Package Size (m^3)', 'package_size'),
        ('Package Weight (kg)', 'package_weight'),
        ('Densities (kg/m^3)', 'densities'),
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
