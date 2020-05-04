import csv
import json
from typing import List, Dict, Callable

import utils
import re
from location import Location

bols = utils.read_csv_file('spreadsheet_data/da-base-OLTP - BillOfLading.csv')

addresses = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
commodities = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
containers = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
container_models = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
ports = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Port.csv')
business_entities = utils.read_csv_file('spreadsheet_data/da-base-OLTP - BusinessEntity.csv')

# countries = utils.read_csv_file('data/ISO 3166 (countries).csv')

# cities = utils.read_csv_file('data/worldcities.csv')
# country_pop = utils.read_csv_file('country-pop-cum.csv')


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
# convert(country_pop, ['cumulative'], float)

address_map = {
    address['Address Key']: address
    for address in addresses
}

port_map = {
    port['Port Key']: port
    for port in ports
}


def extract_coords(s: str) -> (str, str):
    m = re.match(r'\(\((-?[0-9.]+), (-?[0-9.]+)\),\)', s)
    if m:
        return m[1], m[2]
    raise ValueError('unrecognized format: ' + s)


world_ports = utils.read_csv_file('data/worldroutes/ports.csv')

convert(world_ports, ['index'], int)


for port in world_ports:
    port['loc'] = Location(*extract_coords(port['coords']))


with open('output.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, list(ports[0].keys()) + ['worldroutes index'])
    writer.writeheader()
    for p in ports:
        loc = Location(address_map[p['Address Key']]['Latitude'], address_map[p['Address Key']]['Longitude'])
        for p2 in world_ports:
            try:
                diff = loc.calculate_distance(p2['loc'])
            except ValueError:
                print(loc)
                print(p2['loc'])
                raise
            if diff < 1:
                print(f'{p2["PORT_NAME"]} == {p["Port Name"]} [{diff:.3f}]')
                p['worldroutes index'] = p2['index']
                break
            if p2["PORT_NAME"].lower() == p["Port Name"].lower():
                print(f'{p2["PORT_NAME"]} == {p["Port Name"]} [{diff:.3f}]')
                p['worldroutes index'] = p2['index']
                break
        else:
            p['worldroutes index'] = ''
            # raise ValueError('No match found for port: ' + str(p))
        writer.writerow(p)