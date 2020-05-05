from typing import List, Dict, Any, TypeVar, Callable
import csv
import json
from abc import ABC, abstractmethod
from numbers import Number

from utils import read_csv_file
from location import Location


def km_to_mile(x: float) -> float:
    return x * 0.621371192


def knots_to_kmh(x: float) -> float:
    pass


class BaseModel:
    instances = []  # Don't forget to overwrite this

    @classmethod
    def get_instance_by_key(cls, key: int):
        return cls.instances[key - 1]

    @property
    def key(self) -> int:
        return self.__class__.instances.index(self)

    def __getitem__(self, item):
        try:
            return self.__dict__[item]
        except KeyError:
            raise

    def __setitem__(self, key, value):
        self.__dict__[key] = value


class Address(BaseModel):
    instances = []
    fields = (
        'Address Key',
        'Address Line 1',
        'Address Line 2',
        'City',
        'Country',
        'Alpha',
        'ZIP Code',
        'latitude',
        'longitude',
    )

    def __init__(self):
        self.address_line_1: str = ''
        self.address_line_2: str = ''
        self.city: str = ''
        self.country: str = ''
        self.alpha: str = ''
        self.zip_code: str = ''
        self.latitude: str = ''
        self.longitude: str = ''

    @property
    def address_key(self) -> int:
        return self.key

    @property
    def location(self) -> Location:
        return Location(self.latitude, self.longitude)


class Port(BaseModel):
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


class Leg(BaseModel):
    instances = []

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
    def leg_miles(self):
        return km_to_mile(self.origin_port.location.calculate_distance(self.destination_port.location))

    def get_leg_fees(self, ship_speed_knots: Number):
        return


class VoyageSchedule:
    instances = []

    def __init__(self):
        self.dict = {

        }
        self.ports = []
        self.scheduled_departure_dates = []
        self.scheduled_arrival_dates = []
        self.actual_departure_dates = []
        self.actual_arrival_dates = []

    def __getitem__(self, item):
        try:
            return self.dict['item']
        except KeyError:
            pass

    @property
    def scheduled_start_date(self):
        return self.legs[0].scheduled_origin_port_departure_date

    @property
    def scheduled_end_date(self):
        return self.legs[0].scheduled_origin_port_departure_date

    def dump_to_csv(self, filename: str):
        pass

    @classmethod
    def load_from_csv(cls, filename: str):
        pass
