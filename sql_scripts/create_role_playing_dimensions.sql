USE FreightShippingDW;


drop view if exists ScheduledVoyageDepartureDateDimension;
go

create view ScheduledVoyageDepartureDateDimension
            ([Scheduled Voyage Departure Date Key], [Scheduled Voyage Departure Date], [Full date description],
             [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Departure Date Key];
go


drop view if exists ScheduledVoyageArrivalDateDimension;
go

create view ScheduledVoyageArrivalDateDimension
            ([Scheduled Voyage Arrival Date Key], [Scheduled Voyage Arrival Date], [Full date description],
             [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Scheduled Voyage Arrival Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Voyage Arrival Date Key];
go


drop view if exists ScheduledShipmentDepartureDateDimension;
go

create view ScheduledShipmentDepartureDateDimension
            ([Scheduled Shipment Departure Date Key], [Scheduled Shipment Departure Date], [Full date description],
             [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Scheduled Shipment Departure Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Departure Date Key];
go


drop view if exists ScheduledShipmentArrivalDateDimension;
go

create view ScheduledShipmentArrivalDateDimension
            ([Scheduled Shipment Arrival Date Key], [Scheduled Shipment Arrival Date], [Full date description],
             [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Scheduled Shipment Arrival Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Arrival Date Key];
go


drop view if exists ActualVoyageDepartureDateDimension;
go

create view ActualVoyageDepartureDateDimension
            ([Actual Voyage Departure Date Key], [Actual Voyage Departure Date], [Full date description], [Day of Week],
             [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Actual Voyage Departure Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Voyage Departure Date Key];
go


drop view if exists ActualVoyageArrivalDateDimension;
go

create view ActualVoyageArrivalDateDimension
            ([Actual Voyage Arrival Date Key], [Actual Voyage Arrival Date], [Full date description], [Day of Week],
             [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Actual Voyage Arrival Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Voyage Arrival Date Key];
go


drop view if exists ActualShipmentDepartureDateDimension;
go

create view ActualShipmentDepartureDateDimension
            ([Actual Shipment Departure Date Key], [Actual Shipment Departure Date], [Full date description],
             [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Actual Shipment Departure Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Shipment Departure Date Key];
go


drop view if exists ActualShipmentArrivalDateDimension;
go

create view ActualShipmentArrivalDateDimension
            ([Actual Shipment Arrival Date Key], [Actual Shipment Arrival Date], [Full date description], [Day of Week],
             [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month],
             [Day Number in Fiscal Year], [Last Day in Month Indicator],
             [Calendar Week Ending Actual Shipment Arrival Date], [Calendar Week], [Calendar Week Number in Year],
             [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)],
             [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year],
             [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year])
as
select [Date Key],
       [Date],
       [Full date description],
       [Day of Week],
       [Day Number in Calendar Month],
       [Day Number in Calendar Year],
       [Day Number in Fiscal Month],
       [Day Number in Fiscal Year],
       [Last Day in Month Indicator],
       [Calendar Week Ending Date],
       [Calendar Week],
       [Calendar Week Number in Year],
       [Calendar Month Name],
       [Calendar Month Number in Year],
       [Calendar Year-Month (YYYY-MM)],
       [Calendar Quarter],
       [Calendar Year-Quarter],
       [Calendar Year],
       [Fiscal Week],
       [Fiscal Week Number in Year],
       [Fiscal Month],
       [Fiscal Year-Month],
       [Fiscal Quarter],
       [Fiscal Year-Quarter],
       [Fiscal Year]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Shipment Arrival Date Key];
go


drop view if exists VoyageOriginPortDimension;
go

create view VoyageOriginPortDimension
            ([Voyage Origin Port Key], [Voyage Origin Port Name], [Voyage Origin Port Type],
             [Voyage Origin Port Country], [Voyage Origin Port City], [Voyage Origin Port Address],
             [Voyage Origin Port Telephone])
as
select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]
from PortDimension PD
         join ShippingTransportFact STF on PD.[Port Key] = STF.[Voyage Origin Port Key];
go


drop view if exists VoyageDestinationPortDimension;
go

create view VoyageDestinationPortDimension
            ([Voyage Destination Port Key], [Voyage Destination Port Name], [Voyage Destination Port Type],
             [Voyage Destination Port Country], [Voyage Destination Port City], [Voyage Destination Port Address],
             [Voyage Destination Port Telephone])
as
select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]
from PortDimension PD
         join ShippingTransportFact STF on PD.[Port Key] = STF.[Voyage Destination Port Key];
go


drop view if exists ShipmentOriginPortDimension;
go

create view ShipmentOriginPortDimension
            ([Shipment Origin Port Key], [Shipment Origin Port Name], [Shipment Origin Port Type],
             [Shipment Origin Port Country], [Shipment Origin Port City], [Shipment Origin Port Address],
             [Shipment Origin Port Telephone])
as
select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]
from PortDimension PD
         join ShippingTransportFact STF on PD.[Port Key] = STF.[Shipment Origin Port Key];
go


drop view if exists ShipmentDestinationPortDimension;
go

create view ShipmentDestinationPortDimension
            ([Shipment Destination Port Key], [Shipment Destination Port Name], [Shipment Destination Port Type],
             [Shipment Destination Port Country], [Shipment Destination Port City], [Shipment Destination Port Address],
             [Shipment Destination Port Telephone])
as
select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]
from PortDimension PD
         join ShippingTransportFact STF on PD.[Port Key] = STF.[Shipment Destination Port Key];
go


drop view if exists ConsignorDimension;
go

create view ConsignorDimension
            ([Consignor Key], [Consignor Name], [Consignor Telephone], [Consignor Fax], [Consignor Email],
             [Consignor Address], [Consignor City], [Consignor Country], [Consignor ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Consignor Key];
go


drop view if exists ForeignTransporterDimension;
go

create view ForeignTransporterDimension
            ([Foreign Transporter Key], [Foreign Transporter Name], [Foreign Transporter Telephone],
             [Foreign Transporter Fax], [Foreign Transporter Email], [Foreign Transporter Address],
             [Foreign Transporter City], [Foreign Transporter Country], [Foreign Transporter ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Foreign Transporter Key];
go


drop view if exists ForeignConsolidatorDimension;
go

create view ForeignConsolidatorDimension
            ([Foreign Consolidator Key], [Foreign Consolidator Name], [Foreign Consolidator Telephone],
             [Foreign Consolidator Fax], [Foreign Consolidator Email], [Foreign Consolidator Address],
             [Foreign Consolidator City], [Foreign Consolidator Country], [Foreign Consolidator ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Foreign Consolidator Key];
go


drop view if exists ShipperDimension;
go

create view ShipperDimension
            ([Shipper Key], [Shipper Name], [Shipper Telephone], [Shipper Fax], [Shipper Email], [Shipper Address],
             [Shipper City], [Shipper Country], [Shipper ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Shipper Key];
go


drop view if exists DomesticConsolidatorDimension;
go

create view DomesticConsolidatorDimension
            ([Domestic Consolidator Key], [Domestic Consolidator Name], [Domestic Consolidator Telephone],
             [Domestic Consolidator Fax], [Domestic Consolidator Email], [Domestic Consolidator Address],
             [Domestic Consolidator City], [Domestic Consolidator Country], [Domestic Consolidator ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Domestic Consolidator Key];
go


drop view if exists DomesticTransporterDimension;
go

create view DomesticTransporterDimension
            ([Domestic Transporter Key], [Domestic Transporter Name], [Domestic Transporter Telephone],
             [Domestic Transporter Fax], [Domestic Transporter Email], [Domestic Transporter Address],
             [Domestic Transporter City], [Domestic Transporter Country], [Domestic Transporter ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Domestic Transporter Key];
go


drop view if exists ConsigneeDimension;
go

create view ConsigneeDimension
            ([Consignee Key], [Consignee Name], [Consignee Telephone], [Consignee Fax], [Consignee Email],
             [Consignee Address], [Consignee City], [Consignee Country], [Consignee ZIP code])
as
select [Business Entity Key],
       [Business Entity Name],
       [Business Entity Telephone],
       [Business Entity Fax],
       [Business Entity Email],
       [Business Entity Address],
       [Business Entity City],
       [Business Entity Country],
       [Business Entity ZIP code]
from BusinessEntityDimension BED
         join ShippingTransportFact STF on BED.[Business Entity Key] = STF.[Consignee Key];
go
