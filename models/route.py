from datetime import date, datetime, timedelta
from typing import List
import random

import numpy as np

from .base import BaseModel, Bridge
from .port import Port
from .vehicle import Vehicle

from utils import km_to_mile, pairwise


class Leg(BaseModel):
    instances = []
    fields = (
        'Leg Key',
        'Origin Port Key',
        'Destination Port Key',
        'Leg Miles',
    )

    def __init__(self):
        self.origin_port_key: int = None
        self.destination_port_key: int = None

    @property
    def origin_port(self) -> Port:
        return Port.get_instance_by_key(self.origin_port_key)

    @property
    def destination_port(self) -> Port:
        return Port.get_instance_by_key(self.destination_port_key)

    @property
    def leg_kms(self) -> float:
        return self.origin_port.location.calculate_distance(self.destination_port.location)

    @property
    def leg_miles(self) -> float:
        return km_to_mile(self.leg_kms)

    def get_expected_time(self, vehicle: Vehicle) -> timedelta:
        return timedelta(hours=self.leg_kms / vehicle.vehicle_speed_kmh)

    def get_expected_fees(self, vehicle: Vehicle) -> float:
        return self.get_expected_time(vehicle).days * vehicle.vehicle_fuel_usage_per_day


class LegBridge(Bridge):
    instances = []
    fields = (
        'Leg Bridge Key',
        'Leg Key',
    )

    def __init__(self):
        self.legs: List[Leg] = []

    @property
    def leg_bridge_key(self) -> int:
        return self.__class__.instances.index(self)

    @classmethod
    def get_legs(cls, leg_bridge_key: int) -> List[Leg]:
        leg_bridge = cls.get_instance_by_key(leg_bridge_key)
        return leg_bridge.legs


class Voyage(BaseModel):
    instances = []
    fields = (
        'Voyage Key',
        'Leg Bridge Key',
        'Origin Port Key',
        'Destination Port Key',
    )

    def __init__(self):
        self.leg_bridge_key: int = None
        self.port_keys: List[int] = []

    @property
    def legs(self) -> List[Leg]:
        return LegBridge.get_instance_by_key(self.leg_bridge_key)

    @property
    def ports(self) -> List[Port]:
        return list(map(Port.get_instance_by_key, self.port_keys))

    @ports.setter
    def ports(self, ports: List[Port]):
        self.port_keys = list(map(lambda port: port.port_key, ports))

    @property
    def origin_port_key(self) -> int:
        return self.port_keys[0]

    @property
    def destination_port_key(self) -> int:
        return self.port_keys[-1]

    @property
    def origin_port(self) -> Port:
        return Port.get_instance_by_key(self.origin_port_key)

    @property
    def destination_port(self) -> int:
        return Port.get_instance_by_key(self.destination_port_key)

    def get_expected_total_time(self, vehicle: Vehicle) -> timedelta:
        total_time = timedelta()
        for leg in self.legs:
            total_time += leg.get_expected_time(vehicle)
        return total_time


class LegSchedule(BaseModel):
    instances = []
    fields = (
        'Leg Schedule Key',
        'Leg Key',
        'Scheduled Departure Date',
        'Scheduled Arrival Date',
        'Actual Departure Date',
        'Actual Departure Date',
    )

    def __init__(self):
        self.leg_key: int = None
        self.scheduled_departure_date: date = None
        self.scheduled_arrival_date: date = None
        self.actual_departure_date: date = None
        self.actual_arrival_date: date = None

    @property
    def leg_schedule_key(self) -> int:
        return self.key

    @property
    def leg(self) -> Leg:
        return Leg.get_instance_by_key(self.leg_key)

    @property
    def departure_delay(self) -> timedelta:
        return self.actual_departure_date - self.scheduled_departure_date

    @property
    def arrival_delay(self) -> timedelta:
        return self.actual_arrival_date - self.scheduled_arrival_date

    def get_actual_time(self) -> timedelta:
        return self.actual_arrival_date - self.actual_departure_date


class LegScheduleBridge(Bridge):
    instances = []
    fields = (
        'Leg Schedule Bridge Key',
        'Leg Schedule Key',
    )

    def __init__(self):
        self.leg_schedules: List[Leg] = []

    @property
    def leg_schedule_bridge_key(self) -> int:
        return self.__class__.instances.index(self)

    @classmethod
    def get_leg_schedules(cls, leg_schedule_bridge_key: int) -> List[LegSchedule]:
        leg_bridge = cls.get_instance_by_key(leg_schedule_bridge_key)
        return leg_bridge.legs


class VoyageSchedule(BaseModel):
    instances = []
    fields = (
        'Voyage Schedule Key',
        'Voyage Key',
        'Leg Schedule Bridge Key',
    )

    def __init__(self):
        self.voyage_key: int = None
        self.leg_schedule_bridge_key: int = None
        self.scheduled_departure_dates = []
        self.scheduled_arrival_dates = []
        self.actual_departure_dates = []
        self.actual_arrival_dates = []

    @property
    def voyage_schedule_key(self) -> int:
        return self.__class__.instances.index(self.voyage_key)

    @property
    def leg_schedules(self) -> List[LegSchedule]:
        return LegScheduleBridge.get_leg_schedules(self.leg_schedule_bridge_key)

    @property
    def scheduled_departure_date(self):
        return self.leg_schedules[0].scheduled_departure_date

    @scheduled_departure_date.setter
    def scheduled_departure_date(self, scheduled_departure_date: date):
        self.leg_schedules[0].scheduled_departure_date = scheduled_departure_date
        print('Please cascade scheduled date', self)

    def cascade_scheduled_date(self, vehicle: Vehicle):
        for ls1, ls2 in pairwise(self.leg_schedules):
            expected_delay = np.random.poisson(1.5, 1)
            ls2.scheduled_arrival_date = ls1.scheduled_departure_date + ls1.leg.get_expected_time(vehicle)
            ls2.scheduled_departure_date = ls2.scheduled_arrival_date + expected_delay

    @property
    def scheduled_arrival_date(self):
        return self.leg_schedules[-1].scheduled_arrival_date

    @scheduled_arrival_date.setter
    def scheduled_arrival_date(self, scheduled_arrival_date: date):
        self.leg_schedules[-1].scheduled_arrival_date = scheduled_arrival_date
        print('Please cascade actual date', self)

    def cascade_actual_date(self, vehicle: Vehicle):
        for ls1, ls2 in pairwise(self.leg_schedules):
            travel_delay = np.random.exponential(0.05, 1)
            port_delay = np.random.poisson(1.5, 1)
            if random.random() <= 0.05:
                accidental_delay = np.random.poisson(10, 1)
            else:
                accidental_delay = 0
            ls2.actual_arrival_date = ls1.actual_departure_date + ls1.leg.get_expected_time(vehicle) + travel_delay + accidental_delay
            if random.random() <= 0.1:
                accidental_delay = np.random.poisson(4, 1)
            else:
                accidental_delay = 0
            ls2.actual_departure_date = ls2.actual_arrival_date + port_delay + accidental_delay

    @property
    def actual_departure_date(self):
        return self.leg_schedules[0].actual_departure_date

    @property
    def actual_arrival_date(self):
        return self.leg_schedules[-1].actual_arrival_date
