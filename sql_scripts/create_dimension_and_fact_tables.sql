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



CREATE TABLE BusinessEntityDimension
(
    [Business Entity Key] int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Name]                nvarchar(255),
    [Telephone]           nvarchar(30),
    [Fax]                 nvarchar(30),
    [Email]               nvarchar(255),
    [Address]             nvarchar(255),
    [City]                nvarchar(255),
    [Country]             nvarchar(255),
    [ZIP code]            nvarchar(30),
);


CREATE TABLE CommodityDimension
(
    [Commodity Key]           int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [HS Code]                 nvarchar(6),
    [Commodity Description]   nvarchar(511),
    [Catagory Description]    nvarchar(511),
    [Subcategory Description] nvarchar(511),
    [Package Size (m^3)]      decimal(18, 3),
    [Package Weight (kg)]     decimal(18, 3),
);


CREATE TABLE ContainerDimension
(
    [Container Key]                     int IDENTITY (1,1) NOT NULL PRIMARY KEY,
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
    [Container Danger Indicator]        nvarchar(255),
)


CREATE TABLE DateDimension
(
    [Date Key]                      int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Date]                          date,
    [Full date description]         nvarchar(255),
    [Date of Week]                  nvarchar(9),
    [Day Number in Calendar Month]  tinyint,
    [Day Number in Calendar Year]   smallint,
    [Day Number in Fiscal Month]    tinyint,
    [Day Number in Fiscal Year]     smallint,
    [Last Day in Month Indicator]   nvarchar(50),
    [Calendar Week Ending Date]     date,
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
    [Fiscal Year]                   smallint,
);


CREATE TABLE CountrySpecificDateOutrigger
(
    [Date Key]               int NOT NULL REFERENCES DateDimension,
    [Country Key]            int NOT NULL,
    [Country Name]           nvarchar(255),
    [Civil Name]             nvarchar(50),
    [Civil Holiday Flag]     nvarchar(50),
    [Religious Holiday Flag] nvarchar(50),
    [Religious Holiday Name] nvarchar(50),
    [Weekday Indicator]      nvarchar(50),
    [Season Name]            nvarchar(50),
);


CREATE TABLE PortDimension
(
    [Port Key]       int IDENTITY (1,1) NOT NULL,
    [Port Name]      nvarchar(255),
    [Port Type]      nvarchar(255),
    [Port Country]   nvarchar(255),
    [Port City]      nvarchar(255),
    [Port Address]   nvarchar(255),
    [Port Telephone] nvarchar(30),
    primary key ([Port Key])
);


CREATE TABLE ShipModeDimension
(
    [Ship Mode Key]          int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Vehicle Type]           nvarchar(255),
    [Vehicle Name]           nvarchar(255),
    [Vehicle Capacity]       int,
    [Vehicle Speed (km/h)]   decimal(18, 3),
    [Vehicle Speed (mile/h)] decimal(18, 3),
    [Vehicle Builder]        nvarchar(255),
    [Fuel cost per day]      decimal(18, 3),
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
    [Bill-of-Lading Number (DD)]            nvarchar(17),
    [Voyage Fee]                            decimal(19, 2),
    [Expected Tariffs]                      decimal(19, 2),
    [Actual Tariffs]                        decimal(19, 2),
    [Shipment Miles]                        decimal(19, 2),
);
