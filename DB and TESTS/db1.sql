USE [DB2019_Ass2]
GO


/*-1-*/
select e.FirstName, e.LastName, ce.SalaryPerDay, p.Name, p.Description
from ConstructorEmployee ce
inner join Employee e
	on ce.EID=e.EID
inner join ProjectConstructorEmployee pce
	on ce.EID=pce.EID
inner join Project p
	on pce.PID=p.PID
where pce.EndWorkingDate='1900-01-01' OR pce.EndWorkingDate>GETDATE();


/*-2-*/
select e.*, infoTable.Name
from Employee e
left outer join 
	(
		select oe.EID, d.Name
		from OfficialEmployee oe
		left outer join Department d
				on oe.DepartmentId=d.DID
		union
			select ce.EID, p.Name
			from ConstructorEmployee ce
			left outer join ProjectConstructorEmployee pce on ce.EID=pce.EID
			left outer join Project p on pce.PID=p.PID
			where pce.StartWorkingDate>=ALL(
				select StartWorkingDate
				from ProjectConstructorEmployee pce
				where ce.EID=pce.EID)		
	) as infoTable on e.EID=infoTable.EID;


/*-3-*/
select n.Name, count(n.NID) as Counter
from Neighborhood n
left outer join Apartment a
	on n.NID=a.NeighborhoodID
group by n.NID, n.Name
order by count(n.NID)asc;


/*-4-*/
select a.Door, a.Number, a.StreetName, r.FirstName, r.LastName
from Apartment a
left outer join Resident r
	on a.StreetName=r.StreetName and a.Number=r.Number and a.Door=r.door;


/*-5-*/
select pa.*
from ParkingArea pa
where pa.maxpriceperday=(select max(pa.maxpriceperday) from ParkingArea pa);


/*-6-*/
select c.CID, c.ID
from Cars c
inner join CarParking cp
	on c.CID=cp.CID
inner join ParkingArea pa
	on cp.ParkingAreaID=pa.AID
where pa.maxpriceperday=(select max(pa.maxpriceperday) from ParkingArea pa)
	and cp.Cost=(select max(cp.Cost) from CarParking cp);



select c.CID as 'רכב', r.RID as 'תז תושב', n.NID as 'שכונה של תושב', pa.NeighborhoodID as 'חניה בשכונה'
from Cars c
inner join Resident r on c.ID=r.RID
inner join Apartment a on (a.StreetName=r.StreetName and a.Number=r.Number and a.Door=r.door)
inner join Neighborhood n on a.NeighborhoodID=n.NID
inner join CarParking cp on cp.CID=c.CID
inner join ParkingArea pa on cp.ParkingAreaID=pa.AID

/*-7-*/
select r.RID, r.FirstName, r.LastName
from Resident r
inner join Apartment a on (a.StreetName=r.StreetName and a.Number=r.Number and a.Door=r.door)
inner join Neighborhood n on a.NeighborhoodID=n.NID
inner join (
	select r.rid,pa.NeighborhoodID
	from Resident r
	inner join Cars c on r.RID=c.ID
	inner join CarParking cp on cp.CID=c.CID
	inner join ParkingArea pa on cp.ParkingAreaID=pa.AID
	group by r.RID, pa.NeighborhoodID
	having count(distinct cp.ParkingAreaID)=1
	) uniqeCarParking on r.RID=uniqeCarParking.RID
where uniqeCarParking.NeighborhoodID=n.NID;


/*-8-*/
select distinct r.RID, r.FirstName, r.LastName
from Resident r
inner join cars c on r.RID=c.ID
inner join CarParking cp on cp.CID=c.CID
inner join (
			select distinct c.CID
			from CarParking cp
			inner join Cars c on cp.CID=c.CID
			group by c.CID
			having count(distinct cp.ParkingAreaID)= (select count(pa.AID) from ParkingArea pa)
			) tempTable on tempTable.CID=c.CID


/*-9-*/
select e.FirstName, e.LastName, ce.SalaryPerDay
from Employee e
right outer join ConstructorEmployee ce on e.EID=ce.EID
where DATEDIFF(year,e.BirthDate,getdate()) > (
	select distinct max(DATEDIFF(DAY,e.BirthDate,getdate())/365.0)
	from Employee e 
	right outer join OfficialEmployee oe on oe.EID=e.EID);


