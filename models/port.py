from dataclasses import dataclass
from typing import ClassVar, List, Sequence

from location import Location

from .base import BaseModel
from .address import Address


@dataclass
class Port(BaseModel):
    _instances: ClassVar[List['Port']] = []
    fields: ClassVar[Sequence[str]] = (
        ('Port Key', None, 'int'),
        ('Address Key', None, 'int'),
        ('Port Name', None, 'nvarchar(255)'),
        ('Port Type', None, 'nvarchar(255)'),
        ('Port Size', None, 'nvarchar(255)'),
        ('Phone', None, 'nvarchar(15)'),
        ('Fax', None, 'nvarchar(15)'),
        ('800 Number', '_800_number', 'nvarchar(15)'),
        ('UN/LOCODE', 'un_locode', 'nvarchar(10)'),
        ('Email', None, 'nvarchar(255)'),
        ('Website', None, 'nvarchar(255)'),
    )

    address_key: int
    port_name: str = ''
    port_type: str = ''
    port_size: str = ''
    phone: str = ''
    fax: str = ''
    _800_number: str = ''
    un_locode: str = ''
    email: str = ''
    website: str = ''

    @property
    def port_key(self) -> int:
        return self.key

    @property
    def address(self) -> Address:
        return Address.get_instance_by_key(self.address_key)

    @property
    def location(self) -> Location:
        return self.address.location
