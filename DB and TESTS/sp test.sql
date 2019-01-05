USE DB2019_Ass2
GO

/*--1--*/
DELETE FROM Employee
exec sp_AddMunicipalEmployee '1','bar','ron','2001-02-20','rager', '1','2','beer sheva'
select * from employee

/*--2--*/
delete from OfficialEmployee
delete from employee
delete from department
insert into Department
(DID ,Name ,Description)
VALUES
('1','IS','A Great Department')
exec sp_AddMunicipalEmployeeOfficial '1','bar','ron','2001-02-20','rager', '1','2','beer sheva','055-1234567', '2008-01-10', 'high', '1'
select * from employee
select * from OfficialEmployee

/*--3--*/
delete from ConstructorEmployee
delete from employee
delete from department
insert into Department
(DID ,Name ,Description)
VALUES
('1','IS','A Great Department')
exec sp_AddMunicipalEmployeeConstructor '1','bar','ron','2001-02-20','rager', '1','2','beer sheva','055-1234567','keshet', '600'
select * from employee
select * from ConstructorEmployee

/*--4--*/
delete from Apartment
delete from Neighborhood
delete from ParkingArea
delete from Cars
delete from CarParking
insert into Neighborhood
(Name,NID)
values
('POLEG','1')
insert into ParkingArea 
(AID, Name, priceperhour, maxpriceperday, NeighborhoodID)
values
('1','PARK','25','150','1')
insert into cars
(CID,CellPhoneNumber ,CreditCard ,ExpirationDate ,ThreeDigits,ID)
values
('1001','1800400400','0123456','2022-09-05','123','001')
exec sp_StartParking '1001', '2018-10-07 08:30:00', '1'
select * from CarParking

/*--5--*/
exec sp_EndParking '1001', '2018-10-07 08:30:00', '2018-10-07 10:00:00'
select * from CarParking