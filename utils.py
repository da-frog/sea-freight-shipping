from typing import List, Dict
import csv


def read_csv_file(filename: str, *, encoding: str = 'utf-8') -> List[Dict]:
    """ Reads a csv file and return a list of dictionaries. """
    data = []
    with open(filename, 'r', encoding=encoding) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data


def trim_file(file: str):
    with open(file, 'r') as f:
        lines = f.read().splitlines()

    trimmed = []
    for line in lines:
        if line == '':
            continue
        trimmed.append(line)

    with open(file, 'w') as f:
        f.write('\n'.join(trimmed))


if __name__ == '__main__':
    trim_file('scrape/test_ports.csv')
