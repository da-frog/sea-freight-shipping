USE FreightShipping;

IF OBJECT_ID('dbo.ISOTypeCode', 'U') IS NOT NULL
    DROP TABLE ISOTypeCode;
GO

CREATE TABLE ISOTypeCode
(
    [Code]                              nvarchar(1) NOT NULL,
    [Type group code]                   nvarchar(2) NOT NULL,
    [Detailed Type Code]                nvarchar(2) NOT NULL,
    [Type Designation]                  nvarchar(255),
    [Type Group Description]            nvarchar(255),
    [Main Characteristics]              nvarchar(255),
    [Container Electricity Indicator]   nvarchar(255),
    [Container Refrigeration Indicator] nvarchar(255),
    [Container Danger Indicator]        nvarchar(255)
);
