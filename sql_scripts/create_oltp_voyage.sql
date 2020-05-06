USE FreightShipping;

IF OBJECT_ID('dbo.Voyage', 'U') IS NOT NULL
    DROP TABLE Voyage;
GO
CREATE TABLE Voyage
(
    [Voyage Key]              int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Leg Bridge Key]          int NOT NULL REFERENCES LegBridge,
    [Origin Port Key]         int NOT NULL REFERENCES Port,
    [Destination Port Key]    int NOT NULL REFERENCES Port,
);
