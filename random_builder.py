import random
import csv


def random_builder(end: int):
    print("country,city,name")
    start = 1
    while start <= end:
        with open('../data/temp vessel-Ship-builder.csv', encoding="utf-8") as csv_file:
            reader = csv.reader(csv_file)
            random_row = random.choice(list(reader))
            print(f'\t{random_row[0]},{random_row[1]},{random_row[2]}')
            start += 1


random_builder(100)
