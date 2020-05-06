from .base import BaseModel

from .address import Address
from .bill_of_lading import BillOfLading
from .business_entity import BusinessEntity
from .commodity import Commodity
from .container import Container
from .container_model import ContainerModel
from .port import Port
from .shipment import Shipment
from .vehicle import Vehicle
from .voyage import Leg, LegBridge, Voyage, LegSchedule, LegScheduleBridge, VoyageSchedule

from dirs import ROOT_DIR


def load_database(dataset: str = None, mode: str = 'csv'):
    if mode == 'csv':
        method_name = 'load_from_csv'
    elif mode == 'json':
        method_name = 'load_from_json'
    else:
        raise AssertionError('no such mode \'' + mode + "'")

    BillOfLading.load_from_csv(ROOT_DIR / 'scripts/bol-10000.csv')
    Address.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - Address.csv')
    BusinessEntity.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - BusinessEntity.csv')
    Commodity.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - Commodity.csv')
    Container.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - Container.csv')
    ContainerModel.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - ContainerModel.csv')
    Port.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - Port.csv')
    Vehicle.load_from_csv(ROOT_DIR / 'spreadsheet_data/da-base-OLTP - Vehicle.csv')

    if dataset is not None:
        for cls in [
            Leg,
            LegBridge,
            Voyage,
            LegSchedule,
            LegScheduleBridge,
            VoyageSchedule,
            Shipment,
        ]:
            print(f'loading {cls.__name__}')
            method = getattr(cls, method_name)
            method(ROOT_DIR / f'database/{dataset}/{cls.__name__}.{mode}')


def dump_database(dataset: str, mode: str = 'csv'):
    if mode == 'csv':
        method_name = 'dump_to_csv'
    elif mode == 'json':
        method_name = 'dump_to_json'
    else:
        raise AssertionError('no such mode \'' + mode + "'")

    for cls in [
        Shipment,
        Voyage,
        Leg,
        LegBridge,
        LegSchedule,
        LegScheduleBridge,
        VoyageSchedule,
    ]:
        print(f'dumping {cls.__name__}')
        method = getattr(cls, method_name)
        method(ROOT_DIR / f'database/{dataset}/{cls.__name__}.{mode}')
