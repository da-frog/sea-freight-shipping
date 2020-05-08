USE FreightShipping;

IF OBJECT_ID('dbo.Shipment', 'U') IS NOT NULL
    TRUNCATE TABLE Shipment;
GO
IF OBJECT_ID('dbo.VoyageSchedule', 'U') IS NOT NULL
    TRUNCATE TABLE VoyageSchedule;
GO
IF OBJECT_ID('dbo.Voyage', 'U') IS NOT NULL
    TRUNCATE TABLE Voyage;
GO
IF OBJECT_ID('dbo.LegScheduleBridge', 'U') IS NOT NULL
    TRUNCATE TABLE LegScheduleBridge;
GO
IF OBJECT_ID('dbo.LegSchedule', 'U') IS NOT NULL
    TRUNCATE TABLE LegSchedule;
GO
IF OBJECT_ID('dbo.LegBridge', 'U') IS NOT NULL
    TRUNCATE TABLE LegBridge;
GO
IF OBJECT_ID('dbo.Leg', 'U') IS NOT NULL
    TRUNCATE TABLE Leg;
GO
IF OBJECT_ID('dbo.Vehicle', 'U') IS NOT NULL
    TRUNCATE TABLE Vehicle;
GO
IF OBJECT_ID('dbo.BillOfLading', 'U') IS NOT NULL
    TRUNCATE TABLE BillOfLading;
GO
IF OBJECT_ID('dbo.Port', 'U') IS NOT NULL
    TRUNCATE TABLE Port;
GO
IF OBJECT_ID('dbo.BusinessEntity', 'U') IS NOT NULL
    TRUNCATE TABLE BusinessEntity;
GO
IF OBJECT_ID('dbo.Address', 'U') IS NOT NULL
    TRUNCATE TABLE Address;
GO
IF OBJECT_ID('dbo.Commodity', 'U') IS NOT NULL
    TRUNCATE TABLE Commodity;
GO
IF OBJECT_ID('dbo.Container', 'U') IS NOT NULL
    TRUNCATE TABLE Container;
GO
IF OBJECT_ID('dbo.ContainerModel', 'U') IS NOT NULL
    TRUNCATE TABLE ContainerModel;
GO
