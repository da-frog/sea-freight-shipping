USE FreightShippingDW;

IF OBJECT_ID('dbo.HarmonizedSystem', 'U') IS NOT NULL
	DROP TABLE HarminizedSystem;
GO

CREATE TABLE HarmonizedSystem
(
    section     varchar(5),
    hscode      varchar(6),
    description varchar(255),
    parent      varchar(5),
    level       tinyint
);
