USE FreightShippingDW;

IF OBJECT_ID ('dbo.CommodityDimension', 'U') IS NOT NULL
    DROP TABLE CommodityDimension;
GO
CREATE TABLE CommodityDimension (
    [Commodity Key]				int IDENTITY (1,1) NOT NULL,
	[HS Code]					varchar(6),
	[Commodity Description]		nvarchar(100),
	[Catagory Description]		nvarchar(100),
	[Subcategory Description]	nvarchar(100),
	[Package Size (m^3)]		float,
	[Package Weight (kg)]		float
);
