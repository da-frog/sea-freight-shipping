USE FreightShipping;

IF OBJECT_ID('dbo.HSSection', 'U') IS NOT NULL
    DROP TABLE HSSection;
GO

CREATE TABLE HSSection
(
    section     nvarchar(5)    NOT NULL,
    name        nvarchar(255)  NOT NULL,
);
