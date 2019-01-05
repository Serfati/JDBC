Create Database DB2019_Ass2;
GO
USE [DB2019_Ass2]
GO

CREATE TABLE [Employee](
	[EID] [int]  Primary key,
	[LastName] [varchar](255) ,
	[FirstName] [varchar](255) ,
	[BirthDate] [date] ,
	[StreetName] [varchar](255) ,
	[Number] [int] ,
	[door] [int] ,
	[City] [varchar](255) ,
);

CREATE TABLE [dbo].[CellPhones](
	[EID] [int] ,
	[CellPhone] [varchar](12) ,
	primary key (EID, [CellPhone]),
	CONSTRAINT [FK_EIDCell] FOREIGN KEY([EID]) REFERENCES [dbo].[Employee] ([EID]) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE [dbo].[ConstructorEmployee](
	[EID] [int]  primary key,
	[CompanyName] [varchar](255) ,
	[SalaryPerDay] [int] ,
	CONSTRAINT [FK_EID] FOREIGN KEY([EID]) REFERENCES [dbo].[Employee] ([EID]) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE [dbo].[Department](
	[DID] [int]  primary key,
	[Name] [varchar](255) ,
	[Description] [varchar](255) ,
	[ManagerId] [int]
);


CREATE TABLE [dbo].[OfficialEmployee](
	[EID] [int]  primary key,
	[StartDate] [date] ,
	[Degree] [varchar](255) ,
	[DepartmentId] [int] ,
	CONSTRAINT [FK_DIDOfficial] FOREIGN KEY([EID]) REFERENCES [dbo].[Employee] ([EID]) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT [FK_EIDOfficial] FOREIGN KEY([DepartmentId]) REFERENCES [dbo].[Department] ([DID]) ON UPDATE CASCADE ON DELETE CASCADE
);


ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_DepMan] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[OfficialEmployee] ([EID]) ON DELETE No Action


CREATE TABLE [dbo].[Neighborhood](
	[NID] [int]  primary key,
	[Name] [varchar](255) ,
);


CREATE TABLE [dbo].[Project](
	[PID] [int]  primary key,
	[Name] [varchar](255) ,
	[Description] [varchar](255),
	[Budget] [int] ,
	[NeighborhoodID] [int] ,
	CONSTRAINT [FK_ProjectNID] FOREIGN KEY([NeighborhoodID]) REFERENCES [dbo].[Neighborhood] ([NID]) ON UPDATE No action ON DELETE No action
);
CREATE TABLE [dbo].[ProjectConstructorEmployee](
	[PID] [int] ,
	[EID] [int] ,
	[StartWorkingDate] [date] ,
	[EndWorkingDate] [date] ,
	[JobDescription] [varchar](255) ,
	Primary key ([PID],[EID]),
	CONSTRAINT [FK_EIDPCE] FOREIGN KEY([EID]) REFERENCES [dbo].[ConstructorEmployee] ([EID]) ON UPDATE No action ON DELETE No action,
	CONSTRAINT [FK_PIDPCE] FOREIGN KEY([PID]) REFERENCES [dbo].[Project] ([PID]) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE [dbo].[Apartment](
	[StreetName] [varchar](255) ,
	[Number] [int] ,
	[Door] [int] ,
	[type] [varchar](255) ,
	[SizeSquareMeter] [int] ,
	[NeighborhoodID] [int] ,
	PRIMARY KEY ([StreetName],[Number],[Door]),
	CONSTRAINT [FK_ApartmentNID] FOREIGN KEY([NeighborhoodID]) REFERENCES [dbo].[Neighborhood] ([NID]) ON UPDATE no action ON DELETE no action
);


CREATE TABLE [dbo].[Resident](
	[RID] [int]  primary key,
	[LastName] [varchar](255) ,
	[FirstName] [varchar](255) ,
	[BirthDate] [date] ,
	[StreetName] [varchar](255) ,
	[Number] [int] ,
	[door] [int] ,
	CONSTRAINT [FK_ResidentApatment1] FOREIGN KEY([StreetName], [Number], [door]) REFERENCES [dbo].[Apartment] ([StreetName], [Number], [Door]) ON UPDATE no action ON DELETE no action
);

CREATE TABLE [dbo].[ParkingArea](
	[AID] [int]  primary key,
	[Name] [varchar](255) ,
	[priceperhour] [int] ,
	[maxpriceperday] [int] ,
	[NeighborhoodID] [int] ,
	 CONSTRAINT [FK_ParkingNID] FOREIGN KEY([NeighborhoodID]) REFERENCES [dbo].[Neighborhood] ([NID]) ON UPDATE CASCADE ON DELETE CASCADE,
	 Check ([maxpriceperday]> [priceperhour])
);



CREATE TABLE [dbo].[Cars](
	[CID] [int]  primary key,
	[CellPhoneNumber] [varchar](12) ,
	[CreditCard] [varchar](20) ,
	[ExpirationDate] Date ,
	[ThreeDigits] [varchar](3) ,
	[ID] [int] ,
	--CONSTRAINT [FK_CarsRID] FOREIGN KEY([RID]) REFERENCES [dbo].[Resident] ([RID]) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE [dbo].[CarParking](
	[CID] [int] ,
	[StartTime] [datetime] ,
	[EndTime] [datetime] ,
	[ParkingAreaID] [int] ,
	[Cost] [int] ,
	PRIMARY KEY ([CID],	[StartTime]),
	CONSTRAINT [FK_CarPark] FOREIGN KEY([CID]) REFERENCES [dbo].[Cars] ([CID]) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT [FK_CarParkArea] FOREIGN KEY([ParkingAreaID]) REFERENCES [dbo].[ParkingArea] ([AID]) ON UPDATE set null ON DELETE set null,
	check ([EndTime]>[StartTime])
);











