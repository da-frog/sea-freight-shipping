from location import Location
from .base import BaseModel
from .address import Address


class Port(BaseModel):
    instances = []
    fields = (
        'Port Key',
        'Address Key',
        'Port Name',
        'Port Type',
        'Port Size',
        'Phone',
        'FAX',
        '800 number',
        'UNLOCODE',
        'E-mail',
        'Website',
    )

    def __init__(self):
        self.address_key: int = None
        self.port_name: str = ''
        self.port_type: str = ''
        self.port_size: str = ''
        self.phone: str = ''
        self.fax: str = ''
        self['800 number']: str = ''
        self.unlocode: str = ''
        self.email: str = ''
        self.website: str = ''

    @property
    def port_key(self) -> int:
        return self.key

    @property
    def address(self) -> Address:
        return Address.get_instance_by_key(self.address_key)

    @property
    def location(self) -> Location:
        return self.address.location