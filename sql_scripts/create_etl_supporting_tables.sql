USE FreightShippingETL;

IF OBJECT_ID('dbo.HSCode', 'U') IS NOT NULL
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


IF OBJECT_ID('dbo.ContainerCompany', 'U') IS NOT NULL
    DROP TABLE ContainerCompany;
GO

create table ContainerCompany
(
    [BIC Code]     nvarchar(4)   not null,
    [Company Name] nvarchar(255) not null
)
go

create unique index [container_company_BIC_code_uindex]
    on ContainerCompany ([BIC Code])
go

alter table ContainerCompany
    add constraint container_company_pk
        primary key nonclustered ([BIC Code])
go


IF OBJECT_ID('dbo.CountryAndContinentCodes', 'U') IS NOT NULL
    DROP TABLE CountryAndContinentCodes;
GO
CREATE TABLE CountryAndContinentCodes
(
    [Continent_Name]                         nvarchar(255),
    [Continent_Code]                         nvarchar(2),
    [Country_Name]                           nvarchar(255),
    [Two_Letter_Country_Code]                nvarchar(2),
    [Three_Letter_Country_Code]              nvarchar(3),
    [Country_Number]                         int
);
