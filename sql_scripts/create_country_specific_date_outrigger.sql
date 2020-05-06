USE FreightShippingDW;

IF OBJECT_ID ('dbo.CountrySpecificDateOutrigger', 'U') IS NOT NULL
    DROP TABLE CountrySpecificDateOutrigger;
GO
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
