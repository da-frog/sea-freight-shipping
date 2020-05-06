USE FreightShippingDW;

IF OBJECT_ID('dbo.BusinessEntityDimension', 'U') IS NOT NULL
    DROP TABLE BusinessEntityDimension;
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
