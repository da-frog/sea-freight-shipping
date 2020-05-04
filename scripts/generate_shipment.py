import csv
import json
import random
from typing import List, Dict, Callable, Any
from operator import itemgetter

import utils
from location import Location

# bols = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - BillOfLading.csv')
bols = utils.read_csv_file('bol-10000.csv')
addresses = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
commodities = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
containers = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
container_models = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
ports = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Port.csv')
business_entities = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - BusinessEntity.csv')


def convert(list_of_dicts: List[Dict], keys: List[str], callable: Callable):
    for key in keys:
        for dct in list_of_dicts:
            dct[key] = callable(dct[key])


convert(bols, [
    'Bill-of-Lading Key',
    'Consignor Key',
    'Consignee Key',
    'Foreign Transporter Key',
    'Foreign Consolidator Key',
    'Courier Key',
    'Domestic Transporter Key',
    'Domestic Consolidator Key',
    'Place of Receipt Key',
    'Place of Delivery Key',
    'Port of Loading Key',
    'Port of Discharge Key',
    # 'Commodity Key',
    # 'Container Key'
], int)
convert(business_entities, ['Business Entity Key', 'Address Key'], int)
convert(business_entities, ['Roles'], json.loads)
convert(addresses, ['Address Key'], int)
convert(ports, ['Port Key', 'Address Key'], int)

address_map = {
    address['Address Key']: address
    for address in addresses
}

for _port in ports:
    _port['Address'] = address_map[_port['Address Key']]

port_map = {
    port['Port Key']: port
    for port in ports
}

for _bol in bols:
    _bol['Port of Discharge'] = port_map[_bol['Port of Discharge Key']]
    _bol['Port of Loading'] = port_map[_bol['Port of Loading Key']]


def calculate_total_distance(ports: List[Dict[str, Any]], *, key=True) -> float:
    locations = []
    if key:
        for key in ports:
            port = port_map[key]
            try:
                address = port['Address']
            except KeyError:
                address = address_map[port['Address Key']]
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
    with open(filename, 'w', encoding='utf-8', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, ['ports', 'bols'])
        writer.writeheader()
        # voyages = []
        x = bols.copy()
        while len(x) > 0:
            route_length = random.randint(3, 6)
            # print(len(x))
            route_ports, route_bols = create_route(x, route_length)
            # print(len(x))
            # print('\n')
            # print(route_ports)
            # for bol in route_bols:
                # print(get_bol_route_str(bol))

            # print('\n')
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
                            # print(get_bol_route_str(bol))
            voyage = {'ports': route_ports, 'bols': list(map(itemgetter('Bill-of-Lading Key'), route_bols + added_bol))}
            # voyages.append(voyage)
            writer.writerow(voyage)


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
