from typing import List

from .base import BaseModel
from .address import Address


class BusinessEntity(BaseModel):
    instances = []
    fields = (
        'Business Entity Key',
        'Name',
        'E-mail',
        'Phone',
        'Fax',
        'Address Key',
        'Roles'
    )

    def __init__(self):
        self.name: str = ''
        self.e_mail: str = ''
        self.phone: str = ''
        self.fax: str = ''
        self.address_key: int = None
        self.roles: List[str] = []

    @property
    def business_entity_key(self) -> int:
        return self.key

    @property
    def address(self) -> Address:
        return Address.get_instance_by_key(self.address_key)
