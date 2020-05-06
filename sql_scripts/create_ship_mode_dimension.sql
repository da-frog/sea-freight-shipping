USE FreightShippingDW;

IF OBJECT_ID('dbo.ShipModeDimension', 'U') IS NOT NULL
    DROP TABLE ShipModeDimension;
GO
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