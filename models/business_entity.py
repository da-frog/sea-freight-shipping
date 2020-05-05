from .base import BaseModel
from typing import List


class BusinessEntity(BaseModel):
    instances = []
    fields = (
        'Business Entity Key',
        'Name',
        'E-mail',
        'Telephone',
        'Fax',
        'Address Key',
        'Roles'
    )

    def __init__(self):
        self.business_entity_key: int = None
        self.name: str = ''
        self.e_mail: str = ''
        self.telephone: str = ''
        self.fax: str = ''
        self.address_key: int = None
        self.roles: List[str] = []
