import csv
import time
from itertools import islice
from typing import Callable

import requests
from bs4 import BeautifulSoup

from city import is_country, is_city


def find_address(soup: BeautifulSoup):
    a = soup.find(**{'class': 'table table-bordered'}).find(string='Address:').parent
    address = str(a.next_sibling.next_sibling)[4:-5].split('<br/>')
    if address == ['']:
        address = None
    return address


def get_port_detail(soup: BeautifulSoup) -> dict:
    minsoup = soup.find(id='port_det')
    dct = {}
    for query, key, func in [
        ('Port Authority:', None, None),
        ('Phone:', None, None),
        ('Fax:', None, None),
        ('800 Number:', None, None),
        ('Email:', None, None),
        ('Web Site:', None, None),
        ('Latitude:', None, None),
        ('Longitude:', None, None),
        ('UN/LOCODE:', None, None),
        ('Port Type:', None, None),
        ('Port Size:', None, None),
        ('Max Draft:', None, None),
    ]:
        value = minsoup.find(string=query).parent.next_sibling.next_sibling.string
        if func is not None:
            assert isinstance(func, Callable)
            value = func(value)
        if key is not None:
            dct[key] = value
        else:
            dct[query] = value
    dct['Address'] = find_address(soup)
    return dct


def parse_address(address: list) -> dict:
    dct = {}
    if address is None:
        return dct

    for item in reversed(address):
        if dct.get('Country') is None and is_country(item):
            dct['Country'] = item
        elif dct.get('City') is None and is_city(item):
            dct['City'] = item
        elif dct.get('Address Line 2') is None:
            if item != address[-1]:
                dct['Address Line 2'] = item
        elif dct.get('Address Line 1') is None:
            dct['Address Line 1'] = item
        else:
            print("ERRRRRRRRRR")

    return dct


def scrape_port_(link: str) -> dict:
    res = requests.get(link)
    soup = BeautifulSoup(res.text, 'html.parser')

    dct = get_port_detail(soup)

    address_dct = parse_address(dct['Address'])
    dct.update(address_dct)

    port_name = soup.find('div', class_='page-heading').string.split(' (')[0]
    try:
        city_name, tmp = soup.find('div', class_='page-heading').string[8:].split(' (')
        country_name = tmp[:-1]
        if dct.get('City') is None and is_city(port_name):
            dct['City'] = port_name
        if dct.get('Country') is None and is_country(country_name):
            dct['Country'] = country_name
    except ValueError:
        pass
    return dct


def scrape_ports(input_file: str, output_file: str, start: int, stop: int, sleeptime: int = 3, limit: int = 3):
    """ Scrape from links in input_file from [start, stop] """
    dicts = []
    with open(input_file, 'r') as f:
        links = f.read().splitlines()

    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        detail = scrape_port_(links[start - 1])
        print(f'scraping link {links[start - 1]}')
        dicts.append(detail)
        print(detail)
        writer = csv.DictWriter(csvfile,
                                ['Port Authority:', 'Phone:', 'Fax:', '800 Number:', 'Email:', 'Web Site:', 'Latitude:',
                                 'Longitude:', 'UN/LOCODE:', 'Port Type:', 'Port Size:', 'Max Draft:', 'Address',
                                 'Address Line 1', 'Address Line 2', 'Country', 'City'])
        writer.writeheader()
        writer.writerow(detail)

        for i, link in enumerate(islice(links, start, stop)):
            print(f'scraping link {link}')
            j = 0
            s = 2
            try_again = True
            while try_again:
                j += 1
                try:
                    detail = scrape_port_(link)
                except Exception:
                    if j < limit:
                        print(f'fail#{j}, trying again in {s} seconds')
                        time.sleep(s)
                        s += 1
                        continue
                    else:
                        print(f'fail#{j}, aborting')
                        print(f'skipping, failed at around {start+i+1}')
                        try_again = False
                else:
                    break
            else:
                csvfile.write(f'DUMMY ROW for {link}\n')
                continue
            dicts.append(detail)
            print(detail)
            writer.writerow(detail)
            time.sleep(sleeptime)


if __name__ == '__main__':
    scrape_ports('../data/port-link.text', 'test_ports.txt', 1, 20, 1)
