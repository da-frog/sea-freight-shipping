USE FreightShippingDW;

IF OBJECT_ID ('dbo.PortDimension', 'U') IS NOT NULL
    DROP TABLE PortDimension;
GO
CREATE TABLE PortDimension (
    [Port Key]           int IDENTITY (1,1) NOT NULL,
    [Port Name]          nvarchar(50),
    [Port Type]          nvarchar(50),
    [Port Country]       nvarchar(50),
    [Port City]          nvarchar(50),
    [Port Address]       nvarchar(100),
    [Port Telephone]     varchar(15),
    primary key ([Port Key])
);
