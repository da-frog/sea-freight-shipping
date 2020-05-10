from typing import List, TextIO


def write_create_view(source_name: str, view_name: str, source_columns: List[str], view_columns: List[str]):
    print(f"create view {view_name} ({', '.join(view_columns)}) as select {', '.join(source_columns)} from {source_name};")


def write_drop_view(view_name: str):
    print(f"drop view if exists {view_name};")


def write_file_create_view(file: TextIO, source_name: str, view_name: str, source_columns: List[str], view_columns: List[str]):
    file.write(f"create view {view_name} ({', '.join(view_columns)}) as select {', '.join(source_columns)} from {source_name};")
    file.write('\n')


def write_file_drop_view(file: TextIO, view_name: str):
    file.write(f"drop view if exists {view_name};")
    file.write('\n')


def main(table_name: str, table_columns_text: str, view_names_text: str, file: TextIO = None):
    view_names = [line.strip() for line in view_names_text.splitlines() if line.strip()]
    table_columns = [line.strip() for line in table_columns_text.splitlines() if line.strip()]

    for view_name in view_names:
        view_columns = [
            f'[{col[1:-1]}]'.replace(table_name.split('Dimension')[0].strip(), view_name)
            for col in table_columns
        ]
        if file is not None:
            write_file_drop_view(file, view_name.replace(' ', ''))
            write_file_create_view(file, table_name.replace(' ', ''), view_name.replace(' ', ''), table_columns, view_columns)
        else:
            write_drop_view(view_name.replace(' ', ''))
            write_create_view(table_name.replace(' ', ''), view_name.replace(' ', ''), table_columns, view_columns)


if __name__ == '__main__':
    with open('views.txt', 'w') as f:
        main(
            'Date Dimension', '''
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
            ''', '''
            Scheduled Voyage Departure Date
            Scheduled Voyage Arrival Date
            Scheduled Shipment Departure Date
            Scheduled Shipment Arrival Date
            Actual Voyage Departure Date
            Actual Voyage Arrival Date
            Actual Shipment Departure Date
            Actual Shipment Arrival Date
            ''',
            file=f
        )
        print()
        main(
            'Port Dimension', '''
            [Port Key]
            [Port Name]
            [Port Type]
            [Port Country]
            [Port City]
            [Port Address]
            [Port Telephone]
            ''', '''
            Voyage Origin Port
            Voyage Destination Port
            Shipment Origin Port
            Shipment Destination Port
            ''',
            file=f
        )
        print()
        main(
            'Business Entity Dimension', '''
            [Business Entity Key]
            [Business Entity Name]
            [Business Entity Telephone]
            [Business Entity Fax]
            [Business Entity Email]
            [Business Entity Address]
            [Business Entity City]
            [Business Entity Country]
            [Business Entity ZIP code]
            ''', '''
            Consignor
            Foreign Transporter
            Foreign Consolidator
            Shipper
            Domestic Consolidator
            Domestic Transporter
            Consignee
            ''',
            file=f
    )
