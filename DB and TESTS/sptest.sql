USE DB2019_Ass2
GO

/*--1--*/
DELETE FROM Employee
exec sp_AddMunicipalEnployee '1','bar','ron','2001-02-20','rager', '1','2','beer sheva'
select * from employee

/*--2--*/
delete from department
insert into Department
(DID ,Name ,Description)
VALUES
('1','IS','A Great Department')
delete from OfficialEmployee
delete from employee
exec sp_AddMunicipalEnployeeOfficial '1','bar','ron','2001-02-20','rager', '1','2','beer sheva', '2008-01-10', 'high', '1'
select * from employee
select * from OfficialEmployee

/*--3--*/
delete from department
insert into Department
(DID ,Name ,Description)
VALUES
('1','IS','A Great Department')
delete from ConstructorEmployee
delete from employee
exec sp_AddMunicipalEnployeeConstructor '1','bar','ron','2001-02-20','rager', '1','2','beer sheva', 'keshet', '600'
select * from employee
select * from ConstructorEmployee

/*--4--*/
delete from Neighborhood
insert into Neighborhood
(Name,NID)
values
('POLEG','1')
delete from ParkingArea
insert into ParkingArea 
(AID, Name, priceperhour, maxpriceperday, NeighborhoodID)
values
('1','PARK','25','150','1')
delete from Cars
insert into cars
(CID,CellPhoneNumber ,CreditCard ,ExpirationDate ,ThreeDigits,ID)
values
('1001','1800400400','0123456','2022-09-05','123','001')
delete from CarParking
exec sp_StartParking '1001', '2018-10-07 08:30:00', '1'
select * from CarParking

/*--5--*/
exec sp_EndParking '1001', '2018-10-07 08:30:00', '2018-10-07 10:00:00'
select * from CarParking