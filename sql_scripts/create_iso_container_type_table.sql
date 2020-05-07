USE FreightShippingDW;

IF OBJECT_ID('dbo.ISOTypeCode', 'U') IS NOT NULL
    DROP TABLE ISOTypeCode;
GO

CREATE TABLE ISOTypeCode
(
    [Code]                       nvarchar(255),
	[Type group code]            nvarchar(255),
    [Type Designation]           nvarchar(255),
	[Detailed Type Code]         nvarchar(255),
    [Type Group Description]     nvarchar(255),
    [Main Characteristics]       nvarchar(255)
);

