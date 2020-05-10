USE FreightShippingDW;

IF OBJECT_ID('dbo.ShippingTransportFact', 'U') IS NOT NULL
    DROP TABLE ShippingTransportFact;
GO

IF OBJECT_ID('dbo.BusinessEntityDimension', 'U') IS NOT NULL
    DROP TABLE BusinessEntityDimension;
GO

IF OBJECT_ID('dbo.CommodityDimension', 'U') IS NOT NULL
    DROP TABLE CommodityDimension;
GO

IF OBJECT_ID('dbo.ContainerDimension', 'U') IS NOT NULL
    DROP TABLE ContainerDimension;
GO

IF OBJECT_ID('dbo.CountrySpecificDateOutrigger', 'U') IS NOT NULL
    DROP TABLE CountrySpecificDateOutrigger;
GO

IF OBJECT_ID('dbo.DateDimension', 'U') IS NOT NULL
    DROP TABLE DateDimension;
GO

IF OBJECT_ID('dbo.PortDimension', 'U') IS NOT NULL
    DROP TABLE PortDimension;
GO

IF OBJECT_ID('dbo.ShipModeDimension', 'U') IS NOT NULL
    DROP TABLE ShipModeDimension;
GO



create table BusinessEntityDimension
(
    [Business Entity Key]       int identity,
    [Business Entity Name]      nvarchar(255),
    [Business Entity Telephone] nvarchar(30),
    [Business Entity Fax]       nvarchar(30),
    [Business Entity Email]     nvarchar(255),
    [Business Entity Address]   nvarchar(255),
    [Business Entity City]      nvarchar(255),
    [Business Entity Country]   nvarchar(255),
    [Business Entity ZIP code]  nvarchar(30)
)
go

create unique index "BusinessEntityDimension_[Business Entity Key]_uindex"
    on BusinessEntityDimension ([Business Entity Key])
go

alter table BusinessEntityDimension
    add primary key nonclustered ([Business Entity Key])
go



create table CommodityDimension
(
    [Commodity Key]           int identity,
    [HS Code]                 nvarchar(6),
    [Commodity Description]   nvarchar(511),
    [Catagory Description]    nvarchar(511),
    [Subcategory Description] nvarchar(511),
    [Package Size (m^3)]      decimal(18, 3),
    [Package Weight (kg)]     decimal(18, 3)
)
go

create unique index "CommodityDimension_[Commodity Key]_uindex"
    on CommodityDimension ([Commodity Key])
go

alter table CommodityDimension
    add primary key nonclustered ([Commodity Key])
go



create table ContainerDimension
(
    [Container Key]                     int identity,
    [Container Number]                  nvarchar(11),
    [Container Type]                    nvarchar(255),
    [Container Tare Weight (kg)]        int,
    [Container Inside Length (mm)]      int,
    [Container Inside Width (mm)]       int,
    [Container Inside Height (mm)]      int,
    [Container Inside Length (ft)]      int,
    [Container Inside Width (ft)]       int,
    [Container Inside Height (ft)]      int,
    [Container Outside Length (mm)]     int,
    [Container Outside Width (mm)]      int,
    [Container Outside Height (mm)]     int,
    [Container Outside Length (ft)]     int,
    [Container Outside Width (ft)]      int,
    [Container Outside Height (ft)]     int,
    [Container Capacity]                decimal(18, 3),
    [Container Electricity Indicator]   nvarchar(255),
    [Container Refrigeration Indicator] nvarchar(255),
    [Container Danger Indicator]        nvarchar(255)
)
go

create unique index "ContainerDimension_[Container Key]_uindex"
    on ContainerDimension ([Container Key])
go

alter table ContainerDimension
    add primary key nonclustered ([Container Key])
go



create table DateDimension
(
    [Date Key]                      int identity,
    [Date]                          date,
    [Full date description]         nvarchar(255),
    [Day of Week]                   nvarchar(9),
    [Day Number in Calendar Month]  tinyint,
    [Day Number in Calendar Year]   smallint,
    [Day Number in Fiscal Month]    tinyint,
    [Day Number in Fiscal Year]     smallint,
    [Last Day in Month Indicator]   nvarchar(50),
    [Calendar Week Ending Date]     date,
    [Calendar Week]                 tinyint,
    [Calendar Week Number in Year]  tinyint,
    [Calendar Month Name]           nvarchar(9),
    [Calendar Month Number in Year] tinyint,
    [Calendar Year-Month (YYYY-MM)] nvarchar(7),
    [Calendar Quarter]              nvarchar(2),
    [Calendar Year-Quarter]         nvarchar(7),
    [Calendar Year]                 smallint,
    [Fiscal Week]                   tinyint,
    [Fiscal Week Number in Year]    tinyint,
    [Fiscal Month]                  tinyint,
    [Fiscal Year-Month]             nvarchar(7),
    [Fiscal Quarter]                nvarchar(2),
    [Fiscal Year-Quarter]           nvarchar(7),
    [Fiscal Year]                   smallint
)
go

create unique index "DateDimension_[Date Key]_uindex"
    on DateDimension ([Date Key])
go

alter table DateDimension
    add primary key nonclustered ([Date Key])
go

create table CountrySpecificDateOutrigger
(
    [Date Key]               int         not null
        constraint "CountrySpecificDateOutrigger_DateDimension_[Date Key]_fk"
            references DateDimension,
    [Country Code]           nvarchar(2) not null,
    [Country Name]           nvarchar(255),
    [Civil Name]             nvarchar(50),
    [Civil Holiday Flag]     nvarchar(50),
    [Religious Holiday Flag] nvarchar(50),
    [Religious Holiday Name] nvarchar(50),
    [Weekday Indicator]      nvarchar(50),
    [Season Name]            nvarchar(50),
    constraint CountrySpecificDateOutrigger_pk
        unique ([Date Key], [Country Code])
)


create table PortDimension
(
    [Port Key]       int identity,
    [Port Name]      nvarchar(255),
    [Port Type]      nvarchar(255),
    [Port Country]   nvarchar(255),
    [Port City]      nvarchar(255),
    [Port Address]   nvarchar(255),
    [Port Telephone] nvarchar(30)
)
go
go

create unique index "PortDimension_[Port Key]_uindex"
    on PortDimension ([Port Key])
go

alter table PortDimension
    add primary key nonclustered ([Port Key])
go



create table ShipModeDimension
(
    [Ship Mode Key]          int identity,
    [Vehicle Type]           nvarchar(255),
    [Vehicle Name]           nvarchar(255),
    [Vehicle Capacity]       int,
    [Vehicle Speed (km/h)]   decimal(18, 3),
    [Vehicle Speed (mile/h)] decimal(18, 3),
    [Vehicle Builder]        nvarchar(255),
    [Fuel cost per day]      decimal(18, 3)
)
go

create unique index "ShipModeDimension_[Ship Mode Key]_uindex"
    on ShipModeDimension ([Ship Mode Key])
go

alter table ShipModeDimension
    add primary key nonclustered ([Ship Mode Key])
go


create table ShippingTransportFact
(
    [Scheduled Voyage Departure Date Key]   int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk"
            references DateDimension,
    [Scheduled Voyage Arrival Date Key]     int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_8"
            references DateDimension,
    [Scheduled Shipment Departure Date Key] int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_2"
            references DateDimension,
    [Scheduled Shipment Arrival Date Key]   int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_3"
            references DateDimension,
    [Actual Voyage Departure Date Key]      int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_4"
            references DateDimension,
    [Actual Voyage Arrival Date Key]        int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_5"
            references DateDimension,
    [Actual Shipment Departure Date Key]    int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_6"
            references DateDimension,
    [Actual Shipment Arrival Date Key]      int
        constraint "ShippingTransportFact_DateDimension_[Date Key]_fk_7"
            references DateDimension,
    [Voyage Origin Port Key]                int
        constraint "ShippingTransportFact_PortDimension_[Port Key]_fk"
            references PortDimension,
    [Voyage Destination Port Key]           int
        constraint "ShippingTransportFact_PortDimension_[Port Key]_fk_2"
            references PortDimension,
    [Shipment Origin Port Key]              int
        constraint "ShippingTransportFact_PortDimension_[Port Key]_fk_3"
            references PortDimension,
    [Shipment Destination Port Key]         int
        constraint "ShippingTransportFact_PortDimension_[Port Key]_fk_4"
            references PortDimension,
    [Ship Mode Key]                         int
        constraint "ShippingTransportFact_ShipModeDimension_[Ship Mode Key]_fk"
            references ShipModeDimension,
    [Container Key]                         int
        constraint "ShippingTransportFact_ContainerDimension_[Container Key]_fk"
            references ContainerDimension,
    [Commodity Key]                         int
        constraint "ShippingTransportFact_CommodityDimension_[Commodity Key]_fk"
            references CommodityDimension,
    [Consignor Key]                         int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk"
            references BusinessEntityDimension,
    [Foreign Transporter Key]               int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_2"
            references BusinessEntityDimension,
    [Domestic Consolidator Key]             int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_5"
            references BusinessEntityDimension,
    [Shipper Key]                           int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_4"
            references BusinessEntityDimension,
    [Foreign Consolidator Key]              int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_3"
            references BusinessEntityDimension,
    [Domestic Transporter Key]              int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_6"
            references BusinessEntityDimension,
    [Consignee Key]                         int
        constraint "ShippingTransportFact_BusinessEntityDimension_[Business Entity Key]_fk_7"
            references BusinessEntityDimension,
    [Bill-of-Lading Number]                 nvarchar(17) not null,
    [Voyage Fee]                            decimal(19, 2),
    [Expected Tariffs]                      decimal(19, 2),
    [Actual Tariffs]                        decimal(19, 2),
    [Shipment Miles]                        decimal(19, 2)
)
go

create unique index "ShippingTransportFact_[Bill-of-Lading Number (DD)]_uindex"
    on ShippingTransportFact ([Bill-of-Lading Number])
go

drop view if exists ScheduledVoyageDepartureDate go
create view ScheduledVoyageDepartureDate ([Scheduled Voyage Departure Date Key], [Scheduled Voyage Departure Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Scheduled Voyage Departure Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ScheduledVoyageArrivalDate go
create view ScheduledVoyageArrivalDate ([Scheduled Voyage Arrival Date Key], [Scheduled Voyage Arrival Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Scheduled Voyage Arrival Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ScheduledShipmentDepartureDate go
create view ScheduledShipmentDepartureDate ([Scheduled Shipment Departure Date Key], [Scheduled Shipment Departure Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Scheduled Shipment Departure Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ScheduledShipmentArrivalDate go
create view ScheduledShipmentArrivalDate ([Scheduled Shipment Arrival Date Key], [Scheduled Shipment Arrival Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Scheduled Shipment Arrival Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ActualVoyageDepartureDate go
create view ActualVoyageDepartureDate ([Actual Voyage Departure Date Key], [Actual Voyage Departure Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Actual Voyage Departure Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ActualVoyageArrivalDate go
create view ActualVoyageArrivalDate ([Actual Voyage Arrival Date Key], [Actual Voyage Arrival Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Actual Voyage Arrival Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ActualShipmentDepartureDate go
create view ActualShipmentDepartureDate ([Actual Shipment Departure Date Key], [Actual Shipment Departure Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Actual Shipment Departure Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists ActualShipmentArrivalDate go
create view ActualShipmentArrivalDate ([Actual Shipment Arrival Date Key], [Actual Shipment Arrival Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Actual Shipment Arrival Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) as select [Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year] from DateDimension go
drop view if exists VoyageOriginPort go
create view VoyageOriginPort ([Voyage Origin Port Key], [Voyage Origin Port Name], [Voyage Origin Port Type], [Voyage Origin Port Country], [Voyage Origin Port City], [Voyage Origin Port Address], [Voyage Origin Port Telephone]) as select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone] from PortDimension go
drop view if exists VoyageDestinationPort go
create view VoyageDestinationPort ([Voyage Destination Port Key], [Voyage Destination Port Name], [Voyage Destination Port Type], [Voyage Destination Port Country], [Voyage Destination Port City], [Voyage Destination Port Address], [Voyage Destination Port Telephone]) as select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone] from PortDimension go
drop view if exists ShipmentOriginPort go
create view ShipmentOriginPort ([Shipment Origin Port Key], [Shipment Origin Port Name], [Shipment Origin Port Type], [Shipment Origin Port Country], [Shipment Origin Port City], [Shipment Origin Port Address], [Shipment Origin Port Telephone]) as select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone] from PortDimension go
drop view if exists ShipmentDestinationPort go
create view ShipmentDestinationPort ([Shipment Destination Port Key], [Shipment Destination Port Name], [Shipment Destination Port Type], [Shipment Destination Port Country], [Shipment Destination Port City], [Shipment Destination Port Address], [Shipment Destination Port Telephone]) as select [Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone] from PortDimension go
drop view if exists Consignor go
create view Consignor ([Consignor Key], [Consignor Name], [Consignor Telephone], [Consignor Fax], [Consignor Email], [Consignor Address], [Consignor City], [Consignor Country], [Consignor ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists ForeignTransporter go
create view ForeignTransporter ([Foreign Transporter Key], [Foreign Transporter Name], [Foreign Transporter Telephone], [Foreign Transporter Fax], [Foreign Transporter Email], [Foreign Transporter Address], [Foreign Transporter City], [Foreign Transporter Country], [Foreign Transporter ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists ForeignConsolidator go
create view ForeignConsolidator ([Foreign Consolidator Key], [Foreign Consolidator Name], [Foreign Consolidator Telephone], [Foreign Consolidator Fax], [Foreign Consolidator Email], [Foreign Consolidator Address], [Foreign Consolidator City], [Foreign Consolidator Country], [Foreign Consolidator ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists Shipper go
create view Shipper ([Shipper Key], [Shipper Name], [Shipper Telephone], [Shipper Fax], [Shipper Email], [Shipper Address], [Shipper City], [Shipper Country], [Shipper ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists DomesticConsolidator go
create view DomesticConsolidator ([Domestic Consolidator Key], [Domestic Consolidator Name], [Domestic Consolidator Telephone], [Domestic Consolidator Fax], [Domestic Consolidator Email], [Domestic Consolidator Address], [Domestic Consolidator City], [Domestic Consolidator Country], [Domestic Consolidator ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists DomesticTransporter go
create view DomesticTransporter ([Domestic Transporter Key], [Domestic Transporter Name], [Domestic Transporter Telephone], [Domestic Transporter Fax], [Domestic Transporter Email], [Domestic Transporter Address], [Domestic Transporter City], [Domestic Transporter Country], [Domestic Transporter ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
drop view if exists Consignee go
create view Consignee ([Consignee Key], [Consignee Name], [Consignee Telephone], [Consignee Fax], [Consignee Email], [Consignee Address], [Consignee City], [Consignee Country], [Consignee ZIP code]) as select [Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code] from BusinessEntityDimension go
