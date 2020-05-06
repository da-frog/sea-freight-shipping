USE FreightShipping;

IF OBJECT_ID('dbo.VoyageSchedule', 'U') IS NOT NULL
    DROP TABLE VoyageSchedule;
GO
CREATE TABLE VoyageSchedule
(
    [Voyage Schedule Key]           int IDENTITY (1,1) NOT NULL PRIMARY KEY,
    [Voyage Key]                    int NOT NULL REFERENCES Voyage,
    [Leg Schedule Bridge Key]       int NOT NULL REFERENCES LegScheduleBridge,
);
