USE FreightShipping;

IF OBJECT_ID('dbo.Container', 'U') IS NOT NULL
    DROP TABLE Container;
GO
CREATE TABLE Container
(
    [Container Key]  int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Owner Code]     varchar(4),
    [Serial Number]  int,
    [Check Digit]    int,
    [ISO Size Code]  varchar(2),
	[ISO Type Code]  varchar(2)
);