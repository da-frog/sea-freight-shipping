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

IF OBJECT_ID ('dbo.CountrySpecificDateOutrigger', 'U') IS NOT NULL
    DROP TABLE CountrySpecificDateOutrigger;
GO

IF OBJECT_ID ('dbo.DateDimension', 'U') IS NOT NULL
    DROP TABLE DateDimension;
GO

IF OBJECT_ID('dbo.PortDimension', 'U') IS NOT NULL
    DROP TABLE PortDimension;
GO

IF OBJECT_ID('dbo.ShipModeDimension', 'U') IS NOT NULL
    DROP TABLE ShipModeDimension;
GO



CREATE TABLE BusinessEntityDimension
(
    [Business Entity Key] int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Name]                nvarchar(50),
    [Telephone]           varchar(15),
    [Fax]                 varchar(15),
    [Email]               varchar(255),
    [Address]             nvarchar(255),
    [City]                nvarchar(50),
    [Country]             nvarchar(50),
    [ZIP code]            varchar(11),
);


CREATE TABLE CommodityDimension
(
    [Commodity Key]           int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [HS Code]                 varchar(6),
    [Commodity Description]   nvarchar(100),
    [Catagory Description]    nvarchar(100),
    [Subcategory Description] nvarchar(100),
    [Package Size (m^3)]      decimal,
    [Package Weight (kg)]     decimal,
);


CREATE TABLE ContainerDimension
(
    [Container Key]                     int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Container Number]                  varchar(11),
    [Container Size (Volume)]           decimal,
    [Container Type]                    varchar(100),
    [Container Tare Weight (kg)]        decimal,
    [Container Inside Length (mm)]      int,
    [Container Inside Width (mm)]       int,
    [Container Inside Height (mm)]      int,
    [Container Inside Length (ft)]      decimal,
    [Container Inside Width (ft)]       decimal,
    [Container Inside Height (ft)]      decimal,
    [Container Outside Length (mm)]     decimal,
    [Container Outside Width (mm)]      decimal,
    [Container Outside Height (mm)]     decimal,
    [Container Outside Length (ft)]     decimal,
    [Container Outside Width (ft)]      decimal,
    [Container Outside Height (ft)]     decimal,
    [Container Capacity]                decimal,
    [Container Electricity Indicator]   varchar(50),
    [Container Refrigeration Indicator] varchar(50),
    [Container Thermal Indicator]       varchar(50),
    [Container Dangerous Indicator]     varchar(50),
)


CREATE TABLE DateDimension
(
    [Date Key]                      int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Date]                          date,
    [Full date description]	        varchar(255),
    [Date of Week]		            varchar(9),
    [Day Number in Calendar Month]	tinyint,
    [Day Number in Calendar Year]	smallint,
    [Day Number in Fiscal Month]	tinyint,
    [Day Number in Fiscal Year]		smallint,
    [Last Day in Month Indicator]	varchar(50),
    [Calendar Week Ending Date]     date,
    [Calendar Week Number in Year]  tinyint,
    [Calendar Month Name]           varchar(9),
    [Calendar Month Number in Year] tinyint,
    [Calendar Year-Month (YYYY-MM)] varchar(7),
    [Calendar Quarter]              varchar(2),
    [Calendar Year-Quarter]         varchar(7),
    [Calendar Year]                 smallint,
    [Fiscal Week]                   tinyint,
    [Fiscal Week Number in Year]    tinyint,
    [Fiscal Month]	                tinyint,
    [Fiscal Year-Month]             varchar(7),
    [Fiscal Quarter]                varchar(2),
    [Fiscal Year-Quarter]           varchar(7),
    [Fiscal Year]                   smallint,
);


CREATE TABLE CountrySpecificDateOutrigger
(
    [Date Key]                  int NOT NULL REFERENCES DateDimension,
    [Country Key]               int NOT NULL,
    [Country Name]              nvarchar(50),
    [Civil Name]                nvarchar(50),
    [Civil Holiday Flag]        nvarchar(50),
    [Religious Holiday Flag]    nvarchar(50),
    [Religious Holiday Name]    nvarchar(50),
    [Weekday Indicator]         nvarchar(50),
    [Season Name]               nvarchar(50),
);


CREATE TABLE PortDimension
(
    [Port Key]       int IDENTITY (1,1) NOT NULL,
    [Port Name]      nvarchar(50),
    [Port Type]      nvarchar(50),
    [Port Country]   nvarchar(50),
    [Port City]      nvarchar(50),
    [Port Address]   nvarchar(100),
    [Port Telephone] varchar(15),
    primary key ([Port Key])
);


CREATE TABLE ShipModeDimension
(
    [Ship Mode Key]          int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Vehicle Type]           nvarchar(50),
    [Vehicle Name]           nvarchar(100),
    [Vehicle Capacity]       decimal,
    [Vehicle Speed (km/h)]   decimal,
    [Vehicle Speed (mile/h)] decimal,
    [Vehicle Builder]        nvarchar(100),
    [Fuel cost per day]      decimal,
);


CREATE TABLE ShippingTransportFact
(
    [Scheduled Voyage Departure Date Key]   int REFERENCES DateDimension,
    [Scheduled Voyage Arrival Date Key]     int REFERENCES DateDimension,
    [Scheduled Shipment Departure Date Key] int REFERENCES DateDimension,
    [Scheduled Shipment Arrival Date Key]   int REFERENCES DateDimension,
    [Actual Voyage Departure Date Key]      int REFERENCES DateDimension,
    [Actual Voyage Arrival Date Key]        int REFERENCES DateDimension,
    [Actual Shipment Departure Date Key]    int REFERENCES DateDimension,
    [Actual Shipment Arrival Date Key]      int REFERENCES DateDimension,
    [Voyage Origin Port Key]                int REFERENCES PortDimension,
    [Voyage Destination Port Key]           int REFERENCES PortDimension,
    [Shipment Origin Port Key]              int REFERENCES PortDimension,
    [Shipment Destination Port Key]         int REFERENCES PortDimension,
    [Ship Mode Key]                         int REFERENCES ShipModeDimension,
    [Container Key]                         int REFERENCES ContainerDimension,
    [Commodity Key]                         int REFERENCES CommodityDimension,
    [Consignor Key]                         int REFERENCES BusinessEntityDimension,
    [Foreign Transporter Key]               int REFERENCES BusinessEntityDimension,
    [Foreign Consolidator Key]              int REFERENCES BusinessEntityDimension,
    [Shipper Key]                           int REFERENCES BusinessEntityDimension,
    [Domestic Consolidator Key]             int REFERENCES BusinessEntityDimension,
    [Domestic Transporter Key]              int REFERENCES BusinessEntityDimension,
    [Consignee Key]                         int REFERENCES BusinessEntityDimension,
    [Bill-of-Lading Number (DD)]            varchar(17),
    [Leg Fee]                               money,
    [Expected Tariffs]                      decimal,
    [Actual Tariffs]                        decimal,
    [Leg Miles]                             decimal,
);
