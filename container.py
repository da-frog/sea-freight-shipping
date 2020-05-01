import csv

if __name__ == '__main__':

    with open('numbers.txt', 'r') as f:
        numbers = map(int, f.read().splitlines())

    with open('data/da-base-OLTP - ContainerModel.csv', 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        lst = []
        for row in reader:
            lst.append(row)
        for number in numbers:
            found = False
            print(number, end=' ')
            for row in lst:
                if int(row['Serial Number Range Start']) <= number <= int(row['Serial Number Range End']):
                    print(row['ISO Type Code'], end=' ')
                    found = True
            print()
            if not found:
                print('not found for number: ' + str(number))
