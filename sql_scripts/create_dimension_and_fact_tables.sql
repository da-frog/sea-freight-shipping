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
    [Business Entity Region]    nvarchar(255),
    [Business Entity City]      nvarchar(255),
    [Business Entity Country]   nvarchar(255),
    [Business Entity ZIP code]  nvarchar(30),
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
    [Commodity Key]              int identity,
    [HS Code]                    nvarchar(6),
    [HS Sub Heading]             nvarchar(6),
    [HS Sub Heading Description] nvarchar(255),
    [HS Heading]                 nvarchar(4),
    [HS Heading Description]     nvarchar(255),
    [HS Chapter]                 nvarchar(2),
    [HS Chapter Description]     nvarchar(255),
    [HS Section]                 nvarchar(5),
    [HS Section Name]            nvarchar(255),
    [Commodity Description]      nvarchar(511),
    [Package Size (m^3)]         decimal(18, 3),
    [Package Size Range (m^3)]   nvarchar(255),
    [Package Weight (kg)]        decimal(18, 3)
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
    [Container Owner Code]              nvarchar(4),
    [Container Builder]                 nvarchar(255),
    [ISO Size Code]                     nvarchar(2),
    [ISO Type Code]                     nvarchar(2),
    [ISO Type Group Code]               nvarchar(2),
    [Container Type]                    nvarchar(255),
    [Container Model Description]       nvarchar(255),
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
    [Date Key]                    int identity,
    [Full date description]       nvarchar(255),
    [Date]                        date,
    [Day Of Half Year]            int,
    [Day Of Month]                int,
    [Day Of Quarter]              int,
    [Day Of Week]                 int,
    [Day Of Year]                 int,
    [Half Year Of Year]           int,
    [Month Of Half Year]          int,
    [Month Of Quarter]            int,
    [Month Of Year]               int,
    [Quarter Of Half Year]        int,
    [Quarter Of Year]             int,
    [Week Of Half Year]           int,
    [Week Of Month]               int,
    [Week Of Quarter]             int,
    [Week Of Year]                int,
    [Fiscal Date]                 date,
    [Fiscal Day Of Half Year]     int,
    [Fiscal Day Of Month]         int,
    [Fiscal Day Of Quarter]       int,
    [Fiscal Day Of Week]          int,
    [Fiscal Day Of Year]          int,
    [Fiscal Half Year Of Year]    int,
    [Fiscal Month Of Half Year]   int,
    [Fiscal Month Of Quarter]     int,
    [Fiscal Month Of Year]        int,
    [Fiscal Quarter Of Half Year] int,
    [Fiscal Quarter Of Year]      int,
    [Fiscal Week Of Half Year]    int,
    [Fiscal Week Of Month]        int,
    [Fiscal Week Of Quarter]      int,
    [Fiscal Week Of Year]         int,
    [Calendar Week Ending Date]   date
    ,[Day Name]                   nvarchar(3)
    ,[Month Name]                 nvarchar(3)
    ,[Full Day Name]              nvarchar(9)
    ,[Full Month Name]            nvarchar(9)
    ,[Fiscal Day Name]            nvarchar(3)
    ,[Fiscal Month Name]          nvarchar(3)
    ,[Fiscal Full Day Name]       nvarchar(9)
    ,[Fiscal Full Month Name]     nvarchar(9)
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
    [Port Region]    nvarchar(255),
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
    [Ship Mode Key]                     int identity,
    [Vehicle Type]                      nvarchar(255),
    [Vehicle Name]                      nvarchar(255),
    [Vehicle Capacity]                  int,
    [Ship Size Category]                nvarchar(255),
    [Vehicle Speed (km/h)]              decimal(18, 3),
    [Vehicle Speed (mph)]               decimal(18, 3),
    [Vehicle Speed (knots)]             decimal(18, 1),
    [Vehicle Speed Range (knots)]       nvarchar(255),
    [Vehicle Fuel Cost Per Day Range 1] nvarchar(255),
    [Vehicle Fuel Cost Per Day Range 2] nvarchar(255),
    [Vehicle Builder]                   nvarchar(255),
    [Vehicle Fuel Cost Per Day]         decimal(18, 2)
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

create unique index "ShippingTransportFact_[Bill-of-Lading Number]_uindex"
    on ShippingTransportFact ([Bill-of-Lading Number])
go
