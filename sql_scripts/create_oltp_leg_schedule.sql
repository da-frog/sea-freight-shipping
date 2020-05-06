USE FreightShipping;

IF OBJECT_ID('dbo.LegSchedule', 'U') IS NOT NULL
    DROP TABLE LegSchedule;
GO
CREATE TABLE LegSchedule
(
    [Leg Schedule Key]                          int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Leg Key]                                   int NOT NULL REFERENCES Leg,
    [Origin Port Scheduled Departure Date]      date,
    [Destination Port Scheduled Arrival Date]   date,
    [Origin Port Actual Departure Date]         date,
    [Destination Port Actual Arrival Date]      date,
);