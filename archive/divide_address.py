from typing import List, Dict
import csv
from operator import itemgetter
import json
import re

import utils

import city


# addresses = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
# commodities = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
# containers = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
# container_models = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')
#  # = utils.read_csv_file('spreadsheet_data/da-base-OLTP - Address.csv')

def decode_list(s: str) -> List[str]:
    s = s[1:-1]
    parts = []
    sub1 = None
    sub2 = None
    for c in s:
        if c == "'":
            if sub1 is not None:
                parts.append(''.join(sub1))
                sub1 = None
            elif sub2 is not None:
                sub2.append(c)
            else:
                sub1 = []
        elif c == '"':
            if sub2 is not None:
                parts.append(''.join(sub2))
                sub2 = None
            elif sub1 is not None:
                sub1.append(c)
            else:
                sub2 = []
        else:
            if sub1 is not None:
                sub1.append(c)
            elif sub2 is not None:
                sub2.append(c)

    for ignore in ['/n', '']:
        if ignore in parts:
            parts.remove(ignore)

    # print(parts, s)

    return parts

    # address = list(part[1:-1] for part in s[1:-1].split(', '))
    # return address


def probably_zip_code(s: str) -> bool:
    s = s.replace(' ', '')
    num_count = 0
    for c in s:
        if c in '0123456789':
            num_count += 1
    if num_count / len(s) > 0.5:
        return True
    return False


def has_num(s: str) -> bool:
    for c in s:
        if c in '0123456789':
            return True
    return False


def get_num(s: str) -> str:
    m = re.match('[0-9]+', s)
    if m is not None:
        return m[0]
    return ''


def get_zip_code(s: str) -> str:
    m = re.match('[A-Z]*[ -][0-9]+(-[0-9]*)?', s)
    if m is not None:
        return m[0]
    return ''


raw_ports = utils.read_csv_file('spreadsheet_data/raw port data - Sheet1.csv')


with open('output.csv', 'w', encoding='utf-8', newline='') as f:

    keys = list(raw_ports[0].keys()) + ['ZIP Code']
    writer = csv.DictWriter(f, keys)
    writer.writeheader()

    for rp in raw_ports:
        s: str = rp['Address']

        if s != '':
            address = decode_list(s)

            # x = []
            # for i, part in enumerate(address):
            #     if i == 0:
            #         continue
            #     z = get_zip_code(part)
            #     if z:
            #         rp['ZIP Code'] = z
            #         t = part.replace(z, '')
            #         if t:
            #             x.append(t)
            #     else:
            #         x.append(part)
            # address = x

            street = []
            for i, elem in enumerate(address):
                if i == 0:
                    continue
                if elem.lower().startswith('bp'):
                    continue
                if elem.lower().startswith('cp'):
                    continue
                if has_num(elem):
                    rp['ZIP Code'] = get_num(elem)
                if rp['City'] in elem:
                    continue
                if rp['Country'] in elem:
                    continue
                street.append(elem)

            if len(street) == 2:
                rp['Address Line 1'] = street[0]
                rp['Address Line 2'] = street[1]
            elif len(street) == 1:
                rp['Address Line 1'] = street[0]
                rp['Address Line 2'] = ''
            elif len(street) == 0:
                rp['Address Line 1'] = ''
                rp['Address Line 2'] = ''
            elif len(street) == 3:
                # if probably_zip_code(street[2]):
                #     rp['ZIP Code'] = street[2]
                #     rp['Address Line 1'] = street[0]
                #     rp['Address Line 2'] = street[1]
                # else:
                rp['Address Line 1'] = street[0] + ' ' + street[1]
                rp['Address Line 2'] = street[2]
            # elif len(street) == 4:
            #     if probably_zip_code(street[3]):
            #         rp['ZIP Code'] = street[3]
            #         rp['Address Line 1'] = street[0] + ' ' + street[1]
            #         rp['Address Line 2'] = street[2]
            #     elif has_num(street[3]):
            #         rp['ZIP Code'] = street[3]
            #         rp['Address Line 1'] = street[0] + ' ' + street[1]
            #         rp['Address Line 2'] = street[2]
            #     else:
            #         print(address)
            #         print(street)
            #         print()
            #         print(rp)
            #         raise AssertionError('Please handle me')
            else:
                print(address)
                print(street)
                print()
                print(rp)
                raise AssertionError('Please handle me')

        writer.writerow(rp)
