from dataclasses import dataclass

from location import Location
from .base import BaseModel


@dataclass
class Vehicle(BaseModel):
    _instances = []
    fields = (
        ('Vehicle Key', None, 'int'),
        ('Vehicle Speed (km/h)', 'vehicle_speed_kmh'),
        'Vehicle Type',
        'Vehicle Name',
        'Vehicle Capacity',
        'Vehicle Builder',
        'Vehicle Fuel Usage per Day',
        'Current Latitude',
        'Current Longitude'
    )

    vehicle_speed_kmh: float
    vehicle_type: str = ''
    vehicle_name: str = ''
    vehicle_capacity: float = None
    vehicle_builder: str = ''
    vehicle_fuel_usage_per_day: float = None
    current_latitude: str = ''
    current_longitude: str = ''

    @property
    def current_position(self) -> Location:
        return Location(self.current_latitude, self.current_longitude)

    @property
    def vehicle_key(self) -> int:
        return self.key
