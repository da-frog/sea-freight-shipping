IF OBJECT_ID('dbo.PortDimension', 'U') IS NOT NULL
    DROP TABLE PortDimension;
GO
CREATE TABLE PortDimension
(
    [Port Key]       int IDENTITY (1,1) NOT NULL,
    [Port Name]      varchar(50),
    [Port Type]      varchar(50),
    [Port Country]   varchar(50),
    [Port City]      varchar(50),
    [Port Address]   varchar(100),
    [Port Telephone] varchar(15),
    primary key ([Port Key])
);
