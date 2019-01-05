USE [DB2019_Ass2]
GO

/*--1--*/
DELETE FROM ConstructorEmployee
DELETE FROM OfficialEmployee
DELETE FROM Employee
INSERT INTO Employee
	(EID,LastName,FirstName,BirthDate,StreetName,Number,door,City)
	VALUES
	('001','lastname_const_employee03','TheOldestConsEmplo','1900-05-08','HADAR','2','1','TELAVIV'),
	('134','lastname_const_employee02','AVI','1991-05-08','HADAR','2','1','RAANANA'),
	('136','lastname_offic_employee01','Jonathan','1993-04-12','ADMONIT','8','6','RAANANA'),
	('137','lastname_offic_employee02','John','1955-12-05','HADAR','2','1','HODHASHARON'),
	('133','lastname_const_employee01','TAMAR','1991-02-15','HADAR','2','1','RAANANA')
INSERT INTO ConstructorEmployee
	(EID,CompanyName,SalaryPerDay)
	VALUES
	('001','ABC','80'),
	('133','NZP','109'),
	('134','NZP','190')
select * from ConstructionEmployeeOverFifty;
GO

/*--2--*/
delete from resident
delete from Apartment
delete from Neighborhood
INSERT INTO Neighborhood
	(Name,NID)
	VALUES
	('POLEG','10'),
	('HADARIM','9'),
	('IRISIM','8')
INSERT INTO Apartment
	(StreetName,Number,Door,type,SizeSquareMeter,NeighborhoodID)
	VALUES
	('ADMONIT','8','6','Cotege','65','10'),
	('IRIS','1','1','Cotege','70','8'),
	('HADAR','1','1','Cotege','45','9'),
	('HADAR','2','1','Cotege','45','9'),
	('ADMONIT','9','7','Cotege','65','10')
select * from ApartmentNumberInNeighborhood

/*--3--*/
delete from CarParking
delete from ParkingArea
delete from Cars

INSERT INTO [Cars]
	([CID],[CellPhoneNumber] ,[CreditCard] ,[ExpirationDate] ,[ThreeDigits],[ID])
	VALUES
	('16358945','052976482155','5326124515784558','2022-09-01','784','204612875'),
	('16358947','052976482157','5326124515784557','2022-09-01','785','204612877'),
	('16358962','052976482162','5326124515784562','2022-09-01','784','204612862'),
	('16358963','052976482162','5326124515784562','2022-09-01','784','236'),
	('0005','1800400400','0123456','2022-09-05','123','001')
INSERT INTO [ParkingArea]
	([AID],[Name],[priceperhour] ,[maxpriceperday],NeighborhoodID)
	VALUES
	('1','PARK','25','150','10'),
	('5','MALL','5','25','10'),
	('8888','fall','5','25','10')
INSERT INTO [CarParking]
	([CID],[StartTime] ,[EndTime],ParkingAreaID,[Cost])
	VALUES
	('16358945','2018-12-07 09:00:00','2018-12-07 10:00:00','1','150'),
	('16358947','2018-12-08 09:00:00','2018-12-08 10:00:00','1','50'),
	('16358962','2018-12-07 09:00:00','2018-12-07 10:00:00','1','100'),
	('16358963','2018-11-07 08:00:00','2018-11-07 11:00:00','1','90'),
	('0005','2018-10-07 08:00:00','2018-10-07 11:00:00','1','90'),
	('0005','2016-11-07 08:00:00','2016-11-07 11:00:00','1','90'),
	('0005','2017-11-07 08:00:00','2017-11-07 11:00:00','1','90'),
	('0005','2016-10-07 08:00:00','2016-10-07 11:00:00','5','90')
select * from MaxParking