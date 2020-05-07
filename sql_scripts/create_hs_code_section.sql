USE FreightShipping;

IF OBJECT_ID('dbo.HSSection', 'U') IS NOT NULL
    DROP TABLE HSSection;
GO

CREATE TABLE HSSection
(
    section     varchar(5)    NOT NULL,
    name        varchar(255)  NOT NULL,
);
