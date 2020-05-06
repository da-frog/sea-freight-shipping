USE FreightShippingDW;

IF OBJECT_ID ('dbo.DateDimension', 'U') IS NOT NULL
    DROP TABLE DateDimension;
GO
CREATE TABLE DateDimension
(
    [Date Key]                      int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Date]                          date,
    [Full date description]	        varchar(255),
    [Date of Week]		            varchar(9),
    [Day Number in Calendar Month]	tinyint,
    [Day Number in Calendar Year]	smallint,
    [Day Number in Fiscal Month]	tinyint,
    [Day Number in Fiscal Year]		smallint,
    [Last Day in Month Indicator]	varchar(50),
    [Calendar Week Ending Date]     date,
    [Calendar Week Number in Year]  tinyint,
    [Calendar Month Name]           varchar(9),
    [Calendar Month Number in Year] tinyint,
    [Calendar Year-Month (YYYY-MM)] varchar(7),
    [Calendar Quarter]              varchar(2),
    [Calendar Year-Quarter]         varchar(7),
    [Calendar Year]                 smallint,
    [Fiscal Week]                   tinyint,
    [Fiscal Week Number in Year]    tinyint,
    [Fiscal Month]	                tinyint,
    [Fiscal Year-Month]             varchar(7),
    [Fiscal Quarter]                varchar(2),
    [Fiscal Year-Quarter]           varchar(7),
    [Fiscal Year]                   smallint,
);
