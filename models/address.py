from dataclasses import dataclass


from location import Location

from .base import BaseModel


@dataclass
class Address(BaseModel):
    _instances = []
    fields = (
        ('Address Key', None, 'int'),
        'Address Line 1',
        'Address Line 2',
        'City',
        'Country',
        'Alpha 2',
        'ZIP Code',
        'Latitude',
        'Longitude',
    )

    address_line_1: str = ''
    address_line_2: str = ''
    city: str = ''
    country: str = ''
    alpha_2: str = ''
    zip_code: str = ''
    latitude: str = ''
    longitude: str = ''

    @property
    def address_key(self) -> int:
        return self.key

    @property
    def location(self) -> Location:
        return Location(self.latitude, self.longitude)