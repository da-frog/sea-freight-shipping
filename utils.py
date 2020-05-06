from typing import List, Dict, TypeVar, Iterable, Tuple
import csv
from itertools import tee, zip_longest

T = TypeVar('T')


def read_csv_file(filename: str, *, encoding: str = 'utf-8') -> List[Dict]:
    """ Reads a csv file and return a list of dictionaries. """
    data = []
    with open(filename, 'r', encoding=encoding) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data


def write_csv_file(filename: str, *, encoding: str = 'utf-8', data: List[Dict]):
    """ Write a list of dictionaries to csv file. """
    with open(filename, 'w', encoding=encoding) as csvfile:
        writer = csv.DictWriter(csvfile, data[0].keys())
        writer.writeheader()
        for d in data:
            writer.writerow(d)


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


def knots_to_kmh(x: float) -> float:
    return x * 1.852


def km_to_mile(x: float) -> float:
    return x * 0.621371192


def pairwise(iterable: Iterable[T]) -> Iterable[Tuple[T, T]]:
    """
    s -> (s0,s1), (s1,s2), (s2, s3), ...

    Taken from https://docs.python.org/3/library/itertools.html#itertools-recipes
    """
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)
