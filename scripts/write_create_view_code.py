from typing import List, TextIO


def write_create_view(source_name: str, view_name: str, source_columns: List[str], view_columns: List[str]):
    print(
        f"create view {view_name} ({', '.join(view_columns)}) as select {', '.join(source_columns)} from {source_name};\ngo")


def write_drop_view(view_name: str):
    print(f"drop view if exists {view_name};\ngo")


def write_file_create_view(file: TextIO, source_name: str, view_name: str, source_columns: List[str],
                           view_columns: List[str]):
    file.write(
        f"create view {view_name} ({', '.join(view_columns)}) as select {', '.join(source_columns)} from {source_name};\ngo")
    file.write('\n')


def write_file_drop_view(file: TextIO, view_name: str):
    file.write(f"drop view if exists {view_name};\ngo")
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
            write_file_create_view(file, table_name.replace(' ', ''), view_name.replace(' ', ''), table_columns,
                                   view_columns)
        else:
            write_drop_view(view_name.replace(' ', ''))
            write_create_view(table_name.replace(' ', ''), view_name.replace(' ', ''), table_columns, view_columns)


if __name__ == '__main__':
    with open('views.txt', 'w') as f:
        main(
            'Date Dimension', '''
            [Date Key]                   
            [Full date description]      
            [Date]                       
            [Day Of Half Year]           
            [Day Of Month]               
            [Day Of Quarter]             
            [Day Of Week]                
            [Day Of Year]                
            [Half Year Of Year]          
            [Month Of Half Year]         
            [Month Of Quarter]           
            [Month Of Year]              
            [Quarter Of Half Year]       
            [Quarter Of Year]            
            [Week Of Half Year]          
            [Week Of Month]              
            [Week Of Quarter]            
            [Week Of Year]               
            [Fiscal Date]                
            [Fiscal Day Of Half Year]    
            [Fiscal Day Of Month]        
            [Fiscal Day Of Quarter]      
            [Fiscal Day Of Week]         
            [Fiscal Day Of Year]         
            [Fiscal Half Year Of Year]   
            [Fiscal Month Of Half Year]  
            [Fiscal Month Of Quarter]    
            [Fiscal Month Of Year]       
            [Fiscal Quarter Of Half Year]
            [Fiscal Quarter Of Year]     
            [Fiscal Week Of Half Year]   
            [Fiscal Week Of Month]       
            [Fiscal Week Of Quarter]     
            [Fiscal Week Of Year]        
            [Calendar Week Ending Date]
            [Day Name]
            [Month Name]
            [Full Day Name]
            [Full Month Name]
            [Fiscal Day Name]
            [Fiscal Month Name]
            [Fiscal Full Day Name]
            [Fiscal Full Month Name]
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
