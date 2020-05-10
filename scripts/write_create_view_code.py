from typing import List

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
Scheduled Voyage Departure Date Key
Scheduled Voyage Arrival Date Key
Scheduled Shipment Departure Date Key
Scheduled Shipment Arrival Date Key
Actual Voyage Departure Date Key
Actual Voyage Arrival Date Key
Actual Shipment Departure Date Key
Actual Shipment Arrival Date Key
'''

view_names = [line.strip() for line in view_names_text.splitlines() if line.strip()]

table_columns = [line.strip() for line in table_columns_text.splitlines() if line.strip()]


def write_create_view(source_name: str, view_name: str, source_columns: List[str], view_columns: List[str]):
    print(f"CREATE VIEW {view_name} ({', '.join(view_columns)}) AS SELECT ({', '.join(source_columns)}) FROM {source_name};")


for view_name in view_names:
    view_columns = [
        f'[{view_name} {col[1:-1]}]'
        for col in table_columns
    ]
    write_create_view('DateDimension', view_names[0].replace(' ', ''), table_columns, view_columns)
    print()

