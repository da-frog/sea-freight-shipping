import csv
import json
import random
import time
import datetime
from typing import List, Dict, Callable, Any, Sequence, TypeVar
from operator import itemgetter

from utils import km_to_mile
from location import Location

from models import *


def load_database():
    # BillOfLading.load_from_csv('../spreadsheet_data/da-base-OLTP - BillOfLading.csv')
    BillOfLading.load_from_csv('scripts/bol-10000.csv')
    Address.load_from_csv('spreadsheet_data/da-base-OLTP - Address.csv')
    BusinessEntity.load_from_csv('spreadsheet_data/da-base-OLTP - BusinessEntity.csv')
    Commodity.load_from_csv('spreadsheet_data/da-base-OLTP - Commodity.csv')
    Container.load_from_csv('spreadsheet_data/da-base-OLTP - Container.csv')
    ContainerModel.load_from_csv('spreadsheet_data/da-base-OLTP - ContainerModel.csv')
    Port.load_from_csv('spreadsheet_data/da-base-OLTP - Port.csv')
    # Vehicle.load_from_csv('../spreadsheet_data/da-base-OLTP - Vehicle.csv')


def calculate_total_distance(ports: List[Port], *, key=True) -> float:
    locations = []
    if key:
        for port in ports:
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


def create_route(bols: List[BillOfLading], n: int = 5) -> (List[Port], List[BillOfLading]):
    """
    Removes used Bill-of-Lading from `bols`.
    If there isn't enough Bill-of-Ladings, return early.
    """
    current_bols: List[BillOfLading] = bols.copy()
    route_ports: List[Port] = []
    route_bols: List[Port] = []

    def register_bol(bol: BillOfLading):
        route_bols.append(bol)
        current_bols.remove(bol)
        bols.remove(bol)
        # print(route_ports)
        # print(get_bol_route_str(bol))

    def remove_from_consideration(bol: BillOfLading):
        current_bols.remove(bol)

    while len(route_ports) < n:
        try:
            bol: BillOfLading = random.choice(current_bols)
        except IndexError:
            break
        port_of_loading = bol.port_of_loading
        port_of_discharge = bol.port_of_discharge

        if not route_ports:
            route_ports.append(bol.port_of_loading)
            route_ports.append(bol.port_of_discharge)
            register_bol(bol)

        else:
            if port_of_discharge in route_ports:
                if port_of_loading in route_ports:
                    loading_index = route_ports.index(port_of_loading)
                    discharge_index = route_ports.index(port_of_discharge)
                    if loading_index < discharge_index:
                        register_bol(bol)
                    else:
                        remove_from_consideration(bol)
                else:
                    # discharge in, loading not
                    discharge_index = route_ports.index(port_of_discharge)
                    x = {}
                    for i in range(discharge_index + 1):
                        possible_route = route_ports[0:i] + [port_of_loading] + route_ports[i:]
                        x[calculate_total_distance(possible_route)] = possible_route
                    route_ports = x[min(x.keys())]
                    register_bol(bol)
            elif port_of_loading in route_ports:
                # discharge not in, loading in
                loading_index = route_ports.index(port_of_loading)
                x = {}
                re = list(reversed(route_ports))
                for i in range(loading_index + 1):
                    possible_route = re[0:i] + [port_of_discharge] + re[i:]
                    x[calculate_total_distance(possible_route)] = possible_route
                route_ports = list(reversed(x[min(x.keys())]))
                register_bol(bol)
            else:
                # discharge not in, loading not in
                remove_from_consideration(bol)
    return route_ports, route_bols


def main():
    print('**** main ****')
    x = BillOfLading._instances.copy()
    while len(x) > 0:
        # create route
        route_length = random.randint(3, 6)
        route_ports, route_bols = create_route(x, route_length)
        print(f'{len(x)}\n')
        # add bols to route
        added_bol = []
        for bol in x:
            bol: BillOfLading
            port_of_loading = bol.port_of_loading
            port_of_discharge = bol.port_of_discharge

            if port_of_discharge in route_ports:
                if port_of_loading in route_ports:
                    loading_index = route_ports.index(port_of_loading)
                    discharge_index = route_ports.index(port_of_discharge)
                    if loading_index < discharge_index:
                        added_bol.append(bol)
                        x.remove(bol)

        # create voyage
        voyage = Voyage()
        voyage.ports = route_ports

        all_route_bols = route_bols + added_bol
        random.shuffle(all_route_bols)

        # split voyage to voyage schedules
        if len(all_route_bols) > 6:
            # FIRST PART
            voyage_schedule = VoyageSchedule.create_voyage_schedule_from_ports(route_ports)

            for bol in route_bols[:len(route_bols) // 2]:
                Shipment(voyage_schedule_key=voyage_schedule.voyage_schedule_key, bill_of_lading_key=bol.bill_of_lading_key)

            # SECOND PART
            voyage_schedule = VoyageSchedule.create_voyage_schedule_from_ports(route_ports)

            for bol in route_bols[len(route_bols) // 2:]:
                Shipment(voyage_schedule_key=voyage_schedule.voyage_schedule_key, bill_of_lading_key=bol.bill_of_lading_key)
        # else:


if __name__ == '__main__':
    load_database()
    main()

def dump():
    Voyage.dump_to_csv('voyages.csv')
    LegBridge.dump_to_csv('leg_bridge.csv')
    Leg.dump_to_csv('leg.csv')
    VoyageSchedule.dump_to_csv('voyage_schedules.csv')
    LegScheduleBridge.dump_to_csv('leg_schedule_bridge.csv')
    LegSchedule.dump_to_csv('leg_schedule.csv')
    Port.dump_to_csv('port.csv')

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
