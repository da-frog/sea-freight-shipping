USE FreightShipping;

IF OBJECT_ID('dbo.HarmonizedSystem', 'U') IS NOT NULL
    DROP TABLE HSCode;
GO
CREATE TABLE HSCode
(
    section     nvarchar(5)   NOT NULL,
    hscode      nvarchar(6)   NOT NULL,
    description nvarchar(255) NOT NULL,
    parent      nvarchar(5)   NOT NULL,
    level       tinyint       NOT NULL,
);

IF OBJECT_ID('dbo.HSSection', 'U') IS NOT NULL
    DROP TABLE HSSection;
GO
CREATE TABLE HSSection
(
    section nvarchar(5)   NOT NULL,
    name    nvarchar(255) NOT NULL,
);
USE FreightShipping;

IF OBJECT_ID('dbo.ISOSizeCode1', 'U') IS NOT NULL
    DROP TABLE ISOSizeCode1;
GO
CREATE TABLE ISOSizeCode1
(
    [Container length (mm)] int,
    [Container length (ft)] int,
    [Container length (in)] int,
    [Code character]        nvarchar(1),
);

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
