import csv
import json
import random
import time
import datetime
from typing import List, Dict, Callable, Any, Sequence, TypeVar
from operator import itemgetter

import utils
from location import Location

from models import *


def load_database():
    # BillOfLading.load_from_csv('../spreadsheet_data/da-base-OLTP - BillOfLading.csv')
    BillOfLading.load_from_csv('bol-10000.csv')
    Address.load_from_csv('../spreadsheet_data/da-base-OLTP - Address.csv')
    BusinessEntity.load_from_csv('../spreadsheet_data/da-base-OLTP - BusinessEntity.csv')
    Commodity.load_from_csv('../spreadsheet_data/da-base-OLTP - Commodity.csv')
    Container.load_from_csv('../spreadsheet_data/da-base-OLTP - Container.csv')
    ContainerModel.load_from_csv('../spreadsheet_data/da-base-OLTP - ContainerModel.csv')
    Port.load_from_csv('../spreadsheet_data/da-base-OLTP - Port.csv')
    Vehicle.load_from_csv('../spreadsheet_data/da-base-OLTP - Vehicle.csv')


def calculate_total_distance(ports: List[Dict[str, Any]], *, key=True) -> float:
    locations = []
    if key:
        for key in ports:
            port = Port.get_instance_by_key(key)
            try:
                address = port['Address']
            except KeyError:
                address = Address.get_instance_by_key(port.address_key)
            location = Location(address['Latitude'], address['Longitude'])
            locations.append(location)
    else:
        raise NotImplementedError
    sum = 0
    for i in range(len(locations) - 1):
        sum += locations[i].calculate_distance(locations[i + 1])
    return sum


def get_bol_route_str(bol: Dict[str, Any]) -> str:
    return (
        f"{bol['Port of Loading']['Port Name']} [{bol['Port of Loading Key']}] "
        f"--> {bol['Port of Discharge']['Port Name']} [{bol['Port of Discharge Key']}]"
    )


def create_route(bols, n: int = 5):
    current_bols = bols.copy()
    route_ports = []
    route_bols = []

    def register_bol(bol):
        route_bols.append(bol)
        current_bols.remove(bol)
        bols.remove(bol)
        # print(route_ports)
        # print(get_bol_route_str(bol))

    def remove_from_consideration(bol):
        current_bols.remove(bol)

    while len(route_ports) < n:
        try:
            bol = random.choice(current_bols)
        except IndexError:
            break
        loading_key = bol['Port of Loading Key']
        discharge_key = bol['Port of Discharge Key']

        if not route_ports:
            route_ports.append(loading_key)
            route_ports.append(discharge_key)
            register_bol(bol)

        else:
            if bol['Port of Discharge Key'] in route_ports:
                if bol['Port of Loading Key'] in route_ports:
                    loading_index = route_ports.index(loading_key)
                    discharge_index = route_ports.index(discharge_key)
                    if loading_index < discharge_index:
                        register_bol(bol)
                    else:
                        remove_from_consideration(bol)
                else:
                    # discharge in, loading not
                    discharge_index = route_ports.index(discharge_key)
                    x = {}
                    for i in range(discharge_index + 1):
                        possible_route = route_ports[0:i] + [loading_key] + route_ports[i:]
                        x[calculate_total_distance(possible_route)] = possible_route
                    route_ports = x[min(x.keys())]
                    register_bol(bol)
            elif bol['Port of Loading Key'] in route_ports:
                # discharge not in, loading in
                loading_index = route_ports.index(loading_key)
                x = {}
                re = list(reversed(route_ports))
                for i in range(loading_index + 1):
                    possible_route = re[0:i] + [discharge_key] + re[i:]
                    x[calculate_total_distance(possible_route)] = possible_route
                route_ports = list(reversed(x[min(x.keys())]))
                register_bol(bol)
            else:
                # discharge not in, loading not in
                remove_from_consideration(bol)
    return route_ports, route_bols


def main(filename: str):
    legs = []
    leg_key = []
    leg_groups = []
    leg_group_key = []
    leg_schedules = []
    leg_schedule_key = []
    leg_schedule_groups = []
    leg_schedule_group_key = []
    voyages = []
    voyage_key = 1
    voyage_schedules = []
    voyage_schedule_key = 1
    shipments = []
    shipment_key = 1

    def deasssemble_voyage(voyage: Dict[str, Any]):
        nonlocal voyages, legs, leg_groups
        nonlocal voyage_key, leg_key, leg_group_key
        voyage['Leg Group Key'] = leg_group_key
        for i in range(len(voyage['port keys']) - 1):
            leg = {
                'Leg Key': leg_key,
                'Origin Port': voyage['port keys'][i],
                'Destination Port': voyage['port keys'][i + 1],
                'Leg Miles': voyage['leg miles'][i],
                'Leg Fees': '',
            }
            leg_group = {
                'Leg Group Key': leg_group_key,
                'Leg Key': leg_key,
            }
            legs.append(leg)
            leg_key += 1
            leg_groups.append(leg_group)
        leg_group_key += 1

    def deasssemble_voyage_schedule(voyage_schedule: Dict[str, Any]):
        nonlocal leg_key, leg_schedule_key, leg_schedule_group_key
        voyage = voyage_schedule['voyage']
        voyage_schedule['Leg Schedule Group Key'] = leg_schedule_group_key
        for i in range(len(voyage['port keys'])-1):
            leg_schedule = {
                'Leg Schedule Key': leg_schedule_key,
                'Leg Key': leg_schedule_key,
                'Scheduled Origin Port Departure Date': voyage_schedule['scheduled origin port departure dates'][i],
                'Scheduled Destination Port Arrival Date': voyage_schedule['scheduled destination port arrival dates'][i],
                'Actual Origin Port Departure Date': voyage_schedule['actual origin port departure dates'][i],
                'Actual Destination Port Arrival Date': voyage_schedule['actual destination port arrival dates'][i],
            }
            leg_schedule_group = {
                'Leg Schedule Group Key': leg_schedule_group_key,
                'Leg Schedule Key': leg_schedule_key,
            }
            leg_key += 1
            leg_schedules.append(leg_schedule)
            leg_schedule_key += 1
            leg_schedule_groups.append(leg_schedule_group)
        leg_schedule_group_key += 1

    # voyages = []
    x = bols.copy()
    while len(x) > 0:
        # create voyage
        route_length = random.randint(3, 6)
        route_ports, route_bols = create_route(x, route_length)

        added_bol = []
        for bol in x:
            loading_key = bol['Port of Loading Key']
            discharge_key = bol['Port of Discharge Key']

            if bol['Port of Discharge Key'] in route_ports:
                if bol['Port of Loading Key'] in route_ports:
                    loading_index = route_ports.index(loading_key)
                    discharge_index = route_ports.index(discharge_key)
                    if loading_index < discharge_index:
                        added_bol.append(bol)
                        x.remove(bol)

        # create voyage dict
        voyage = {'Voyage Key': voyage_key, 'port keys': route_ports,
                  'bols': route_bols + added_bol,
                  'leg miles': calculate_leg_miles(route_ports)}
        voyage['bol keyes'] = list(map(itemgetter('Bill-of-Lading Key'), voyage['bols']))

        deasssemble_voyage(voyage)
        voyages.append(voyage)
        voyage_key += 1

        # split voyage to voyage schedules
        if len(voyage['bol keys']) > 6:
            random.shuffle(voyage['bol keys'])

            # FIRST PART
            voyage_schedule = {
                'Voyage Schedule Key': voyage_schedule_key,
                'Voyage Key': voyage['Voyage Key'],
                'scheduled origin port departure dates': [],
                'scheduled destination port arrival dates': [],
                'actual origin port departure dates': [],
                'actual destination port arrival dates': [],
            }

            deasssemble_voyage_schedule(voyage_schedule)
            voyage_schedules.append(voyage_schedule)
            voyage_schedule_key += 1

            for bol_key in voyage['bol keys'][:len(voyage['bol keys'] // 2)]:
                shipment = {
                    'Shipment Key': shipment_key,
                    'Voyage Schedule Key': voyage_schedule['Voyage Schedule Key'],
                    'Vehicle Key': '',
                    'Bill-of-Lading Key': bol_key,
                }
                shipments.append(shipment)
                shipment_key += 1

            # SECOND PART
            voyage_schedule = {
                'Voyage Schedule Key': voyage_schedule_key,
                'Voyage Key': voyage['Voyage Key'],
                'scheduled origin port departure dates': [],
                'scheduled destination port arrival dates': [],
                'actual origin port departure dates': [],
                'actual destination port arrival dates': [],
            }

            deasssemble_voyage_schedule(voyage_schedule)
            voyage_schedules.append(voyage_schedule)
            voyage_schedule_key += 1

            for bol_key in voyage['bol keys'][len(voyage['bol keys'] // 2):]:
                shipment = {
                    'Shipment Key': shipment_key,
                    'Voyage Schedule Key': voyage_schedule['Voyage Schedule Key'],
                    'Vehicle Key': '',
                    'Bill-of-Lading Key': bol_key,
                }
                shipments.append(shipment)
                shipment_key += 1




T = TypeVar('T')


def get_location_from_port_key(port_key: int) -> Location:
    address = address_map[port_map[port_key]['Address Key']]
    return Location(address['Latitude'], address['Longitude'])


def calculate_leg_miles(port_keys: Sequence[T]) -> List[float]:
    kms = []
    locations = list(map(get_location_from_port_key, port_keys))
    for i in range(len(locations) - 1):
        kms.append(locations[i].calculate_distance(locations[i + 1]))
    return list(map(km_to_mile, kms))


def km_to_mile(x: float) -> float:
    return x * 0.621371192


if __name__ == '__main__':
    main('voyages.csv')
    # x = bols.copy()
    # print(len(x))
    # route_ports, route_bols = create_route(x, 6)
    # print(len(x))
    # print('\n')
    # print(route_ports)
    # for bol in route_bols:
    #     print(get_bol_route_str(bol))
    #
    # print('\n')
    #
    # for bol in x:
    #     loading_key = bol['Port of Loading Key']
    #     discharge_key = bol['Port of Discharge Key']
    #
    #     if bol['Port of Discharge Key'] in route_ports:
    #         if bol['Port of Loading Key'] in route_ports:
    #             # loading_index = route_ports.index(loading_key)
    #             # discharge_index = route_ports.index(discharge_key)
    #             # if loading_index < discharge_index:
    #                 print(get_bol_route_str(bol))
