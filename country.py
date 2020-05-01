import csv


_countries = []
_country_names = []
_country_names_lower = []

def ensure_loaded():
    if not _countries:
        load_countries()
    if not _country_names:
        load_countries()


def load_countries():
    global _countries
    _countries = []
    with open('data/ISO 3166 (countries).csv', 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            _countries.append(row)
            _country_names.append(row['name'])


def is_country(country_name: str) -> bool:
    global _country_names_lower
    ensure_loaded()
    if not _country_names_lower:
        _country_names_lower = list(map(str.lower, _country_names))
    return country_name.lower() in _country_names_lower

