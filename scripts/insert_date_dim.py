from datetime import timedelta
from models.date import DateDimension, Date

from dirs import ROOT_DIR

date = Date(2016, 1, 1)
for _ in range(2000):
    DateDimension(date)
    date += timedelta(days=1)
    # if date == Date(2021, 1, 1):
    #     break
print(date)

DateDimension.dump_to_sql(ROOT_DIR / 'sql_scripts/insert_date.sql')
