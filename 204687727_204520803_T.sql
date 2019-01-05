----------/1/----------
CREATE TRIGGER DeleteProject
ON project
INSTEAD OF DELETE
AS
BEGIN
    declare @PID int=(select PID from deleted)
    create table #tmp1 (EID1 int)
    create table #tmp2 (EID2 int)
    create table #tmp3 (EID3 int)
    insert into #tmp1
        SELECT EID
        FROM ProjectConstructorEmployee
        where (EndWorkingDate>GETDATE() OR EndWorkingDate is null)
        group by EID
        having count(pid)=1
    insert into #tmp2
        SELECT EID
        FROM ProjectConstructorEmployee
        where (EndWorkingDate>GETDATE() OR EndWorkingDate is null) and PID=@PID
    insert into #tmp3
        select EID1
        from #tmp1
        inner join #tmp2 on #tmp1.EID1=#tmp2.EID2
    delete from ProjectConstructorEmployee
        where PID=@PID
    delete from ConstructorEmployee
        where EID in (select EID3 from #tmp3)
    delete from Employee
        where EID in (select EID3 from #tmp3)
    delete from Project
        where PID=@PID
    delete from CellPhones
        where EID in (select EID3 from #tmp3)
END
GO

----------/2/----------
CREATE TRIGGER Park ON carparking
AFTER INSERT AS
BEGIN
    declare @cost numeric=(select cost from inserted)
    declare @endTime datetime=(select EndTime from inserted)
    if(@cost is null AND @endTime is NOT NULL)
        BEGIN
        declare @cid int=(select cid from inserted)
        declare @startTime datetime=(select StartTime from inserted)
        declare @priceperhour int= (select priceperhour from inserted
                                    inner join ParkingArea pa
                                        on pa.AID=inserted.ParkingAreaID)
        declare @maxpriceperday int=(select maxpriceperday from ParkingArea pa
                                    inner join inserted
                                    on pa.AID=inserted.ParkingAreaID)
            SET @cost= (datediff(HOUR, @startTime, @endTime))*@priceperhour
            UPDATE CarParking
            SET Cost= (SELECT MIN(x) FROM (VALUES (@cost),(@maxpriceperday)) AS value(x))
            WHERE CarParking.CID=@cid and StartTime=@startTime
        END
END
GO

----------/3/----------
CREATE TRIGGER ParkingDiscount
on CarParking
AFTER INSERT
AS
BEGIN
    declare @cost numeric=(select cost from inserted)
    declare @cid int =(select cid from inserted)
    declare @endTime datetime=(select EndTime from inserted)
    if (@endTime is NOT NULL AND @cid in(select cp.CID from CarParking cp
                                        inner join Cars c on cp.CID=c.CID
                                        inner join OfficialEmployee oe on c.ID=oe.EID
                                        )
        )
        BEGIN
        declare @startTime datetime=(select StartTime from inserted)
        declare @priceperhour int= (select priceperhour from inserted
                                    inner join ParkingArea pa
                                        on pa.AID=inserted.ParkingAreaID)
        declare @maxpriceperday int=(select maxpriceperday from ParkingArea pa
                                    inner join inserted
                                    on pa.AID=inserted.ParkingAreaID)
        SET @cost= (datediff(HOUR, @startTime, @endTime))*@priceperhour
            UPDATE CarParking
            SET Cost= 0.8*(SELECT MIN(x) FROM (VALUES (@cost),(@maxpriceperday)) AS value(x))
            WHERE CarParking.CID=@cid and StartTime=@startTime
        END
END
GO