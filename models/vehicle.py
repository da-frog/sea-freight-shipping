from location import Location
from .base import BaseModel


class Vehicle(BaseModel):
    instances = []
    fields = (
        'Vehicle Key',
        ('Vehicle Speed (km/h)', 'vehicle_speed_kmh'),
        'Vehicle Type',
        'Vehicle Name',
        'Vehicle Capacity',
        'Vehicle Builder',
        'Vehicle Fuel Usage per Day',
        'Current Latitude',
        'Current Longitude'
    )

    def __init__(self):
        self.vehicle_speed_kmh: float = None,
        self.vehicle_type: str = '',
        self.vehicle_name: str = '',
        self.vehicle_capacity: float  = None,
        self.vehicle_builder: str = '',
        self.vehicle_fuel_usage_per_day: float = None,
        self.current_latitude: str = '',
        self.current_longitude: str = '',

    @property
    def current_position(self) -> Location:
        return Location(self.current_latitude, self.current_longitude)