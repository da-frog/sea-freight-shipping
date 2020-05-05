from dataclasses import dataclass
from .base import BaseModel
from .vehicle import Vehicle
from .voyage import VoyageSchedule
from .bill_of_lading import BillOfLading


@dataclass
class Shipment(BaseModel):
    _instances = []
    fields = (
        'Shipment Key',
        'Voyage Schedule Key',
        'Vehicle Key',
        'Bill-of-Lading Key'
    )

    voyage_schedule_key: int = None
    vehicle_key: int = None
    bill_of_lading_key: int = None

    @property
    def shipment_key(self) -> int:
        return self.key

    @property
    def voyage_schedule(self) -> VoyageSchedule:
        return VoyageSchedule.get_instance_by_key(self.voyage_schedule_key)

    @property
    def vehicle(self) -> Vehicle:
        return Vehicle.get_instance_by_key(self.vehicle_key)

    @property
    def bill_of_lading(self) -> BillOfLading:
        return BillOfLading.get_instance_by_key(self.bill_of_lading_key)
