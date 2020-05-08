import random
from models import BillOfLading, Container, Commodity, load_database

load_database('8000', 'json')

iterable = BillOfLading._instances.__iter__()

containers = Container._instances.copy()
commodities = Commodity._instances.copy()
random.shuffle(containers)
random.shuffle(commodities)
containers = containers.__iter__()
commodities = commodities.__iter__()
for bol in BillOfLading._instances:
    bol: BillOfLading
    try:
        bol.container_key = containers.__next__().container_key
        bol.commodity_key = commodities.__next__().commodity_key
        if random.random() <= 0.05:
            containers = Container._instances.copy()
            commodities = Commodity._instances.copy()
            random.shuffle(containers)
            random.shuffle(commodities)
            containers = containers.__iter__()
            commodities = commodities.__iter__()
    except StopIteration:
        containers = Container._instances.copy()
        commodities = Commodity._instances.copy()
        random.shuffle(containers)
        random.shuffle(commodities)
        containers = containers.__iter__()
        commodities = commodities.__iter__()
        bol.container_key = containers.__next__().container_key
        bol.commodity_key = commodities.__next__().commodity_key

BillOfLading.dump_to_sql('BOL-new.sql')
