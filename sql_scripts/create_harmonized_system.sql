USE FreightShipping;

IF OBJECT_ID('dbo.HarmonizedSystem', 'U') IS NOT NULL
    DROP TABLE HarmonizedSystem;
GO

CREATE TABLE HarmonizedSystem
(
    section     varchar(5)    NOT NULL,
    hscode      varchar(6)    NOT NULL,
    description nvarchar(255) NOT NULL,
    parent      varchar(5)    NOT NULL,
    level       tinyint       NOT NULL,
);
