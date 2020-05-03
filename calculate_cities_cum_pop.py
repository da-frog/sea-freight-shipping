import csv
from operator import itemgetter

import utils


cities = utils.read_csv_file('data/worldcities.csv')


def float_or_zero(x):
    try:
        return float(x)
    except ValueError:
        return 0


total_pop = sum(map(float_or_zero, map(itemgetter('population'), cities)))

with open('country-pop-cum.csv', 'w', encoding='utf-8', newline='') as f:
    keys = ['alpha-2', 'percent', 'cumulative']
    writer = csv.DictWriter(f, keys)
    writer.writeheader()
    dct = {}
    cum = 0
    for c in cities:
        dct['alpha-2'] = c['iso2']
        percent = float_or_zero(c['population']) / total_pop
        cum += percent
        dct['percent'] = percent
        dct['cumulative'] = cum
        writer.writerow(dct)
