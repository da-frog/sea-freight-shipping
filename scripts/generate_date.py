import csv
import json
import random
import time
from typing import List, Dict, Callable, Any, Sequence, TypeVar
from operator import itemgetter
import numpy as np

from jsoncompat import Date, TimeDelta
from location import Location
from dirs import ROOT_DIR

from models import *


def main(n: int):
    load_database(str(n))

    voyage_schedules: List[VoyageSchedule] = VoyageSchedule._instances.copy()
    random.shuffle(voyage_schedules)

    vehicles: List[Vehicle] = Vehicle._instances.copy()
    random.shuffle(vehicles)

    date = Date(2018, 1, 1)
    for voyage_schedule in voyage_schedules:
        if random.random() <= 0.95:
            date = date + TimeDelta(days=np.random.poisson(2))
        print(date)
        voyage_schedule.scheduled_departure_date = date

        try:
            vehicle = vehicles.pop(-1)
        except IndexError:
            vehicles: List[Vehicle] = Vehicle._instances.copy()
            random.shuffle(vehicles)
            vehicle = vehicles.pop(-1)
        voyage_schedule.cascade_scheduled_date(vehicle)
        voyage_schedule.cascade_actual_date(vehicle)
        shipments = Shipment.get_instances_from_voyage_schedule_key(voyage_schedule.voyage_schedule_key)
        for shipment in shipments:
            shipment.vehicle = vehicle
            d = shipment.voyage_schedule.scheduled_departure_date - TimeDelta(days=3+np.random.poisson(4))
            print(d.__class__.__name__)
            shipment.bill_of_lading.issued_date = d
            print(shipment.bill_of_lading.issued_date)

    dump_database(str(n))
    dump_database(str(n), 'json')


if __name__ == '__main__':
    main(500)
    # load_database('500', 'json')


