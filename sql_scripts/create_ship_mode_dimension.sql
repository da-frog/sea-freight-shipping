USE FreightShippingDW;

IF OBJECT_ID('dbo.ShipModeDimension', 'U') IS NOT NULL
    DROP TABLE ShipModeDimension;
GO
CREATE TABLE ShipModeDimension
(
    [Ship Mode Key]          int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Vehicle Type]           nvarchar(50),
    [Vehicle Name]           nvarchar(100),
    [Vehicle Capacity]       float,
    [Vehicle Speed (km/h)]   float,
    [Vehicle Speed (mile/h)] float,
    [Vehicle Builder]        nvarchar(100),
    [Fuel cost per mile]     float,
    [Fuel cost per km]       float
);