IF (SELECT object_id('dbo.ShipModeDim')) > 0
	DROP TABLE dbo.ShipModeDim;

CREATE TABLE ShipModeDim(
	[Ship Mode Key]          int IDENTITY (1,1) NOT NULL,
	[Vehicle Type]           nvarchar(50),
	[Vehicle Name]           nvarchar(100),
	[Vehicle Capacity]       float,
	[Vehicle Speed (km/h)]   float,
	[Vehicle Speed (mile/h)] float,
	[Vehicle Builder]        nvarchar(100),
	[Fuel cost per mile]     float,
	[Fuel cost per km]       float
);