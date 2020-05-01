import csv


_cities = []
_city_names = []
_city_names_ascii = []
_city_names_ascii_lower = []


def ensure_loaded():
    if not _cities:
        load_cities()


def load_cities():
    global _cities
    _cities = []
    with open('data/worldcities.csv', 'r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            _cities.append(row)
            _city_names.append(row['city'])
            _city_names_ascii.append(row['city_ascii'])
            _city_names_ascii_lower.append(row['city_ascii'].lower())


def is_city(city_name: str) -> bool:
    ensure_loaded()
    return city_name.lower() in _city_names_ascii_lower
