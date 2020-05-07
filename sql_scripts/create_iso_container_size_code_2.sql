USE FreightShipping;

IF OBJECT_ID('dbo.ISOSizeCode2', 'U') IS NOT NULL
    DROP TABLE ISOSizeCode2;
GO

CREATE TABLE ISOSizeCode2
(
    [Container height (mm) Range Start] int,
    [Container height (mm) Range End]   int,
    [Container height (ft) Range Start] int,
    [Container height (ft) Range End]   int,
    [Container height (in)]             int,
    [Code character]                    nvarchar(1),
    [Container width (mm) Range Start]  int,
    [Container width (mm) Range End]    int,
);
