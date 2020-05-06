IF (SELECT object_id('dbo.ContainerDim')) > 0
DROP TABLE dbo.ContainerDim
CREATE TABLE dbo.ContainerDim

(
[Container Key]						int IDENTITY (1,1) NOT NULL,
[Container Number]					varchar(100),
[Container Size (Volume)]			int,
[Container Type]					varchar(100),
[Container Tare Weight(Kg)]			int,
[Container Inside Length (m)]		float,
[Container Inside Width (m)]		float,
[Container Inside Height (m)]		float,
[Container Inside Length (ft)]		float,
[Container Inside Width (ft)]		float,
[Container Inside Height (ft)]		float,
[Container Outside Length (m)]		float,
[Container Outside Width (m)]		float,
[Container Outside Height (m)]		float,
[Container Outside Length (ft)]		float,
[Container Outside Width (ft)]		float,
[Container Outside Height (ft)]		float,
[Container Capacity]				float,
[Container Electricity Indicator]	nvarchar(100),
[Container Refrigeration Indicator]	nvarchar(100),
[Container Thermal Indicator]		nvarchar(100),
[Container Dangerous Indicator]		nvarchar(100),
)