USE FreightShipping;

IF OBJECT_ID('dbo.Shipment', 'U') IS NOT NULL
    DROP TABLE Shipment;
GO

IF OBJECT_ID('dbo.BillOfLading', 'U') IS NOT NULL
    DROP TABLE BillOfLading;
GO

IF OBJECT_ID('dbo.Vehicle', 'U') IS NOT NULL
    DROP TABLE Vehicle;
GO

IF OBJECT_ID('dbo.VoyageSchedule', 'U') IS NOT NULL
    DROP TABLE VoyageSchedule;
GO
IF OBJECT_ID('dbo.Voyage', 'U') IS NOT NULL
    DROP TABLE Voyage;
GO

IF OBJECT_ID('dbo.LegScheduleBridge', 'U') IS NOT NULL
    DROP TABLE LegScheduleBridge;
GO
IF OBJECT_ID('dbo.LegSchedule', 'U') IS NOT NULL
    DROP TABLE LegSchedule;
GO

IF OBJECT_ID('dbo.LegBridge', 'U') IS NOT NULL
    DROP TABLE LegBridge;
GO
IF OBJECT_ID('dbo.Leg', 'U') IS NOT NULL
    DROP TABLE Leg;
GO

IF OBJECT_ID('dbo.Port', 'U') IS NOT NULL
    DROP TABLE Port;
GO

IF OBJECT_ID('dbo.BusinessEntity', 'U') IS NOT NULL
    DROP TABLE BusinessEntity;
GO

IF OBJECT_ID('dbo.Address', 'U') IS NOT NULL
    DROP TABLE Address;
GO

IF OBJECT_ID('dbo.Container', 'U') IS NOT NULL
    DROP TABLE Container;
GO

IF OBJECT_ID('dbo.ContainerModel', 'U') IS NOT NULL
    DROP TABLE ContainerModel;
GO

IF OBJECT_ID('dbo.Commodity', 'U') IS NOT NULL
    DROP TABLE Commodity;
GO



create table Address
(
    [Address Key]    int identity,
    [Address Line 1] nvarchar(255),
    [Address Line 2] nvarchar(255),
    [City]           nvarchar(255),
    [Country]        nvarchar(255),
    [Alpha 2]        varchar(2),
    [ZIP Code]       varchar(11),
    [Latitude]       varchar(15),
    [Longitude]      varchar(15)
)
go
create unique index [Address_Address Key_uindex]
    on Address ([Address Key])
go
alter table Address
    add constraint Address_pk
        primary key nonclustered ([Address Key])
go


create table BusinessEntity
(
    [Business Entity Key] int identity,
    [Name]                nvarchar(255),
    [E-mail]              varchar(255),
    [Phone]               varchar(15),
    [Fax]                 varchar(15),
    [Address Key]         int
)
go
alter table BusinessEntity
	add constraint "BusinessEntity_Address_[Address Key]_fk"
		foreign key ([Business Entity Key]) references Address
go
create unique index [Business Entity_Business Entity Key_uindex]
    on BusinessEntity ([Business Entity Key])
go
alter table BusinessEntity
    add constraint [BusinessEntity_pk]
        primary key nonclustered ([Business Entity Key])
go


create table Container
(
    [Container Key] int identity,
    [Owner Code]    varchar(4),
    [Serial Number] varchar(6),
    [Check Digit]   varchar(1),
    [ISO Size Code] varchar(2),
    [ISO Type Code] varchar(2)
)
go
create unique index "Container_[Container Key]_uindex"
    on Container ([Container Key])
go
alter table Container
    add primary key nonclustered ([Container Key])
go


create table ContainerModel
(
    [Container Model Key]        int identity,
    [ISO Size Code]              varchar(2),
    [ISO Type Code]              varchar(2),
    [Model Description]          nvarchar(255),
    [Owner Code]                 varchar(4),
    [Serial Number Range Start]  int,
    [Serial Number Range End]    int,
    [Inside Length (mm)]         int,
    [Inside Width (mm)]          int,
    [Inside Height (mm)]         int,
    [Inside Middle Height (mm)]  int,
    [Inside Side Height (mm)]    int,
    [Max stow Height]            int,
    [Roof Opening Length (mm)]   int,
    [Roof Opening Width (mm)]    int,
    [Door Opening Width (mm)]    int,
    [Door Opening Height (mm)]   int,
    [Door Opening Width C (mm)]  int,
    [Door Opening Width D (mm)]  int,
    [Door Opening Width B (mm)]  int,
    [Door Opening Height E (mm)] int,
    [Door Opening Height F (mm)] int,
    [Max Gross Weight (kg)]      int,
    [Tare Weight (kg)]           int,
    [Max Payload Weight (kg)]    int,
    [Capacity (cbm)]             decimal
)
go
create unique index "ContainerModel_[Container Model Key]_uindex"
    on ContainerModel ([Container Model Key])
go
alter table ContainerModel
    add constraint ContainerModel_pk
        primary key nonclustered ([Container Model Key])
go


create table Commodity
(
    [Commodity Key]       int identity,
    [HS Code]             varchar(6),
    [Description]         nvarchar(255),
    [Package Size (m^3)]  decimal,
    [Package Weight (kg)] decimal
)
go
create unique index "Commodity_[Commodity Key]_uindex"
    on Commodity ([Commodity Key])
go
alter table Commodity
    add primary key nonclustered ([Commodity Key])
go


create table Port
(
    [Port Key]       int identity
        constraint Port___fk_1
            references Address,
    [Address Key]    int,
    [Port Name]      nvarchar(255),
    [Port Type]      nvarchar(255),
    [Port Size]      nvarchar(255),
    [UN/LOCODE]      varchar(10),
    Phone            varchar(15),
    Fax              varchar(15),
    [800 Number]     varchar(15),
    Email            varchar(255),
    Website          varchar(255)
)
go
create unique index "Port_[Port Key]_uindex"
    on Port ([Port Key])
go
alter table Port
    add primary key nonclustered ([Port Key])
go


create table Leg
(
	[Leg Key] int not null
		primary key nonclustered,
	[Origin Port Key] int not null
		constraint Leg_Port__fk_1
			references Port,
	[Destination Port Key] int not null
		constraint Leg_Port__fk_2
			references Port,
	[Leg Miles] decimal
)
go


create table LegBridge
(
	[Leg Bridge SK] int identity,
	[Leg Key] int not null,
	[Leg Bridge Key] int not null
		constraint "LegBridge_Leg_[Leg Key]_fk"
			references Leg,
	constraint Leg_pk
		unique ([Leg Bridge Key], [Leg Key])
)
go

create unique index [LegBridge_Leg Bridge SK_uindex]
	on LegBridge ([Leg Bridge SK])
go

alter table LegBridge
	add constraint LegBridge_pk
		primary key nonclustered ([Leg Bridge SK])
go


create table LegSchedule
(
    [Leg Schedule Key]                        int identity,
    [Leg Key]                                 int not null
        constraint LegSchedule___fk_1
            references Leg,
    [Origin Port Scheduled Departure Date]    date,
    [Destination Port Scheduled Arrival Date] date,
    [Origin Port Actual Departure Date]       date,
    [Destination Port Actual Arrival Date]    date
)
go
create unique index "LegSchedule_[Leg Schedule Key]_uindex"
    on LegSchedule ([Leg Schedule Key])
go
alter table LegSchedule
    add primary key nonclustered ([Leg Schedule Key])
go


create table LegScheduleBridge
(
    [Leg Schedule Bridge Key] int not null,
    [Leg Schedule Key]        int not null
        references LegSchedule,
    constraint LegScheduleBridge_pk
        unique ([Leg Schedule Bridge Key], [Leg Schedule Key])
)
go


create table Voyage
(
	[Voyage Key] int identity,
	[Leg Bridge Key] int not null,
	[Origin Port Key] int not null
		constraint "Voyage_Port_[Port Key]_fk"
			references Port,
	[Destination Port Key] int not null
		constraint "Voyage_Port_[Port Key]_fk_2"
			references Port
)
go

create unique index "Voyage_[Voyage Key]_uindex"
	on Voyage ([Voyage Key])
go

alter table Voyage
	add primary key nonclustered ([Voyage Key])
go



create table VoyageSchedule
(
	[Voyage Schedule Key] int identity
		constraint "VoyageSchedule_Voyage_[Voyage Key]_fk"
			references Voyage,
	[Voyage Key] int not null,
	[Leg Schedule Bridge Key] int not null
)
go

create unique index "VoyageSchedule_[Voyage Schedule Key]_uindex"
	on VoyageSchedule ([Voyage Schedule Key])
go

alter table VoyageSchedule
	add primary key nonclustered ([Voyage Schedule Key])
go



create table BillOfLading
(
	[Bill-of-Lading Key] int identity,
	[Bill-of-Lading Number] varchar(17),
	[Issued Date] date,
	[Consignor Key] int
		references BusinessEntity,
	[Consignee Key] int
		references BusinessEntity,
	[Foreign Transporter Key] int
		references BusinessEntity,
	[Foreign Consolidator Key] int
		references BusinessEntity,
	[Courier Key] int
		references BusinessEntity,
	[Domestic Transporter Key] int
		references BusinessEntity,
	[Domestic Consolidator Key] int
		references BusinessEntity,
	[Ship Mode] varchar(50),
	[Place of Receipt Key] int
		references Address,
	[Place of Delivery Key] int
		references Address,
	[Port of Loading Key] int
		references Port,
	[Port of Discharge Key] int
		references Port,
	[Commodity Key] int
		references Commodity,
	[Container Key] int
		references Container,
	Incoterm varchar(3),
	[Expected Tariffs] money,
	[Actual Tariffs] money
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


create table Vehicle
(
    [Vehicle Key]                int identity,
    [Vehicle Type]               nvarchar(255),
    [IMO number]                 varchar(7),
    [Vehicle Name]               nvarchar(255),
    [Vehicle Capacity]           int,
    [Vehicle Speed (km/h)]       decimal,
    [Vehicle Builder]            nvarchar(255),
    [Vehicle Fuel Usage per Day] decimal,
    [Current Latitude]           varchar(15),
    [Current Longitude]          varchar(15)
)
go
create unique index [Vehicle_Vehicle Key_uindex]
    on Vehicle ([Vehicle Key])
go
alter table Vehicle
    add constraint Vehicle_pk
        primary key nonclustered ([Vehicle Key])
go


create table Shipment
(
	[Shipment Key] int identity,
	[Voyage Schedule Key] int,
	[Vehicle Key] int,
	[Bill-of-Lading Key] int,
	[Shipment Fees] money,
	constraint Shipment_BillOfLading__fk
		foreign key ([Bill-of-Lading Key]) references BillOfLading,
	constraint Shipment_Vehicle__fk
		foreign key ([Vehicle Key]) references Vehicle,
	constraint Shipment_VoyageSchedule__fk
		foreign key ([Voyage Schedule Key]) references VoyageSchedule
)
go

create unique index [Shipment_Shipment Key_uindex]
	on Shipment ([Shipment Key])
go

alter table Shipment
	add constraint Shipment_pk
		primary key nonclustered ([Shipment Key])
go
