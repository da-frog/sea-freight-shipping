USE FreightShippingDW;


drop view if exists ScheduledVoyageDepartureDateDimension;
go

create view ScheduledVoyageDepartureDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Departure Date Key];
go


drop view if exists ScheduledVoyageArrivalDateDimension;
go

create view ScheduledVoyageArrivalDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Voyage Arrival Date Key];
go


drop view if exists ScheduledShipmentDepartureDateDimension;
go

create view ScheduledShipmentDepartureDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Departure Date Key];
go


drop view if exists ScheduledShipmentArrivalDateDimension;
go

create view ScheduledShipmentArrivalDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Scheduled Shipment Arrival Date Key];
go


drop view if exists ActualVoyageDepartureDateDimension;
go

create view ActualVoyageDepartureDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Voyage Departure Date Key];
go


drop view if exists ActualVoyageArrivalDateDimension;
go

create view ActualVoyageArrivalDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Voyage Arrival Date Key];
go


drop view if exists ActualShipmentDepartureDateDimension;
go

create view ActualShipmentDepartureDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
from DateDimension DD
         join ShippingTransportFact STF on DD.[Date Key] = STF.[Actual Shipment Departure Date Key];
go


drop view if exists ActualShipmentArrivalDateDimension;
go

create view ActualShipmentArrivalDateDimension
            ([Scheduled Voyage Departure Date Key], [Full date description], [Scheduled Voyage Departure Date],
             [Day Of Half Year], [Day Of Month], [Day Of Quarter], [Day Of Week], [Day Of Year], [Half Year Of Year],
             [Month Of Half Year], [Month Of Quarter], [Month Of Year], [Quarter Of Half Year], [Quarter Of Year],
             [Week Of Year], [Fiscal Scheduled Voyage Departure Date], [Fiscal Day Of Half Year], [Fiscal Day Of Month],
             [Fiscal Day Of Quarter], [Fiscal Day Of Week], [Fiscal Day Of Year], [Fiscal Half Year Of Year],
             [Fiscal Month Of Half Year], [Fiscal Month Of Quarter], [Fiscal Month Of Year],
             [Fiscal Quarter Of Half Year], [Fiscal Quarter Of Year], [Fiscal Week Of Year],
             [Calendar Week Ending Scheduled Voyage Departure Date], [Day Name], [Month Name], [Full Day Name],
             [Full Month Name], [Fiscal Day Name], [Fiscal Month Name], [Fiscal Full Day Name],
             [Fiscal Full Month Name])
as
select [Date Key],
       [Full date description],
       [Date],
       [Day Of Half Year],
       [Day Of Month],
       [Day Of Quarter],
       [Day Of Week],
       [Day Of Year],
       [Half Year Of Year],
       [Month Of Half Year],
       [Month Of Quarter],
       [Month Of Year],
       [Quarter Of Half Year],
       [Quarter Of Year],
       [Week Of Year],
       [Fiscal Date],
       [Fiscal Day Of Half Year],
       [Fiscal Day Of Month],
       [Fiscal Day Of Quarter],
       [Fiscal Day Of Week],
       [Fiscal Day Of Year],
       [Fiscal Half Year Of Year],
       [Fiscal Month Of Half Year],
       [Fiscal Month Of Quarter],
       [Fiscal Month Of Year],
       [Fiscal Quarter Of Half Year],
       [Fiscal Quarter Of Year],
       [Fiscal Week Of Year],
       [Calendar Week Ending Date],
       [Day Name],
       [Month Name],
       [Full Day Name],
       [Full Month Name],
       [Fiscal Day Name],
       [Fiscal Month Name],
       [Fiscal Full Day Name],
       [Fiscal Full Month Name]
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
