from typing import List
from dataclasses import dataclass, field

from .base import BaseModel
from .address import Address


@dataclass
class BusinessEntity(BaseModel):
    _instances = []
    fields = (
        ('Business Entity Key', None, 'int'),
        'Name',
        ('E-mail', 'email'),
        'Phone',
        'Fax',
        'Address Key',
        'Roles'
    )

    name: str = ''
    email: str = ''
    phone: str = ''
    fax: str = ''
    address_key: int = None
    roles: List[str] = field(default_factory=list)

    @property
    def business_entity_key(self) -> int:
        return self.key

    @property
    def address(self) -> Address:
        return Address.get_instance_by_key(self.address_key)
