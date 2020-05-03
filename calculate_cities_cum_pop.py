import csv
from decimal import Decimal, InvalidOperation
from operator import itemgetter

import utils


cities = utils.read_csv_file('data/worldcities.csv')


def decimal_or_zero(x):
    try:
        return Decimal(x)
    except InvalidOperation:
        if x == '':
            return Decimal('0')
        raise


total_pop = sum(map(decimal_or_zero, map(itemgetter('population'), cities)))

country_pop = {}

with open('country-pop-cum.csv', 'w', encoding='utf-8', newline='') as f:
    keys = ['alpha-2', 'percent', 'cumulative']
    writer = csv.DictWriter(f, keys)
    writer.writeheader()
    for c in cities:
        percent = decimal_or_zero(c['population']) / total_pop
        try:
            country_pop[c['iso2']] += percent
        except KeyError:
            country_pop[c['iso2']] = percent
    cum = 0
    for iso, percent in country_pop.items():
        cum += percent
        writer.writerow({'alpha-2': iso, 'percent': percent, 'cumulative': cum})
