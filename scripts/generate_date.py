import csv
import json
import random
import time
import datetime
from typing import List, Dict, Callable, Any, Sequence, TypeVar
from operator import itemgetter

from ..utils import km_to_mile
from ..location import Location
from ..dirs import ROOT_DIR

from ..models import *


def get_data_set(name: str):
    BillOfLading.load_from_csv(ROOT_DIR/'scripts/bol-10000.csv')
    Address.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - Address.csv')
    BusinessEntity.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - BusinessEntity.csv')
    Commodity.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - Commodity.csv')
    Container.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - Container.csv')
    ContainerModel.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - ContainerModel.csv')
    Port.load_from_csv(ROOT_DIR/'spreadsheet_data/da-base-OLTP - Port.csv')
    Voyage.load_from_csv(ROOT_DIR/f'database/{name}/voyages.csv')
    VoyageSchedule.load_from_csv(ROOT_DIR/f'database/{name}/voyages_schedules.csv')
    Leg.load_from_csv(ROOT_DIR/f'database/{name}/leg.csv')
    LegBridge.load_from_csv(ROOT_DIR/f'database/{name}/leg_bridge.csv')
    LegSchedule.load_from_csv(ROOT_DIR/f'database/{name}/leg_schedule.csv')
    LegScheduleBridge.load_from_csv(ROOT_DIR/f'database/{name}/leg_schedule_bridge.csv')


