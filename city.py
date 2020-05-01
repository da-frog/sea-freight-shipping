import csv

from dirs import DATA_DIR


_cities = []
_city_names = []
_city_names_ascii = []
_city_names_ascii_lower = []
_country_names = []
_country_names_lower = []


def ensure_loaded():
    if not _cities:
        load_cities()


def load_cities():
    global _cities, _city_names, _city_names_ascii, _city_names_ascii_lower, _country_names, _country_names_lower
    _cities = []
    with open(DATA_DIR / 'worldcities.csv', 'r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            _cities.append(row)
            _city_names.append(row['city'])
            _city_names_ascii.append(row['city_ascii'])
            _city_names_ascii_lower.append(row['city_ascii'].lower())
            _country_names.append(row['country'].lower())
            _country_names_lower.append(row['country'].lower())


def is_city(city_name: str) -> bool:
    ensure_loaded()
    return city_name.lower() in _city_names_ascii_lower


def is_country(country_name: str) -> bool:
    ensure_loaded()
    return country_name.lower() in _country_names_lower
