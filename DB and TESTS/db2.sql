USE [DB2019_Ass2]
GO

/*deletion*/
DELETE FROM Resident
DELETE FROM Apartment
DELETE FROM CarParking
DELETE FROM Cars
DELETE FROM CellPhones
DELETE FROM Department
DELETE FROM ParkingArea
DELETE FROM Project
DELETE FROM Neighborhood
DELETE FROM ProjectConstructorEmployee
DELETE FROM OfficialEmployee
DELETE FROM ConstructorEmployee
DELETE FROM Employee

/*adding*/

INSERT INTO [Neighborhood]
	([Name],[NID])
	VALUES
	('POLEG','10'),
	('HADARIM','9'),
	('IRISIM','8')


INSERT INTO [Apartment]
	([StreetName],[Number],[Door],[type],[SizeSquareMeter],[NeighborhoodID])
	VALUES
	('ADMONIT','8','6','Cotege','65','10'),
	('IRIS','1','1','Cotege','70','8'),
	('HADAR','1','1','Cotege','45','9'),
	('HADAR','2','1','Cotege','45','9'),
	('ADMONIT','9','7','Cotege','65','10')
	
INSERT INTO [Resident]
	([RID],[LastName],[FirstName],[BirthDate],[StreetName],[Number],[door])
	VALUES
	('236','Levi','Jonathan','1993-07-01','ADMONIT','8','6'),
	('234','COHEN','AVI','1991-09-08','HADAR','2','1'),
	('233','COHEN','TAMAR','1991-08-03','HADAR','2','1'),
	('001','ron','ron','2005-05-05','HADAR','2','1')

INSERT INTO [ParkingArea]
	([AID],[Name],[priceperhour] ,[maxpriceperday],[NeighborhoodID])
	VALUES
	('1','PARK','25','150','10'),
	('5','MALL','5','25','10')

INSERT INTO [Employee]
	([EID],[LastName],[FirstName],[BirthDate],[StreetName],[Number],[door],[City])
	VALUES
	('001','lastname_const_employee03','TheOldestConsEmplo','1900-05-08','HADAR','2','1','TELAVIV'),
	('134','lastname_const_employee02','AVI','1991-05-08','HADAR','2','1','RAANANA'),
	('136','lastname_offic_employee01','Jonathan','1993-04-12','ADMONIT','8','6','RAANANA'),
	('137','lastname_offic_employee02','John','1955-12-05','HADAR','2','1','HODHASHARON'),
	('133','lastname_const_employee01','TAMAR','1991-02-15','HADAR','2','1','RAANANA')

INSERT INTO [ConstructorEmployee]
	([EID],[CompanyName],[SalaryPerDay])
	VALUES
	('001','ABC','80'),
	('133','NZP','109'),
	('134','NZP','190')
	
INSERT INTO [Project]
	([PID],[Name],[Description],[Budget],[NeighborhoodID])
	VALUES
	('88','GreenRAANANA','Project no 1','10000','8'),
	('87','BlueEILAT','Project no 2','50000','10'),
	('89','NewTLV','Project no 3','20000','8'),
	('90','NewRamatGan','Project no 4','15000','9')

INSERT INTO [ProjectConstructorEmployee]
	([PID],[EID],[StartWorkingDate],[EndWorkingDate],[JobDescription])
	VALUES
	('88','133','2018-03-16','','Project Engineer'),
	('87','133','2016-11-02','','Project Engineer'),
	('89','133','1992-08-20','1995-08-20','Project Engineer'),
	('90','133','2017-01-17','','Project Engineer'),
	('88','134','2018-03-16','','Worker')

 INSERT INTO [Cars]
	([CID],[CellPhoneNumber] ,[CreditCard] ,[ExpirationDate] ,[ThreeDigits],[ID])
	VALUES
	('16358945','052976482155','5326124515784558','2022-09-01','784','204612875'),
	('16358947','052976482157','5326124515784557','2022-09-01','785','204612877'),
	('16358962','052976482162','5326124515784562','2022-09-01','784','204612862'),
	('16358963','052976482162','5326124515784562','2022-09-01','784','236'),
	('0005','1800400400','0123456','2022-09-05','123','001')

 INSERT INTO [CarParking]
	([CID],[StartTime] ,[EndTime],[ParkingAreaID],[Cost])
	VALUES
	('16358945','2018-12-07 09:00:00','2018-12-07 10:00:00','1','150'),
	('16358947','2018-12-08 09:00:00','2018-12-08 10:00:00','1','50'),
	('16358962','2018-12-07 09:00:00','2018-12-07 10:00:00','1','100'),
	('16358963','2018-11-07 08:00:00','2018-11-07 11:00:00','1','90'),
	('0005','2018-10-07 08:00:00','2018-10-07 11:00:00','1','90'),
	('0005','2016-11-07 08:00:00','2016-11-07 11:00:00','1','90'),
	('0005','2017-11-07 08:00:00','2017-11-07 11:00:00','1','90'),
	('0005','2016-10-07 08:00:00','2016-10-07 11:00:00','5','90')


INSERT INTO [Department]
	([DID] ,[Name] ,[Description] ,[ManagerId])
	VALUES
	('356','IS','A Great Department',NULL)
		
INSERT INTO [OfficialEmployee]
	([EID],[StartDate],[Degree],[DepartmentId])
	VALUES
	('136','2012-03-01','CEO','356')

UPDATE [Department]
SET [ManagerId]='136'
WHERE [DID]='356' AND [Name]='IS' AND [Description]='A Great Department'
	
INSERT INTO [OfficialEmployee]
	([EID],[StartDate],[Degree],[DepartmentId])
	VALUES
	('137','2013-03-02','PMO','356')
	