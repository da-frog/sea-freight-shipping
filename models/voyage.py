from datetime import date, datetime, timedelta
from typing import List, ClassVar, Sequence, Tuple, Iterable
import random
from dataclasses import dataclass, field

import numpy as np

from .base import BaseModel
from .port import Port
from .vehicle import Vehicle

from utils import km_to_mile, pairwise
from jsoncompat import Date, TimeDelta


@dataclass
class Leg(BaseModel):
    instances = []
    fields = (
        'Leg Key',
        'Origin Port Key',
        'Destination Port Key',
        'Leg Miles',
    )

    origin_port_key: int
    destination_port_key: int

    @property
    def leg_key(self) -> int:
        return self.key

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

    @classmethod
    def get_or_create_instance_from_port_pair(cls, origin_port: Port, destination_port: Port) -> 'Leg':
        for instance in cls.instances:
            if instance.origin_port == origin_port and instance.destination_port == destination_port:
                return instance
        return Leg(origin_port_key=origin_port.key, destination_port_key=destination_port.key)


def legs_to_ports(legs: Sequence[Leg]) -> List[Port]:
    ports = [legs[0].origin_port]
    for leg in legs:
        ports.append(leg.destination_port)
    return ports


def ports_to_legs(ports: Iterable[Port]) -> List[Leg]:
    return [
        Leg.get_or_create_instance_from_port_pair(origin, destination)
        for origin, destination in pairwise(ports)
    ]


@dataclass
class LegBridge(BaseModel):
    instances: ClassVar[List['LegBridge']] = []
    fields = (
        # ('Surrogate Key', 'key'),
        'Leg Bridge Key',
        'Leg Key',
    )

    leg_bridge_key: int
    leg_key: int

    @classmethod
    def _create_new_bridge_from_legs(cls, legs: Iterable[Leg]) -> int:
        """
        Returns leg_bridge_key of the LegBridge created.
        """
        leg_bridge_key = cls.instances[-1].leg_bridge_key + 1
        for leg in legs:
            cls(leg_bridge_key=leg_bridge_key, leg_key=leg.key)
        return leg_bridge_key

    @classmethod
    def get_or_create_new_bridge_from_legs(cls, legs: Iterable[Leg]) -> int:
        """
        Returns leg_bridge_key of the LegBridge created/found.
        """
        goal_leg_keys = set(leg.key for leg in legs)
        leg_keys = set()
        leg_brdige_key = None
        for instance in cls.instances:
            if leg_brdige_key is None:
                leg_brdige_key = instance.leg_bridge_key
            if instance.leg_bridge_key == leg_brdige_key:
                leg_keys.add(instance.leg_key)
            else:
                if leg_keys == goal_leg_keys:
                    return leg_brdige_key
                leg_brdige_key = None
        return cls._create_new_bridge_from_legs(legs)

    @classmethod
    def get_legs(cls, leg_bridge_key: int) -> List[Leg]:
        leg_keys = []
        found = None
        for instance in cls.instances:
            if instance.leg_bridge_key == leg_bridge_key:
                leg_keys.append(instance.leg_key)
                found = True
            elif found is not None:
                break
        else:
            raise ValueError(f"No LegBridge with key '{leg_bridge_key} found'")
        return list(map(Leg.get_instance_by_key, leg_keys))


@dataclass
class Voyage(BaseModel):
    instances = []
    fields = (
        'Voyage Key',
        'Leg Bridge Key',
        'Origin Port Key',
        'Destination Port Key',
    )

    leg_bridge_key: int = None

    @property
    def voyage_key(self) -> int:
        return self.key

    @property
    def legs(self) -> List[Leg]:
        return LegBridge.get_legs(self.leg_bridge_key)

    @legs.setter
    def legs(self, legs: List[Leg]):
        self.leg_bridge_key = LegBridge.get_or_create_new_bridge_from_legs(legs)

    @classmethod
    def get_or_create_instance_from_ports(cls, ports: Sequence[Port]):
        for instance in cls.instances:
            if instance.ports == ports:
                return instance
        leg_bridge_key = LegBridge.get_or_create_new_bridge_from_legs(ports_to_legs(ports))
        return cls(leg_bridge_key=leg_bridge_key)

    @property
    def ports(self) -> List[Port]:
        return legs_to_ports(self.legs)

    @ports.setter
    def ports(self, ports: List[Port]):
        self.leg_bridge_key = LegBridge.get_or_create_new_bridge_from_legs(ports_to_legs(ports))

    @property
    def origin_port_key(self) -> int:
        return self.ports[0].key

    @property
    def destination_port_key(self) -> int:
        return self.ports[-1].key

    @property
    def origin_port(self) -> Port:
        return self.ports[0]

    @property
    def destination_port(self) -> Port:
        return self.ports[-1]

    def get_expected_total_time(self, vehicle: Vehicle) -> timedelta:
        total_time = timedelta()
        for leg in self.legs:
            total_time += leg.get_expected_time(vehicle)
        return total_time


@dataclass
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

    leg_key: int = None
    scheduled_departure_date: Date = None
    scheduled_arrival_date: Date = None
    actual_departure_date: Date = None
    actual_arrival_date: Date = None

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


@dataclass
class LegScheduleBridge(BaseModel):
    instances: ClassVar[List['LegScheduleBridge']] = []
    fields: ClassVar[Sequence['fields']] = (
        # ('Surrogate Key', 'key'),
        'Leg Schedule Bridge Key',
        'Leg Schedule Key',
    )

    leg_schedule_bridge_key: int
    leg_schedule_key: int

    @classmethod
    def _create_new_bridge_from_leg_schedules(cls, leg_schedules: Sequence[LegSchedule]) -> int:
        """
        Returns leg_schedule_bridge_key of the LegBridge created.
        """
        leg_schedule_bridge_key = cls.instances[-1].leg_bridge_key + 1
        for leg_schedule in leg_schedules:
            cls(leg_schedule_bridge_key=leg_schedule_bridge_key, leg_schedule_key=leg_schedule.key)
        return leg_schedule_bridge_key

    @classmethod
    def get_or_create_new_bridge_from_leg_schedules(cls, leg_schedules: Sequence[LegSchedule]) -> int:
        """
        Returns leg_schedule_bridge_key of the LegBridge created/found.
        """
        goal_leg_schedule_keys = set(leg_schedule.key for leg_schedule in leg_schedules)
        leg_schedule_keys = set()
        leg_schedule_brdige_key = None
        for instance in cls.instances:
            if leg_schedule_brdige_key is None:
                leg_schedule_brdige_key = instance.leg_schedule_bridge_key
            if instance.leg_schedule_bridge_key == leg_schedule_brdige_key:
                leg_schedule_keys.add(instance.leg_key)
            else:
                if leg_schedule_keys == goal_leg_schedule_keys:
                    return leg_schedule_brdige_key
                leg_schedule_brdige_key = None
        return cls._create_new_bridge_from_leg_schedules(leg_schedules)

    @classmethod
    def get_leg_schedules(cls, leg_schedule_bridge_key: int) -> List[LegSchedule]:
        leg_schedule_keys = []
        found = None
        for instance in cls.instances:
            if instance.leg_bridge_key == leg_schedule_bridge_key:
                leg_schedule_keys.append(instance.leg_key)
                found = True
            elif found is not None:
                break
        else:
            raise ValueError(f"No Leg Schedule Bridge with key {leg_schedule_bridge_key} found/")
        return list(map(LegSchedule.get_instance_by_key, leg_schedule_keys))


@dataclass
class VoyageSchedule(BaseModel):
    instances = []
    fields = (
        'Voyage Schedule Key',
        'Voyage Key',
        'Leg Schedule Bridge Key',
    )

    leg_schedule_bridge_key: int = None

    @property
    def voyage_schedule_key(self) -> int:
        return self.key

    @property
    def voyage(self) -> Voyage:
        return Voyage.get_or_create_instance_from_ports(legs_to_ports(self.legs))

    @property
    def voyage_key(self) -> int:
        return self.voyage.key

    @property
    def legs(self) -> List[Leg]:
        return [leg_schedule.leg for leg_schedule in self.leg_schedules]

    @property
    def ports(self) -> List[Port]:
        return self.voyage.ports

    @property
    def leg_schedules(self) -> List[LegSchedule]:
        return LegScheduleBridge.get_leg_schedules(self.leg_schedule_bridge_key)

    @leg_schedules.setter
    def leg_schedules(self, leg_schedules: List[LegSchedule]):
        self.leg_schedule_bridge_key = LegScheduleBridge.get_or_create_new_bridge_from_leg_schedules(leg_schedules)

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
        """
        Randomize the Actual date for both Arrival and Departure dates.
        """
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

    @classmethod
    def create_voyage_schedule_from_ports(cls, ports: List[Port]) -> 'VoyageSchedule':
        # get/create leg
        legs = ports_to_legs(ports)
        # create leg schedules
        leg_schedules = [LegSchedule(leg.key) for leg in legs]
        # create leg schedules
        leg_schedule_bridge = LegScheduleBridge.get_or_create_new_bridge_from_leg_schedules(leg_schedules)
        return VoyageSchedule(leg_schedule_bridge)
