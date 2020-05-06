USE FreightShipping;

IF OBJECT_ID('dbo.Commodity', 'U') IS NOT NULL
    DROP TABLE Commodity;
GO
CREATE TABLE Commodity
(
    [Commodity Key]           int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [HS Code]                 varchar(6),
    [Description]             nvarchar(100),
    [Package Size (m^3)]      decimal,
    [Package Weight (kg)]     decimal
);
