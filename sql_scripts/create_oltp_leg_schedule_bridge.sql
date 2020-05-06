USE FreightShipping;

IF OBJECT_ID('dbo.LegScheduleBridge', 'U') IS NOT NULL
    DROP TABLE LegScheduleBridge;
GO
CREATE TABLE LegScheduleBridge
(
    [Leg Schedule Bridge Key]     int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Leg Schedule Key]            int NOT NULL REFERENCES LegSchedule,
);
