from typing import List
from datetime import date

from .address import Address
from .base import BaseModel
from .business_entity import BusinessEntity
from .commodity import Commodity
from .container import Container
from .port import Port


class BillOfLading(BaseModel):
    instances = []
    fields = (
        'Bill-Of-Lading Key',
        'Bill-of-Lading Number',
        'Issued Date',
        'Consignor Key',
        'Consignee Key',
        'Foreign Transporter Key',
        'Foreign Consolidator Key',
        'Courier Key',
        'Domestic Transporter Key',
        'Domestic Consolidator Key',
        'Ship Mode',
        'Place of Receipt Key',
        'Place of Delivery Key',
        'Port of Loading Key',
        'Port of Discharge Key',
        'Commodity Key',
        'Container Key',
        'Incoterm',
        'Expected Tariffs',
        'Actual Tariffs'
    )

    def __init__(self):
        self.bill_of_lading_number: str = ''
        self.issued_date: date = None
        self.consignor_key: int = None
        self.consignee_key: int = None
        self.foreign_transporter_key: int = None
        self.foreign_consolidator_key: int = None
        self.courier_key: int = None
        self.domestic_transporter_key: int = None
        self.domestic_consolidator_key: int = None
        self.ship_mode: str = ''
        self.place_of_receipt_key: int = None
        self.place_of_delivery_key: int = None
        self.port_of_loading_key: int = None
        self.port_of_discharge_key: int = None
        self.commodity_key: int = None
        self.container_key: int = None
        self.incoterm: int = None
        self.expected_tariffs: float = None
        self.actual_tariffs: float = None

    @property
    def bill_of_lading_key(self) -> int:
        return self.key

    @property
    def consignor(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.consignor_key)

    @property
    def consignee(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.consignee_key)

    @property
    def foreign_transporter(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.foreign_transporter_key)

    @property
    def foreign_consolidator(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.foreign_consolidator_key)

    @property
    def courier(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.courier_key)

    @property
    def domestic_transporter(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.domestic_transporter_key)

    @property
    def domestic_consolidator(self) -> BusinessEntity:
        return BusinessEntity.get_instance_by_key(self.domestic_transporter_key)

    @property
    def place_of_receipt(self) -> Address:
        return Address.get_instance_by_key(self.domestic_transporter_key)

    @property
    def place_of_delivery(self) -> Address:
        return Address.get_instance_by_key(self.domestic_transporter_key)

    @property
    def port_of_loading(self) -> Port:
        return Port.get_instance_by_key(self.domestic_transporter_key)

    @property
    def port_of_discharge(self) -> Port:
        return Port.get_instance_by_key(self.domestic_transporter_key)

    @property
    def commodity(self) -> Commodity:
        return Commodity.get_instance_by_key(self.domestic_transporter_key)

    @property
    def container(self) -> Container:
        return Container.get_instance_by_key(self.domestic_transporter_key)
