USE FreightShipping;

IF OBJECT_ID('dbo.BillOfLading', 'U') IS NOT NULL
    DROP TABLE BillOfLading;
GO
create table BillOfLading
(
	[Bill-of-Lading Key] int identity,
	[Bill-of-Lading Number] varchar(17),
	[Issued Date] date,
	[Consignor Key] int,
	[Consignee Key] int,
	[Foreign Transporter Key] int,
	[Foreign Consolidator Key] int,
	[Courier Key] int,
	[Domestic Transporter Key] int,
	[Domestic Consolidator Key] int,
	[Ship Mode] int,
	[Place of Receit Key] int,
	[Place of Delivery Key] int,
	[Port of Loading Key] int,
	[Port of Discharge Key] int,
	[Commodity Key] int,
	[Container Key] int,
	Incoterm varchar(3),
	[Expected Tariffs] money,
	[Actual Tariffs] money,
	new_column int
)
go

create unique index [BillOfLading_Bill-of-Lading Number_uindex]
	on BillOfLading ([Bill-of-Lading Number])
go

create unique index "BillOfLading_[Bill-of-Lading Key]_uindex"
	on BillOfLading ([Bill-of-Lading Key])
go

alter table BillOfLading
	add constraint BillOfLading_pk
		primary key nonclustered ([Bill-of-Lading Key])
go


create table Shipment
(
	[Shipment Key] int identity,
	[Voyage Schedule Key] int,
	[Vehicle Key] int,
	[Bill-of-Lading Key] int,
	[Shipment Fees] int
)
go

create unique index [Shipment_Shipment Key_uindex]
	on Shipment ([Shipment Key])
go

alter table Shipment
	add constraint Shipment_pk
		primary key nonclustered ([Shipment Key])
go


create table [Business Entity]
(
	[Business Entity Key] int identity,
	Name nvarchar(255),
	[E-mail] varchar(255),
	Phone varchar(15),
	Fax varchar(15),
	[Address Key] int
)
go

create unique index [Business Entity_Business Entity Key_uindex]
	on [Business Entity] ([Business Entity Key])
go

alter table [Business Entity]
	add constraint [Business Entity_pk]
		primary key nonclustered ([Business Entity Key])
go
create table Address
(
	[Address Key] int identity,
	[Address Line 1] nvarchar(100),
	[Address Line 2] nvarchar(100),
	City nvarchar(100),
	Country nvarchar(50),
	[Alpha 2] varchar(2),
	[ZIP Code] varchar(11),
	Latitude varchar(15),
	Longitude varchar(15)
)
go

create unique index [Address_Address Key_uindex]
	on Address ([Address Key])
go

alter table Address
	add constraint Address_pk
		primary key nonclustered ([Address Key])
go
create table Vehicle
(
	[Vehicle Key] int identity,
	[Vehicle Type] varchar(50),
	[IMO number] varchar(7),
	[Vehicle Name] nvarchar(255),
	[Vehicle Capacity] int,
	[Vehicle Speed (km/h)] decimal,
	[Vehicle Builder] nvarchar(255),
	[Vehicle Fuel Usage per Day] decimal,
	[Current Latitude] varchar(15),
	[Current Longitude] varchar(15)
)
go

create unique index [Vehicle_Vehicle Key_uindex]
	on Vehicle ([Vehicle Key])
go

alter table Vehicle
	add constraint Vehicle_pk
		primary key nonclustered ([Vehicle Key])
go













