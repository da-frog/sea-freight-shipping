import csv
import random


data = []

MIN_NUM = 106300
MAX_NUM = 965999

from check_n_rand.check_digits import get_check_digit


def ensure_loaded():
    global data
    if not data:
        load_data()


def load_data():
    global data
    data = []
    with open('database/da-base-OLTP - ContainerModel.csv', 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)


def get_valid_serials(n: int):
    ensure_loaded()
    numbers = set()
    while len(numbers) < n:
        number = random.randrange(MIN_NUM, MAX_NUM + 1)
        for row in data:
            if int(row['Serial Number Range Start']) <= number <= int(row['Serial Number Range End']):
                numbers.add(number)
    return numbers


def generate_container_instance(n: int):
    ensure_loaded()
    instances = []
    for number in get_valid_serials(n):
        choices = []
        for row in data:
            if int(row['Serial Number Range Start']) <= number <= int(row['Serial Number Range End']):
                # print(number, end=' ')
                instance = [row['Owner Code'], number, get_check_digit(row['Owner Code'], number), row['ISO Size Code'], row['ISO Type Code']]
                choices.append(instance)
                # print(instance, end=' ')
        if not choices:
            continue
        instances.append(random.choice(choices))
        # print()
    return instances


def save_to_file(filename: str, lst):
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(','.join(['Owner Code', 'Serial Number', 'Check Digit', 'ISO Size Code', 'ISO Type Code']))
        f.write('\n')
        for row in lst:
            f.write(','.join(map(str, row)))
            f.write('\n')


if __name__ == '__main__':
    i = generate_container_instance(5000)
    save_to_file('container.csv', i)
    # print(i)
