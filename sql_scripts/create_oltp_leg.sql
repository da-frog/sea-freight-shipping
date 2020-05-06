USE FreightShipping;

IF OBJECT_ID('dbo.Leg', 'U') IS NOT NULL
    DROP TABLE Leg;
GO
CREATE TABLE Leg
(
    [Leg Key]                  int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Origin Port Key]          int NOT NULL REFERENCES Port,
    [Destination Port Key]     int NOT NULL REFERENCES Port,
	[Leg Miles]                decimal
);
