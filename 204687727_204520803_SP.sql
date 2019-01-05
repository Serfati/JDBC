/*1*/
CREATE PROCEDURE dbo.sp_AddMunicipalEmployee
    @EID [int] ,
    @LastName [varchar](255) ,
    @FirstName [varchar](255) ,
    @BirthDate [date] ,
    @StreetName [varchar](255) ,
    @Number [int] ,
    @door [int] ,
    @City [varchar](255)

AS
SET NOCOUNT ON
INSERT INTO [dbo].[Employee](
                              [EID],
                              [LastName],
                              [FirstName],
                              [BirthDate],
                              [StreetName],
                              [Number],
                              [door],
                              [City])
VALUES (@EID
        ,@LastName
        ,@FirstName
        ,@BirthDate
        ,@StreetName
        ,@Number
        ,@door
        ,@City)
GO

/*2*/
CREATE PROCEDURE dbo.sp_AddMunicipalEmployeeOfficial
    @EID [int] ,
    @LastName [varchar](255) ,
    @FirstName [varchar](255) ,
    @BirthDate [date] ,
    @StreetName [varchar](255) ,
    @Number [int] ,
    @door [int] ,
    @City [varchar](255),
    @StartDate [date] ,
    @Degree [varchar](255) ,
    @DepartmentId [int]
AS
SET NOCOUNT ON
INSERT INTO [dbo].[OfficialEmployee](
[EID],
[StartDate],
[Degree] ,
[DepartmentId]
              )
VALUES (@EID,
    @StartDate,
    @Degree,
    @DepartmentId)

exec sp_AddMunicipalEmployee @EID, @LastName
    ,@FirstName
    ,@BirthDate
    ,@StreetName
    ,@Number
    ,@door
    ,@City;
GO

/*3*/
CREATE PROCEDURE dbo.sp_AddMunicipalEmployeeConstructor
    @EID [int] ,
    @LastName [varchar](255) ,
    @FirstName [varchar](255) ,
    @BirthDate [date] ,
    @StreetName [varchar](255) ,
    @Number [int] ,
    @door [int] ,
    @City [varchar](255),
      @CompanyName [varchar](255) ,
      @SalaryPerDay [int]
AS
SET NOCOUNT ON
INSERT INTO [dbo].[ConstructorEmployee](
[EID],
[CompanyName],
[SalaryPerDay]
              )
VALUES (@EID,
      @CompanyName,
      @SalaryPerDay)

exec sp_AddMunicipalEmployee @EID, @LastName
    ,@FirstName
    ,@BirthDate
    ,@StreetName
    ,@Number
    ,@door
    ,@City;
  GO

/*4*/
CREATE PROCEDURE dbo.sp_StartParking
    @CID [int] ,
    @StartTime [datetime] ,
    @ParkingAreaID [int]
AS
SET NOCOUNT ON
INSERT INTO [dbo].[CarParking](
    [CID] ,
    [StartTime] ,
    [ParkingAreaID]
              )
VALUES (
  @CID ,
    @StartTime  ,
    @ParkingAreaID
       )
GO

/*5*/
CREATE PROCEDURE dbo.sp_EndParking
    @cID [int] ,
    @startTime [datetime] ,
    @endTime [datetime]
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE [dbo].[CarParking]
    SET
        [EndTime] = @endTime
    WHERE CID = @cID AND StartTime = @startTime
END
