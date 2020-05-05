from dataclasses import dataclass
from typing import ClassVar, List, Sequence

from location import Location

from .base import BaseModel
from .address import Address


@dataclass
class Port(BaseModel):
    _instances: ClassVar[List['Port']] = []
    fields: ClassVar[Sequence[str]] = (
        'Port Key',
        'Address Key',
        'Port Name',
        'Port Type',
        'Port Size',
        'Phone',
        'Fax',
        ('800 Number', '_800_number'),
        ('UN/LOCODE', 'un_locode'),
        'Email',
        'Website',
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
