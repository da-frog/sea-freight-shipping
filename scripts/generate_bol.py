import csv
import json
import random
import numpy as np
from typing import List, Dict, Callable, TypeVar, Sequence

import utils

addresses = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
commodities = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
containers = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
container_models = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Address.csv')
ports = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - Port.csv')
business_entities = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - BusinessEntity.csv')

countries = utils.read_csv_file('../data/ISO 3166 (countries).csv')

cities = utils.read_csv_file('../data/worldcities.csv')
country_pop = utils.read_csv_file('country-pop-cum.csv')


def convert(list_of_dicts: List[Dict], keys: List[str], callable: Callable):
    for key in keys:
        for dct in list_of_dicts:
            dct[key] = callable(dct[key])


convert(business_entities, ['Business Entity Key', 'Address Key'], int)
convert(business_entities, ['Roles'], json.loads)
convert(addresses, ['Address Key'], int)
convert(country_pop, ['cumulative'], float)

address_map = {
    address['Address Key']: address
    for address in addresses
}


class RandomCountry:
    set = 0

    @staticmethod
    def random_country_according_to_population() -> str:
        """ Returns country's iso2/alpha-2 code """
        r = (random.random() / 2) + RandomCountry.set

        if RandomCountry.set == 0:
            RandomCountry.set = 0.5
        else:
            RandomCountry.set = 0

        for row in country_pop:
            if r <= row['cumulative']:
                return row['alpha-2']


def get_addresses_by_country(addresses_, country: str) -> List[dict]:
    lst = []
    for address in addresses_:
        if address['Alpha 2'] == country:
            lst.append(address)
    return lst


def get_ports_by_country(ports_, country: str) -> List[dict]:
    lst = []
    for port in ports_:
        if address_map[int(port['Address Key'])]['Alpha 2'] == country:
            lst.append(port)
    return lst


def get_business_entities_from_country(business_entities_, country: str) -> List[dict]:
    """ Filter Business Entity by Country

    :param country: iso2/alpha-2 code
    :return:
    """
    lst = []
    for entity in business_entities_:
        if address_map[int(entity['Address Key'])]['Alpha 2'] == country:
            lst.append(entity)
    return lst


def get_business_entities_from_role(business_entities_, role: str) -> List[dict]:
    """ Filter Business Entity by Role

    :param role:
    :return:
    """
    lst = []
    for entity in business_entities_:
        if role in entity['Roles']:
            lst.append(entity)
    return lst


# roles = [
#     'Consignor',
#     'Consignee',
#     'Consolidator',
#     'Transporter',
#     'Courier',
# ]


def get_consignor(business_entities_, country: str):
    a = get_business_entities_from_country(business_entities_, country)
    b = get_business_entities_from_role(a, 'Consignor')
    if b:
        return random.choice(b)
    return random.choice(a)


def get_consignee(business_entities_, country: str):
    a = get_business_entities_from_country(business_entities_, country)
    b = get_business_entities_from_role(a, 'Consignee')
    if b:
        return random.choice(b)
    return random.choice(a)


def get_transporter(business_entities_, country: str):
    a = get_business_entities_from_role(business_entities_, 'Transporter')
    b = get_business_entities_from_country(a, country)
    if b:
        return random.choice(b)
    return random.choice(a)


def get_consolidator(business_entities_, country: str):
    a = get_business_entities_from_role(business_entities_, 'Consolidator')
    b = get_business_entities_from_country(a, country)
    if b:
        return random.choice(b)
    return random.choice(a)


def get_courier(business_entities_, country: str):
    a = get_business_entities_from_role(business_entities_, 'Courier')
    b = get_business_entities_from_country(a, country)
    if b:
        return random.choice(b)
    return random.choice(a)


T = TypeVar('T')


def sample_with_normal_bias(seq: Sequence[T]) -> T:
    n = len(seq)
    r = np.random.normal(n/2, n/2/1.96)
    nearest_int = int(round(r, 0))
    if nearest_int < 0:
        return seq[0]
    if nearest_int >= n:
        return seq[-1]
    return seq[nearest_int]


def sample_with_uniform_sum_bias(seq: Sequence[T]) -> T:
    n = len(seq)
    if n == 1:
        return seq[0]
    if n % 2 == 0:
        r1 = random.randint(0, n//2)
        r2 = random.randint(0, n//2)
    else:
        r1 = random.randint(0, n//2 + 1)
        r2 = random.randint(0, n//2)
    return seq[r1 + r2]


hot_ports = {}


def generate_bol():
    dct = {}
    country_1 = RandomCountry.random_country_according_to_population()
    country_2 = RandomCountry.random_country_according_to_population()
    consignor = get_consignor(business_entities, country_1)
    dct['Consignor Key'] = consignor['Business Entity Key']
    consignee = get_consignee(business_entities, country_2)
    dct['Consignee Key'] = consignee['Business Entity Key']
    dct['Domestic Transporter Key'] = get_transporter(business_entities, country_1)['Business Entity Key']
    dct['Foreign Transporter Key'] = get_transporter(business_entities, country_2)['Business Entity Key']
    dct['Domestic Consolidator Key'] = get_consolidator(business_entities, country_1)['Business Entity Key']
    dct['Foreign Consolidator Key'] = get_consolidator(business_entities, country_2)['Business Entity Key']
    dct['Courier Key'] = get_courier(business_entities, random.choice([country_1, country_2]))['Business Entity Key']

    port_1 = get_ports_by_country(ports, country_1)
    dct['Port of Discharge Key'] = sample_with_normal_bias(port_1)['Port Key']

    port_2 = get_ports_by_country(ports, country_2)
    dct['Port of Loading Key'] = sample_with_normal_bias(port_2)['Port Key']

    dct['Place of Receipt Key'] = consignor['Address Key']
    dct['Place of Delivery Key'] = consignee['Address Key']
    return dct


def main(n: int = 1000):
    with open(f'bol-{n}.csv', 'w', encoding='utf-8', newline='') as outfile:
        writer = csv.DictWriter(outfile, ['Bill-of-Lading Key', 'Bill-of-Lading Number', 'Issued Date', 'Consignor Key',
                                          'Consignee Key', 'Foreign Transporter Key', 'Foreign Consolidator Key',
                                          'Courier Key', 'Domestic Transporter Key', 'Domestic Consolidator Key',
                                          'Ship Mode', 'Place of Receipt Key', 'Place of Delivery Key', 'Port of Loading Key',
                                          'Port of Discharge Key', 'Commodity Key', 'Container Key', 'Incoterm',
                                          'Expected Tariffs', 'Actual Tariffs']
                                )
        writer.writeheader()
        for i in range(n):
            while True:
                try:
                    bol = generate_bol()
                except IndexError:
                    pass
                else:
                    break
            writer.writerow(bol)


if __name__ == '__main__':
    main(10000)
