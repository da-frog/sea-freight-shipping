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
        ('Alpha 2', None, 'nvarchar(2)'),
        ('ZIP Code', None, 'nvarchar(12)'),
        ('Latitude', None, 'nvarchar(15)'),
        ('Longitude', None, 'nvarchar(15'),
    )

    address_line_1: str = ''
    address_line_2: str = ''
    city: str = ''
    country: str = ''
    alpha_2: str = ''
    zip_code: str = ''
    latitude: str = ''
    longitude: str = ''

    def __post_init__(self):
        self.address_line_1 = self.address_line_1.strip()
        self.address_line_2 = self.address_line_2.strip()
        self.city = self.city.strip()
        self.country = self.country.strip()
        self.alpha_2 = self.alpha_2.strip()
        self.zip_code = self.zip_code.strip()
        self.latitude = self.latitude.strip()
        self.longitude = self.longitude.strip()

    @property
    def address_key(self) -> int:
        return self.key

    @property
    def location(self) -> Location:
        return Location(self.latitude, self.longitude)