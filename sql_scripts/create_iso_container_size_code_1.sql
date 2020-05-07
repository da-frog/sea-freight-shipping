USE FreightShippingDW;

IF OBJECT_ID('dbo.ISOSizeCode1', 'U') IS NOT NULL
    DROP TABLE ISOSizeCode1;
GO

CREATE TABLE ISOSizeCode1
(
    [Container length (mm)] int,
    [Container length (ft)] int,
    [Container length (in)] int,
    [Code character]        nvarchar(255)
);