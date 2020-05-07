USE FreightShippingDW;

IF OBJECT_ID('dbo.ISOSizeCode2', 'U') IS NOT NULL
    DROP TABLE ISOSizeCode2;
GO
CREATE TABLE ISOSizeCode2

(
[Container height (mm)] decimal,
[Container height (ft)] decimal ,
[Container height (in)] decimal ,
[Code character]		nvarchar(255) ,
[Container width (mm)]	decimal ,
);
