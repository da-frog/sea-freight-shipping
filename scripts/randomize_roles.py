import json
import random
from typing import List, Dict, Callable

import utils


business_entities = utils.read_csv_file('../spreadsheet_data/da-base-OLTP - BusinessEntity.csv')


def convert(list_of_dicts: List[Dict], keys: List[str], callable: Callable):
    for key in keys:
        for dct in list_of_dicts:
            dct[key] = callable(dct[key])


convert(business_entities, ['Business Entity Key'], int)


with open('output.txt', 'w', encoding='utf-8') as f:
    for entity in business_entities:
        if entity['Business Entity Key'] <= 3000:
            # human
            roles = list(set(random.choices(['Consignor', 'Consignee'], [3, 5], k=random.randint(1, 2))))
        elif entity['Business Entity Key'] > 3000:
            # business
            roles = list(set(random.choices([
                'Consignor',
                'Consignee',
                'Consolidator',
                'Transporter',
                'Courier',
            ], [3, 2, 3, 3, 3], k=random.randint(1, 5))))
        f.write(f'{json.dumps(roles)}\n')
