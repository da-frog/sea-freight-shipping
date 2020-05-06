IF (SELECT OBJECT_ID('dbo.PortDim')) > 0
    DROP TABLE dbo.PortDim;

CREATE TABLE PortDim (
    [Port Key]           int IDENTITY (1,1) NOT NULL,
    [Port Name]          nvarchar(50),
    [Port Country]       nvarchar(50),
    [Port City]          nvarchar(50),
    [Port Address]       nvarchar(500),
    [Port Telephone]     int,
    [Port Opening Hour]  int,
    [Port Closing Hour]  int,
);
