from location import Location
from .base import BaseModel


class Address(BaseModel):
    instances = []
    fields = (
        'Address Key',
        'Address Line 1',
        'Address Line 2',
        'City',
        'Country',
        'Alpha',
        'ZIP Code',
        'latitude',
        'longitude',
    )

    def __init__(self):
        self.address_line_1: str = ''
        self.address_line_2: str = ''
        self.city: str = ''
        self.country: str = ''
        self.alpha: str = ''
        self.zip_code: str = ''
        self.latitude: str = ''
        self.longitude: str = ''

    @property
    def address_key(self) -> int:
        return self.key

    @property
    def location(self) -> Location:
        return Location(self.latitude, self.longitude)