from typing import List
table_name = 'Date Dimension'
table_columns_text = '''
[Date Key]
[Date]
[Full date description]
[Day of Week]
[Day Number in Calendar Month]
[Day Number in Calendar Year]
[Day Number in Fiscal Month]
[Day Number in Fiscal Year]
[Last Day in Month Indicator]
[Calendar Week Ending Date]
[Calendar Week]
[Calendar Week Number in Year]
[Calendar Month Name]
[Calendar Month Number in Year]
[Calendar Year-Month (YYYY-MM)]
[Calendar Quarter]
[Calendar Year-Quarter]
[Calendar Year]
[Fiscal Week]
[Fiscal Week Number in Year]
[Fiscal Month]
[Fiscal Year-Month]
[Fiscal Quarter]
[Fiscal Year-Quarter]
[Fiscal Year]
'''
view_names_text = '''
Scheduled Voyage Departure Date
Scheduled Voyage Arrival Date
Scheduled Shipment Departure Date
Scheduled Shipment Arrival Date
Actual Voyage Departure Date
Actual Voyage Arrival Date
Actual Shipment Departure Date
Actual Shipment Arrival Date
'''

table_name = 'Port Dimension'
table_columns_text = '''
[Port Key]
[Port Name]
[Port Type]
[Port Country]
[Port City]
[Port Address]
[Port Telephone]
'''
view_names_text = '''
Voyage Origin Port
Voyage Destination Port
Shipment Origin Port
Shipment Destination Port
'''

table_name = 'Business Entity Dimension'
table_columns_text = '''
[Business Entity Key]
[Business Entity Name]
[Business Entity Telephone]
[Business Entity Fax]
[Business Entity Email]
[Business Entity Address]
[Business Entity City]
[Business Entity Country]
[Business Entity ZIP code]
'''
view_names_text = '''
Consignor
Foreign Transporter
Foreign Consolidator
Shipper
Domestic Consolidator
Domestic Transporter
Consignee
'''

view_names = [line.strip() for line in view_names_text.splitlines() if line.strip()]

table_columns = [line.strip() for line in table_columns_text.splitlines() if line.strip()]


def write_create_view(source_name: str, view_name: str, source_columns: List[str], view_columns: List[str]):
    print(f"CREATE VIEW {view_name} ({', '.join(view_columns)}) AS SELECT ({', '.join(source_columns)}) FROM {source_name};")


for view_name in view_names:
    view_columns = [
        f'[{col[1:-1]}]'.replace(table_name.split('Dimension')[0].strip(), view_name)
        for col in table_columns
    ]
    write_create_view(table_name, view_name.replace(' ', ''), table_columns, view_columns)
    # print()

