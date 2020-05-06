USE FreightShipping;

IF OBJECT_ID('dbo.LegBridge', 'U') IS NOT NULL
    DROP TABLE LegBridge;
GO
CREATE TABLE Leg
(
    [Leg Bridge Key]     int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Leg Key]            int NOT NULL REFERENCES Leg,
);
