import datetime
from dataclasses import dataclass

from jsoncompat import Date

from .base import BaseModel

_MONTH_NAMES = [None, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
_DAY_NAMES = [None, "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

_FULL_MONTH_NAMES = [None, "January", "February", "March", "April", "May", "June",
                     "July", "August", "September", "October", "November", "December"]
_FULL_DAY_NAMES = [None, "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]


@dataclass
class DateDimension(BaseModel):
    _instances = []
    fields = (
        'Date Key',
        'Date',
        'Full date description',
        'Day of Week',
        'Day Number in Calendar Month',
        'Day Number in Calendar Year',
        'Day Number in Fiscal Month',
        'Day Number in Fiscal Year',
        'Last Day in Month Indicator',
        'Calendar Week Ending Date',
        'Calendar Week Number in Year',
        'Calendar Month Name',
        'Calendar Month Number in Year',
        'Calendar Year-Month (YYYY-MM)',
        'Calendar Quarter',
        'Calendar Year-Quarter',
        'Calendar Year',
        'Fiscal Week',
        'Fiscal Week Number in Year',
        'Fiscal Month',
        'Fiscal Year-Month',
        'Fiscal Quarter',
        'Fiscal Year-Quarter',
        'Fiscal Year',
    )

    date: Date

    @property
    def date_key(self) -> int:
        return self.key

    @property
    def full_date_description(self) -> str:
        return self.date.ctime()

    @property
    def day_of_week(self) -> str:
        return _FULL_DAY_NAMES[self.date.isoweekday()]

    @property
    def day_number_in_calendar_month(self) -> int:
        return self.date.day

    @property
    def day_number_in_calendar_year(self) -> int:
        return ((self.date - datetime.date(self.date.year, 1, 1)) + datetime.timedelta(days=1)).days

    @property
    def day_number_in_fiscal_month(self) -> int:
        return

    @property
    def day_number_in_fiscal_year(self) -> int:
        return

    @property
    def last_day_in_month_indicator(self) -> str:
        if (self.date + datetime.timedelta(days=1)).month != self.date.month:
            return 'Last day in month'
        return 'Not the last day in month'

    @property
    def calendar_week_ending_date(self) -> str:
        # Sunday
        return str(self.date + (datetime.timedelta(days=7-self.date.isoweekday())))

    @property
    def calendar_week_number_in_year(self) -> int:
        return self.date.isocalendar()[1]

    @property
    def calendar_month_name(self) -> str:
        return _FULL_MONTH_NAMES[self.date.month]

    @property
    def calendar_month_number_in_year(self) -> int:
        return self.date.month

    @property
    def calendar_year_month_yyyy_mm(self) -> str:
        return self.date.isoformat()[:-3]

    @property
    def calendar_quarter(self) -> str:
        return

    @property
    def calendar_year_quarter(self) -> str:
        return

    @property
    def calendar_year(self) -> int:
        return self.date.year

    @property
    def fiscal_week(self) -> int:
        return

    @property
    def fiscal_week_number_in_year(self) -> int:
        return

    @property
    def fiscal_month(self) -> str:
        return

    @property
    def fiscal_year_month(self) -> str:
        return

    @property
    def fiscal_quarter(self) -> str:
        return

    @property
    def fiscal_year_quarter(self) -> str:
        return

    @property
    def fiscal_year(self) -> int:
        return
