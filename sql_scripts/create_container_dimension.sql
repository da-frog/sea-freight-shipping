USE FreightShippingDW;

IF OBJECT_ID('dbo.ContainerDimension', 'U') IS NOT NULL
    DROP TABLE ContainerDimension;
GO
CREATE TABLE ContainerDimension
(
    [Container Key]                     int IDENTITY (1,1) NOT NULL,
    [Container Number]                  varchar(11),
    [Container Size (Volume)]           decimal,
    [Container Type]                    varchar(100),
    [Container Tare Weight(Kg)]         decimal,
    [Container Inside Length (m)]       decimal,
    [Container Inside Width (m)]        decimal,
    [Container Inside Height (m)]       decimal,
    [Container Inside Length (ft)]      decimal,
    [Container Inside Width (ft)]       decimal,
    [Container Inside Height (ft)]      decimal,
    [Container Outside Length (m)]      decimal,
    [Container Outside Width (m)]       decimal,
    [Container Outside Height (m)]      decimal,
    [Container Outside Length (ft)]     decimal,
    [Container Outside Width (ft)]      decimal,
    [Container Outside Height (ft)]     decimal,
    [Container Capacity]                decimal,
    [Container Electricity Indicator]   varchar(50),
    [Container Refrigeration Indicator] varchar(50),
    [Container Thermal Indicator]       varchar(50),
    [Container Dangerous Indicator]     varchar(50),
)