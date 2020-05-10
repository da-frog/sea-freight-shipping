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
    [Business Entity Key] int identity,
    [Business Entity Name]                nvarchar(255),
    [Business Entity Telephone]           nvarchar(30),
    [Business Entity Fax]                 nvarchar(30),
    [Business Entity Email]               nvarchar(255),
    [Business Entity Address]             nvarchar(255),
    [Business Entity City]                nvarchar(255),
    [Business Entity Country]             nvarchar(255),
    [Business Entity ZIP code]            nvarchar(30)
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
    [Bill-of-Lading Number (DD)]            nvarchar(17) not null,
    [Voyage Fee]                            decimal(19, 2),
    [Expected Tariffs]                      decimal(19, 2),
    [Actual Tariffs]                        decimal(19, 2),
    [Shipment Miles]                        decimal(19, 2)
)
go

create unique index "ShippingTransportFact_[Bill-of-Lading Number (DD)]_uindex"
    on ShippingTransportFact ([Bill-of-Lading Number (DD)])
go


CREATE VIEW ScheduledVoyageDepartureDate ([Scheduled Voyage Departure Date Key], [Scheduled Voyage Departure Date], [Scheduled Voyage Departure Full date description], [Scheduled Voyage Departure Day of Week], [Scheduled Voyage Departure Day Number in Calendar Month], [Scheduled Voyage Departure Day Number in Calendar Year], [Scheduled Voyage Departure Day Number in Fiscal Month], [Scheduled Voyage Departure Day Number in Fiscal Year], [Scheduled Voyage Departure Last Day in Month Indicator], [Scheduled Voyage Departure Calendar Week Ending Date], [Scheduled Voyage Departure Calendar Week], [Scheduled Voyage Departure Calendar Week Number in Year], [Scheduled Voyage Departure Calendar Month Name], [Scheduled Voyage Departure Calendar Month Number in Year], [Scheduled Voyage Departure Calendar Year-Month (YYYY-MM)], [Scheduled Voyage Departure Calendar Quarter], [Scheduled Voyage Departure Calendar Year-Quarter], [Scheduled Voyage Departure Calendar Year], [Scheduled Voyage Departure Fiscal Week], [Scheduled Voyage Departure Fiscal Week Number in Year], [Scheduled Voyage Departure Fiscal Month], [Scheduled Voyage Departure Fiscal Year-Month], [Scheduled Voyage Departure Fiscal Quarter], [Scheduled Voyage Departure Fiscal Year-Quarter], [Scheduled Voyage Departure Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ScheduledVoyageArrivalDate ([Scheduled Voyage Arrival Date Key], [Scheduled Voyage Arrival Date], [Scheduled Voyage Arrival Full date description], [Scheduled Voyage Arrival Day of Week], [Scheduled Voyage Arrival Day Number in Calendar Month], [Scheduled Voyage Arrival Day Number in Calendar Year], [Scheduled Voyage Arrival Day Number in Fiscal Month], [Scheduled Voyage Arrival Day Number in Fiscal Year], [Scheduled Voyage Arrival Last Day in Month Indicator], [Scheduled Voyage Arrival Calendar Week Ending Date], [Scheduled Voyage Arrival Calendar Week], [Scheduled Voyage Arrival Calendar Week Number in Year], [Scheduled Voyage Arrival Calendar Month Name], [Scheduled Voyage Arrival Calendar Month Number in Year], [Scheduled Voyage Arrival Calendar Year-Month (YYYY-MM)], [Scheduled Voyage Arrival Calendar Quarter], [Scheduled Voyage Arrival Calendar Year-Quarter], [Scheduled Voyage Arrival Calendar Year], [Scheduled Voyage Arrival Fiscal Week], [Scheduled Voyage Arrival Fiscal Week Number in Year], [Scheduled Voyage Arrival Fiscal Month], [Scheduled Voyage Arrival Fiscal Year-Month], [Scheduled Voyage Arrival Fiscal Quarter], [Scheduled Voyage Arrival Fiscal Year-Quarter], [Scheduled Voyage Arrival Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ScheduledShipmentDepartureDate ([Scheduled Shipment Departure Date Key], [Scheduled Shipment Departure Date], [Scheduled Shipment Departure Full date description], [Scheduled Shipment Departure Day of Week], [Scheduled Shipment Departure Day Number in Calendar Month], [Scheduled Shipment Departure Day Number in Calendar Year], [Scheduled Shipment Departure Day Number in Fiscal Month], [Scheduled Shipment Departure Day Number in Fiscal Year], [Scheduled Shipment Departure Last Day in Month Indicator], [Scheduled Shipment Departure Calendar Week Ending Date], [Scheduled Shipment Departure Calendar Week], [Scheduled Shipment Departure Calendar Week Number in Year], [Scheduled Shipment Departure Calendar Month Name], [Scheduled Shipment Departure Calendar Month Number in Year], [Scheduled Shipment Departure Calendar Year-Month (YYYY-MM)], [Scheduled Shipment Departure Calendar Quarter], [Scheduled Shipment Departure Calendar Year-Quarter], [Scheduled Shipment Departure Calendar Year], [Scheduled Shipment Departure Fiscal Week], [Scheduled Shipment Departure Fiscal Week Number in Year], [Scheduled Shipment Departure Fiscal Month], [Scheduled Shipment Departure Fiscal Year-Month], [Scheduled Shipment Departure Fiscal Quarter], [Scheduled Shipment Departure Fiscal Year-Quarter], [Scheduled Shipment Departure Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ScheduledShipmentArrivalDate ([Scheduled Shipment Arrival Date Key], [Scheduled Shipment Arrival Date], [Scheduled Shipment Arrival Full date description], [Scheduled Shipment Arrival Day of Week], [Scheduled Shipment Arrival Day Number in Calendar Month], [Scheduled Shipment Arrival Day Number in Calendar Year], [Scheduled Shipment Arrival Day Number in Fiscal Month], [Scheduled Shipment Arrival Day Number in Fiscal Year], [Scheduled Shipment Arrival Last Day in Month Indicator], [Scheduled Shipment Arrival Calendar Week Ending Date], [Scheduled Shipment Arrival Calendar Week], [Scheduled Shipment Arrival Calendar Week Number in Year], [Scheduled Shipment Arrival Calendar Month Name], [Scheduled Shipment Arrival Calendar Month Number in Year], [Scheduled Shipment Arrival Calendar Year-Month (YYYY-MM)], [Scheduled Shipment Arrival Calendar Quarter], [Scheduled Shipment Arrival Calendar Year-Quarter], [Scheduled Shipment Arrival Calendar Year], [Scheduled Shipment Arrival Fiscal Week], [Scheduled Shipment Arrival Fiscal Week Number in Year], [Scheduled Shipment Arrival Fiscal Month], [Scheduled Shipment Arrival Fiscal Year-Month], [Scheduled Shipment Arrival Fiscal Quarter], [Scheduled Shipment Arrival Fiscal Year-Quarter], [Scheduled Shipment Arrival Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ActualVoyageDepartureDate ([Actual Voyage Departure Date Key], [Actual Voyage Departure Date], [Actual Voyage Departure Full date description], [Actual Voyage Departure Day of Week], [Actual Voyage Departure Day Number in Calendar Month], [Actual Voyage Departure Day Number in Calendar Year], [Actual Voyage Departure Day Number in Fiscal Month], [Actual Voyage Departure Day Number in Fiscal Year], [Actual Voyage Departure Last Day in Month Indicator], [Actual Voyage Departure Calendar Week Ending Date], [Actual Voyage Departure Calendar Week], [Actual Voyage Departure Calendar Week Number in Year], [Actual Voyage Departure Calendar Month Name], [Actual Voyage Departure Calendar Month Number in Year], [Actual Voyage Departure Calendar Year-Month (YYYY-MM)], [Actual Voyage Departure Calendar Quarter], [Actual Voyage Departure Calendar Year-Quarter], [Actual Voyage Departure Calendar Year], [Actual Voyage Departure Fiscal Week], [Actual Voyage Departure Fiscal Week Number in Year], [Actual Voyage Departure Fiscal Month], [Actual Voyage Departure Fiscal Year-Month], [Actual Voyage Departure Fiscal Quarter], [Actual Voyage Departure Fiscal Year-Quarter], [Actual Voyage Departure Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ActualVoyageArrivalDate ([Actual Voyage Arrival Date Key], [Actual Voyage Arrival Date], [Actual Voyage Arrival Full date description], [Actual Voyage Arrival Day of Week], [Actual Voyage Arrival Day Number in Calendar Month], [Actual Voyage Arrival Day Number in Calendar Year], [Actual Voyage Arrival Day Number in Fiscal Month], [Actual Voyage Arrival Day Number in Fiscal Year], [Actual Voyage Arrival Last Day in Month Indicator], [Actual Voyage Arrival Calendar Week Ending Date], [Actual Voyage Arrival Calendar Week], [Actual Voyage Arrival Calendar Week Number in Year], [Actual Voyage Arrival Calendar Month Name], [Actual Voyage Arrival Calendar Month Number in Year], [Actual Voyage Arrival Calendar Year-Month (YYYY-MM)], [Actual Voyage Arrival Calendar Quarter], [Actual Voyage Arrival Calendar Year-Quarter], [Actual Voyage Arrival Calendar Year], [Actual Voyage Arrival Fiscal Week], [Actual Voyage Arrival Fiscal Week Number in Year], [Actual Voyage Arrival Fiscal Month], [Actual Voyage Arrival Fiscal Year-Month], [Actual Voyage Arrival Fiscal Quarter], [Actual Voyage Arrival Fiscal Year-Quarter], [Actual Voyage Arrival Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ActualShipmentDepartureDate ([Actual Shipment Departure Date Key], [Actual Shipment Departure Date], [Actual Shipment Departure Full date description], [Actual Shipment Departure Day of Week], [Actual Shipment Departure Day Number in Calendar Month], [Actual Shipment Departure Day Number in Calendar Year], [Actual Shipment Departure Day Number in Fiscal Month], [Actual Shipment Departure Day Number in Fiscal Year], [Actual Shipment Departure Last Day in Month Indicator], [Actual Shipment Departure Calendar Week Ending Date], [Actual Shipment Departure Calendar Week], [Actual Shipment Departure Calendar Week Number in Year], [Actual Shipment Departure Calendar Month Name], [Actual Shipment Departure Calendar Month Number in Year], [Actual Shipment Departure Calendar Year-Month (YYYY-MM)], [Actual Shipment Departure Calendar Quarter], [Actual Shipment Departure Calendar Year-Quarter], [Actual Shipment Departure Calendar Year], [Actual Shipment Departure Fiscal Week], [Actual Shipment Departure Fiscal Week Number in Year], [Actual Shipment Departure Fiscal Month], [Actual Shipment Departure Fiscal Year-Month], [Actual Shipment Departure Fiscal Quarter], [Actual Shipment Departure Fiscal Year-Quarter], [Actual Shipment Departure Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;
CREATE VIEW ActualShipmentArrivalDate ([Actual Shipment Arrival Date Key], [Actual Shipment Arrival Date], [Actual Shipment Arrival Full date description], [Actual Shipment Arrival Day of Week], [Actual Shipment Arrival Day Number in Calendar Month], [Actual Shipment Arrival Day Number in Calendar Year], [Actual Shipment Arrival Day Number in Fiscal Month], [Actual Shipment Arrival Day Number in Fiscal Year], [Actual Shipment Arrival Last Day in Month Indicator], [Actual Shipment Arrival Calendar Week Ending Date], [Actual Shipment Arrival Calendar Week], [Actual Shipment Arrival Calendar Week Number in Year], [Actual Shipment Arrival Calendar Month Name], [Actual Shipment Arrival Calendar Month Number in Year], [Actual Shipment Arrival Calendar Year-Month (YYYY-MM)], [Actual Shipment Arrival Calendar Quarter], [Actual Shipment Arrival Calendar Year-Quarter], [Actual Shipment Arrival Calendar Year], [Actual Shipment Arrival Fiscal Week], [Actual Shipment Arrival Fiscal Week Number in Year], [Actual Shipment Arrival Fiscal Month], [Actual Shipment Arrival Fiscal Year-Month], [Actual Shipment Arrival Fiscal Quarter], [Actual Shipment Arrival Fiscal Year-Quarter], [Actual Shipment Arrival Fiscal Year]) AS SELECT ([Date Key], [Date], [Full date description], [Day of Week], [Day Number in Calendar Month], [Day Number in Calendar Year], [Day Number in Fiscal Month], [Day Number in Fiscal Year], [Last Day in Month Indicator], [Calendar Week Ending Date], [Calendar Week], [Calendar Week Number in Year], [Calendar Month Name], [Calendar Month Number in Year], [Calendar Year-Month (YYYY-MM)], [Calendar Quarter], [Calendar Year-Quarter], [Calendar Year], [Fiscal Week], [Fiscal Week Number in Year], [Fiscal Month], [Fiscal Year-Month], [Fiscal Quarter], [Fiscal Year-Quarter], [Fiscal Year]) FROM DateDimension;

CREATE VIEW VoyageOriginPort ([Voyage Origin Port Key], [Voyage Origin Port Name], [Voyage Origin Port Type], [Voyage Origin Port Country], [Voyage Origin Port City], [Voyage Origin Port Address], [Voyage Origin Port Telephone]) AS SELECT ([Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]) FROM Port Dimension;
CREATE VIEW VoyageDestinationPort ([Voyage Destination Port Key], [Voyage Destination Port Name], [Voyage Destination Port Type], [Voyage Destination Port Country], [Voyage Destination Port City], [Voyage Destination Port Address], [Voyage Destination Port Telephone]) AS SELECT ([Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]) FROM Port Dimension;
CREATE VIEW ShipmentOriginPort ([Shipment Origin Port Key], [Shipment Origin Port Name], [Shipment Origin Port Type], [Shipment Origin Port Country], [Shipment Origin Port City], [Shipment Origin Port Address], [Shipment Origin Port Telephone]) AS SELECT ([Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]) FROM Port Dimension;
CREATE VIEW ShipmentDestinationPort ([Shipment Destination Port Key], [Shipment Destination Port Name], [Shipment Destination Port Type], [Shipment Destination Port Country], [Shipment Destination Port City], [Shipment Destination Port Address], [Shipment Destination Port Telephone]) AS SELECT ([Port Key], [Port Name], [Port Type], [Port Country], [Port City], [Port Address], [Port Telephone]) FROM Port Dimension;

CREATE VIEW Consignor ([Consignor Key], [Consignor Name], [Consignor Telephone], [Consignor Fax], [Consignor Email], [Consignor Address], [Consignor City], [Consignor Country], [Consignor ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW ForeignTransporter ([Foreign Transporter Key], [Foreign Transporter Name], [Foreign Transporter Telephone], [Foreign Transporter Fax], [Foreign Transporter Email], [Foreign Transporter Address], [Foreign Transporter City], [Foreign Transporter Country], [Foreign Transporter ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW ForeignConsolidator ([Foreign Consolidator Key], [Foreign Consolidator Name], [Foreign Consolidator Telephone], [Foreign Consolidator Fax], [Foreign Consolidator Email], [Foreign Consolidator Address], [Foreign Consolidator City], [Foreign Consolidator Country], [Foreign Consolidator ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW Shipper ([Shipper Key], [Shipper Name], [Shipper Telephone], [Shipper Fax], [Shipper Email], [Shipper Address], [Shipper City], [Shipper Country], [Shipper ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW DomesticConsolidator ([Domestic Consolidator Key], [Domestic Consolidator Name], [Domestic Consolidator Telephone], [Domestic Consolidator Fax], [Domestic Consolidator Email], [Domestic Consolidator Address], [Domestic Consolidator City], [Domestic Consolidator Country], [Domestic Consolidator ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW DomesticTransporter ([Domestic Transporter Key], [Domestic Transporter Name], [Domestic Transporter Telephone], [Domestic Transporter Fax], [Domestic Transporter Email], [Domestic Transporter Address], [Domestic Transporter City], [Domestic Transporter Country], [Domestic Transporter ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
CREATE VIEW Consignee ([Consignee Key], [Consignee Name], [Consignee Telephone], [Consignee Fax], [Consignee Email], [Consignee Address], [Consignee City], [Consignee Country], [Consignee ZIP code]) AS SELECT ([Business Entity Key], [Business Entity Name], [Business Entity Telephone], [Business Entity Fax], [Business Entity Email], [Business Entity Address], [Business Entity City], [Business Entity Country], [Business Entity ZIP code]) FROM Business Entity Dimension;
