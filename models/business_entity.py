from typing import List
from dataclasses import dataclass, field

from .base import BaseModel
from .address import Address


@dataclass
class BusinessEntity(BaseModel):
    _instances = []
    fields = (
        ('Business Entity Key', None, 'int'),
        ('Name', None, 'nvarchar(255)'),
        ('E-mail', 'email', 'nvarchar(255)'),
        ('Phone', None, 'nvarchar(15)'),
        ('Fax', None, 'nvarchar(15)'),
        ('Address Key', None, 'int'),
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
