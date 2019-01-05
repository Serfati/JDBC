/*1*/
CREATE VIEW ConstructionEmployeeOverFifty
AS
SELECT c.* from ConstructorEmployee c
inner join Employee e on c.EID = e.EID
WHERE BirthDate < '1968-12-23'
;

/*2*/
CREATE VIEW ApartmentNumberInNeighborhood
as
SELECT N.name as NeighborhoodName ,count (NeighborhoodID) as ApartmentsNumber
FROM Apartment A
left JOIN  Neighborhood N on A.NeighborhoodID = N.NID
GROUP BY N.name


/*3*/
CREATE VIEW MaxParking
AS
SELECT c.CID as mostParkCar , c.ParkingAreaID
FROM CarParking c
INNER JOIN
(
    SELECT c.ParkingAreaID, MAX(CID) AS max_parking_car
    FROM CarParking c
    GROUP BY c.ParkingAreaID

)
c2  on c.ParkingAreaID = c2.ParkingAreaID AND c.CID = c2.max_parking_car ;