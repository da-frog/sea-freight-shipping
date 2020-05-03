from typing import List, Dict, Callable
import csv
import random
from operator import itemgetter
import json
import re

import utils
from bill_of_lading import get_bol_check_digit, random_bol

import city


addresses = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
commodities = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
containers = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
container_models = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
ports = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Port.csv')
business_entities = utils.read_csv_file('spreadsheet_data/da-base-OLTP - BusinessEntity.csv')

countries = utils.read_csv_file('data/ISO 3166 (countries).csv')

cities = utils.read_csv_file('data/worldcities.csv')
country_pop = utils.read_csv_file('country-pop-cum.csv')


def convert(list_of_dicts: List[Dict], keys: List[str], callable: Callable):
    for key in keys:
        for dct in list_of_dicts:
            dct[key] = callable(dct[key])


convert(business_entities, ['Business Entity Key'], int)
convert(addresses, ['Address Key'], int)
convert(country_pop, ['cumulative'], float)


def random_country_according_to_population() -> str:
    """ Returns country's iso2/alpha-2 code """
    r = random.random()
    for row in country_pop:
        if r <= row['cumulative']:
            return row['alpha-2']


address_map = {
    address['Address Key']: address
    for address in addresses
}


def get_business_entities_from_country(country: str) -> List[int]:
    """ Returns list of Business Entity Keys

    :param country: iso2/alpha-2 code
    :return:
    """
    lst = []
    for entity in business_entities:
        if address_map[int(entity['Address Key'])]['Alpha 2'] == country:
             lst.append(entity['Business Entity Key'])
    return lst


country_1 = random_country_according_to_population()
country_2 = random_country_according_to_population()


