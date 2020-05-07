USE FreightShippingDW;

IF OBJECT_ID('dbo.ISOSizeCode2', 'U') IS NOT NULL
    DROP TABLE ISOSizeCode2;
GO
CREATE TABLE ISOSizeCode2

(
[Container height (mm)] int,
[Container height (ft)] int,
[Container height (in)] int,
[Code character]		nvarchar(255),
[Container width (mm)]	int,
);
