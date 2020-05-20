USE FreightShipping;

IF OBJECT_ID('dbo.HSCode', 'U') IS NOT NULL
    DROP TABLE HSCode;
GO

CREATE TABLE HSCode
(
    section     nvarchar(5)    NOT NULL,
    hscode      nvarchar(6)    NOT NULL,
    description nvarchar(255) NOT NULL,
    parent      nvarchar(5)    NOT NULL,
    level       tinyint       NOT NULL,
);
