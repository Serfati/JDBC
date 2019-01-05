
--1
SELECT FirstName, LastName, Name, Description, SalaryPerDay
FROM Employee e
INNER JOIN ConstructorEmployee c on e.EID = c.EID
INNER JOIN ProjectConstructorEmployee pce on c.EID = pce.EID
INNER JOIN Project p on pce.PID = p.PID
;

--2
SELECT e.*, info.Name as Project_Department
FROM Employee e
left outer JOIN
        (SELECT oe.EID, d.Name
        FROM OfficialEmployee oe
        left outer JOIN Department d on oe.DepartmentId=d.DID
        union
            SELECT c.EID, p.Name
            FROM ConstructorEmployee c
            left outer JOIN ProjectConstructorEmployee pce on c.EID=pce.EID
            left outer JOIN Project p on pce.PID=p.PID
            WHERE pce.StartWorkingDate>=ALL(
                SELECT StartWorkingDate
                FROM ProjectConstructorEmployee pce
                WHERE c.EID=pce.EID)
    ) as info on e.EID=info.EID
;

--3
SELECT N.name as NeighborhoodName ,count (NeighborhoodID) as ApartmentsNumber
FROM Apartment A
left JOIN  Neighborhood N on A.NeighborhoodID = N.NID
GROUP BY N.name
ORDER BY ApartmentsNumber ASC
;

--4
SELECT FirstName, LastName, A.*
FROM Apartment A
LEFT JOIN Resident R on A.StreetName = R.StreetName and A.Number = R.Number and A.Door = R.door
;

--5
SELECT *
FROM ParkingArea PA
WHERE maxpriceperday=(
  SELECT MAX(maxpriceperday)
  FROM ParkingArea);

--6
SELECT cp.CID, c.ID
FROM CarParking cp
    JOIN Cars c on cp.CID = c.CID
    JOIN ParkingArea pa on cp.ParkingAreaID = pa.AID
WHERE maxpriceperday = (select MAX(maxpriceperday) from ParkingArea) and Cost = (select max(cost) from CarParking)
;

--7
SELECT r.RID,r.FirstName,r.LastName
FROM Cars c
    JOIN Resident r on c.ID = r.RID
    JOIN Apartment a on (a.Door = r.door and a.Number = r.Number and a.StreetName = r.StreetName)
    JOIN
       (SELECT c.CID, count(distinct pa.NeighborhoodID) as NPerC
        FROM Cars c
        JOIN CarParking cp on c.CID = cp.CID
        JOIN ParkingArea pa on pa.AID = cp.ParkingAreaID
        JOIN Neighborhood n on pa.NeighborhoodID = n.NID
        GROUP BY c.CID
        HAVING count(distinct pa.NeighborhoodID) = 1) cn  on c.CID = cn.CID
            JOIN ( SELECT CID,ParkingAreaID FROM CarParking) cp2
                    on c.CID = cp2.CID
            JOIN ( SELECT AID, NeighborhoodID FROM ParkingArea) pa2
                    on cp2.ParkingAreaID = pa2.AID and pa2.NeighborhoodID = a.NeighborhoodID
;

--8
SELECT distinct r.RID, r.FirstName, r.LastName
FROM Resident r
INNER JOIN cars c on r.RID=c.ID
INNER JOIN CarParking cp on cp.CID=c.CID
INNER JOIN ( SELECT distinct c.CID
                FROM CarParking cp
            INNER JOIN Cars c on cp.CID=c.CID
            GROUP BY c.CID
            HAVING count(distinct cp.ParkingAreaID)= (SELECT count(pa.AID) FROM ParkingArea pa))
            tempTable on tempTable.CID=c.CID
;

--9
SELECT e.FirstName, e.LastName, c.SalaryPerDay
FROM  Employee e
    JOIN ConstructorEmployee c on e.EID=c.EID
WHERE e.BirthDate <= all  (  SELECT BirthDate
                            FROM Employee e
                            JOIN OfficialEmployee o on e.EID=o.EID)
;
