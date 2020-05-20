from utils import read_csv_file
from frogsql import writetable

data = read_csv_file('data/country-and-continent-codes-list-csv_csv.csv')

for row in data:
    try:
        row['Country_Number'] = int(row['Country_Number'])
    except ValueError:
        row['Country_Number'] = None

writetable(data, 'CountryAndContinentCodes', 'sql_scripts/insert_country_and_continent_codes.sql')
