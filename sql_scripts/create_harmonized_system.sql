USE FreightShippingDW;

IF OBJECT_ID('dbo.HarmonizedSystem', 'U') IS NOT NULL
	DROP TABLE HarminizedSystem;
GO

CREATE TABLE HarmonizedSystem(
	section	char(5),
	hscode int,
	description char(999),
	parent char(5),
	level int);