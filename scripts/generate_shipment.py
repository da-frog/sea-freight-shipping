import csv
import json
import random
import time
import datetime
from typing import List, Dict, Callable, Any, Sequence, TypeVar
from operator import itemgetter

from location import Location
from models import *
from dirs import ROOT_DIR
from utils import capwords_to_snake_case


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


def generate_shipment(n: int):
    print('**** main ****')
    x = [bol for bol in BillOfLading._instances if bol.port_of_loading_key is not None]
    alllen = len(x)
    while len(x) > alllen - n:
        # create route
        route_length = random.randint(3, 6)
        route_ports, route_bols = create_route(x, route_length)
        print(f'{len(x)}'.ljust(30) + f'{time.ctime(time.time())}\n')
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
        # if len(all_route_bols) > 6:
        # FIRST PART
        voyage_schedule = VoyageSchedule.create_voyage_schedule_from_ports(route_ports)

        for bol in all_route_bols[:len(all_route_bols) // 2]:
            Shipment(voyage_schedule_key=voyage_schedule.voyage_schedule_key, bill_of_lading_key=bol.bill_of_lading_key)

        # SECOND PART
        voyage_schedule = VoyageSchedule.create_voyage_schedule_from_ports(route_ports)

        for bol in all_route_bols[len(all_route_bols) // 2:]:
            Shipment(voyage_schedule_key=voyage_schedule.voyage_schedule_key, bill_of_lading_key=bol.bill_of_lading_key)
        # else:


def main(n: int):
    load_database()
    Shipment._instances.clear()
    generate_shipment(int(n))
    dump_database(str(n), 'json')
    dump_database(str(n), 'sql')


if __name__ == '__main__':
    main(8000)
    # load_database('500')
    # for model in [
    #     Address,
    #     BillOfLading,
    #     BusinessEntity,
    #     Commodity,
    #     Container,
    #     ContainerModel,
    #     Port,
    #     Shipment,
    #     Vehicle,
    #     Leg,
    #     LegBridge,
    #     Voyage,
    #     LegSchedule,
    #     LegScheduleBridge,
    #     VoyageSchedule
    # ]:
    #     if model._instances:
    #         print(f'dumping {model.__name__}')
    #         model.dump_to_sql(ROOT_DIR / f'database/insert_{capwords_to_snake_case(model.__name__)}.sql')
