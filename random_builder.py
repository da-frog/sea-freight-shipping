import random
import csv


def random_builder(end: int):
    start = 1
    while start <= end:
        with open('data/temp-vessel-Ship-builder.csv', encoding="utf-8") as csv_file:
            reader = csv.reader(csv_file)
            random_row = random.choice(list(reader))
            print(f'{random_row[3]}')
            start += 1


random_builder(1200)
