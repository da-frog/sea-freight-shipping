import json
import random
from typing import List, Dict, Callable

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


convert(business_entities, ['Business Entity Key'], int)
convert(business_entities, ['Roles'], json.loads)
convert(addresses, ['Address Key'], int)
convert(country_pop, ['cumulative'], float)


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


address_map = {
    address['Address Key']: address
    for address in addresses
}


def get_business_entities_from_country(business_entities_, country: str) -> List[int]:
    """ Returns list of Business Entity Keys

    :param country: iso2/alpha-2 code
    :return:
    """
    lst = []
    for entity in business_entities_:
        if address_map[int(entity['Address Key'])]['Alpha 2'] == country:
            lst.append(entity['Business Entity Key'])
    return lst


def get_business_entities_from_role(business_entities_, role: str) -> List[int]:
    """ Returns list of Business Entity Keys

    :param role:
    :return:
    """
    lst = []
    for entity in business_entities_:
        if role in entity['Role']:
            lst.append(entity['Business Entity Key'])
    return lst


# roles = [
#     'Consignor',
#     'Consignee',
#     'Consolidator',
#     'Transporter',
#     'Courier',
# ]


country_1 = RandomCountry.random_country_according_to_population()
country_2 = RandomCountry.random_country_according_to_population()

get_business_entities_from_role(business_entities, 'Consignor')

get_business_entities_from_country(business_entities, country_1)

# cosignor, foreign_transpoter, foreign_consolidator
# place_of_receipt
# port_of_loading
#
# consignee, domestic_transporter, domestic_consolidator
# place_of_delivery
# port_of_discharge
#
# courier
#
# commodity
