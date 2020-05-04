import csv
import random


def generate_number():
    for i in range(100):
        if i < 10:
            print(f"'0{i}': [],")
        else:
            print(f"'{i}': [],")


data_lst = []
with open('data/harmonized-system.csv') as csv_file:
    data = csv.reader(csv_file, delimiter=',')
    for data_line in data:
        data_lst.append(data_line)

hs_code_lvl6 = []
for data in data_lst:
    # print(f"{data[4]}")
    if data[4] == '6':
        # print(data[1])
        hs_code_lvl6.append(data[1])

for i in range(1000):
    number = random.uniform(0.01, 1)
    print(number)
    # print(random.choice(hs_code_lvl6))

# print(hs_code_lvl6)
