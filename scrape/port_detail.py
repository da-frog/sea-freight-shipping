from typing import Callable
import time

import requests
from bs4 import BeautifulSoup


def find_address(soup: BeautifulSoup):
    a = soup.find(**{'class': 'table table-bordered'}).find(string='Address:').parent
    address = str(a.next_sibling.next_sibling)[4:-5].split('<br/>')
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


if __name__ == '__main__':
    import csv

    dicts = []
    with open('../data/port-link.text', 'r') as f:
        links = f.read().splitlines()

    for i, link in enumerate(links):
        if i > 50:
            break
        res = requests.get(link)
        soup = BeautifulSoup(res.text, 'html.parser')
        detail = get_port_detail(soup)
        dicts.append(detail)
        print(detail)
        time.sleep(3)

    with open('test_ports.txt', 'w') as f:
        writer = csv.DictWriter(f, dicts[0].keys())
        writer.writeheader()
        writer.writerows(dicts)
