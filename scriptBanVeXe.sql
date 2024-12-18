USE [DB_DoAnBanVeXe]
GO
/****** Object:  UserDefinedFunction [dbo].[TRACUUVE]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--TRA CỨU VÉ
CREATE FUNCTION [dbo].[TRACUUVE](@SDT NVARCHAR(20), @DPT NVARCHAR(100))
RETURNS @BANGTRACUU TABLE(DetailsTicketID INT, FullName NVARCHAR(50), PhoneNumber NVARCHAR(50) , DepartureLocation NVARCHAR(50), ArrivalLocation NVARCHAR(50), DepartureTime DATETIME, SeatNumber Char(10),  Price decimal(18, 2) )
AS
BEGIN
DECLARE @ParsedDate DATETIME = CONVERT(DATETIME, @DPT, 120);
	INSERT INTO @BANGTRACUU
		SELECT DT.DetailsTicketID, P.FullName, P.PhoneNumber, T.DepartureLocation,T.ArrivalLocation, T.DepartureTime, S.SeatNumber,  DT.Price
		FROM Passenger P
			inner JOIN OrderTicket OT
			ON P.PassengerID=OT.PassengerID
				INNER JOIN DetailsTicket DT 
				ON OT.OrderTicketID=DT.OrderTicketID
					INNER JOIN TRIP T
					ON T.TripID=DT.TripID
						INNER JOIN SEAT S
						ON S.SeatID=DT.SeatID
		WHERE P.PhoneNumber = @SDT 
	RETURN
END
GO
/****** Object:  Table [dbo].[Bus]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus](
	[BusID] [int] IDENTITY(1,1) NOT NULL,
	[BusNumber] [varchar](50) NULL,
	[TotalSeat] [int] NULL,
	[BusType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetailsTicket]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailsTicket](
	[DetailsTicketID] [int] IDENTITY(1,1) NOT NULL,
	[OrderTicketID] [int] NULL,
	[TripID] [int] NULL,
	[SeatID] [int] NULL,
	[IsBooked] [bit] NULL,
	[Price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailsTicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Driver]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Driver](
	[DriverID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[LicenseNumber] [varchar](50) NULL,
	[PhoneNumber] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DriverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderTicket]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTicket](
	[OrderTicketID] [int] IDENTITY(1,1) NOT NULL,
	[PassengerID] [int] NULL,
	[Total] [decimal](18, 2) NULL,
	[OrderDate] [datetime] NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderTicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passenger]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passenger](
	[PassengerID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Email] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PassengerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderTicketID] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentStatus] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolesID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RolesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Route]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route](
	[RouteID] [int] IDENTITY(1,1) NOT NULL,
	[RouteName] [nvarchar](255) NULL,
	[StartLocation] [nvarchar](255) NULL,
	[EndLocation] [nvarchar](255) NULL,
	[Distance] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[SeatID] [int] IDENTITY(1,1) NOT NULL,
	[BusID] [int] NULL,
	[SeatNumber] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trip]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trip](
	[TripID] [int] IDENTITY(1,1) NOT NULL,
	[RouteID] [int] NULL,
	[BusID] [int] NULL,
	[DriverID] [int] NULL,
	[DepartureLocation] [nvarchar](255) NULL,
	[ArrivalLocation] [nvarchar](255) NULL,
	[DepartureTime] [datetime] NULL,
	[ArrivalTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccount](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[CCCD] [nchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRolesID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[RoleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRolesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetailsTicket]  WITH CHECK ADD FOREIGN KEY([OrderTicketID])
REFERENCES [dbo].[OrderTicket] ([OrderTicketID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DetailsTicket]  WITH CHECK ADD FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seat] ([SeatID])
GO
ALTER TABLE [dbo].[DetailsTicket]  WITH CHECK ADD FOREIGN KEY([TripID])
REFERENCES [dbo].[Trip] ([TripID])
GO
ALTER TABLE [dbo].[OrderTicket]  WITH CHECK ADD FOREIGN KEY([PassengerID])
REFERENCES [dbo].[Passenger] ([PassengerID])
GO
ALTER TABLE [dbo].[OrderTicket]  WITH CHECK ADD  CONSTRAINT [FK_OD_USERID] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccount] ([UserID])
GO
ALTER TABLE [dbo].[OrderTicket] CHECK CONSTRAINT [FK_OD_USERID]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([OrderTicketID])
REFERENCES [dbo].[OrderTicket] ([OrderTicketID])
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD FOREIGN KEY([BusID])
REFERENCES [dbo].[Bus] ([BusID])
GO
ALTER TABLE [dbo].[Trip]  WITH CHECK ADD FOREIGN KEY([BusID])
REFERENCES [dbo].[Bus] ([BusID])
GO
ALTER TABLE [dbo].[Trip]  WITH CHECK ADD FOREIGN KEY([DriverID])
REFERENCES [dbo].[Driver] ([DriverID])
GO
ALTER TABLE [dbo].[Trip]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([RouteID])
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RolesID])
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccount] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[DOIMATKHAU]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DOIMATKHAU] @NEWPASS NVARCHAR(100), @USERID INT
AS
  UPDATE UserAccount
  SET Password = @NEWPASS
  WHERE UserID = @USERID
GO
/****** Object:  StoredProcedure [dbo].[GetLatestOrderID]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--as its name
CREATE PROC [dbo].[GetLatestOrderID] @ORDERDATE nvarchar(100), @PassengerID int
AS
BEGIN
	select TOP 1 OrderTicketID from OrderTicket 
	where DATEDIFF(DAY,OrderDate,@ORDERDATE)=0 and PassengerID = @PassengerID
	order by OrderTicketID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GETREADYBUS]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GETREADYBUS]
    @DeppTime DATETIME, 
    @ArrTime DATETIME
AS
BEGIN
    SELECT 
        B.BusID AS [Mã xe], 
        B.BusNumber AS [Biển số xe], 
        B.TotalSeat AS [Tổng số ghế], 
        B.BusType AS [Loại xe]
    FROM Bus B
    WHERE 
        -- Xe chưa từng có chuyến
        B.BusID NOT IN (SELECT DISTINCT BUSID FROM TRIP)

        -- Hoặc xe không nằm trong khoảng thời gian chỉ định
        OR B.BusID NOT IN (
            SELECT BUSID 
            FROM TRIP 
            WHERE NOT (
                DepartureTime >= @ArrTime OR ArrivalTime <= @DeppTime
            )
        )
END
GO
/****** Object:  StoredProcedure [dbo].[GETREADYDRIVER]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GETREADYDRIVER] @TODAY NVARCHAR(100)
AS
BEGIN
	SELECT DRIVERID
	FROM DRIVER
	WHERE DRIVERID NOT IN (SELECT DRIVERID FROM TRIP GROUP BY DRIVERID) 
	OR DRIVERID IN (SELECT DRIVERID FROM TRIP WHERE DATEDIFF(HOUR,ArrivalTime, @TODAY)>0)
END
GO
/****** Object:  StoredProcedure [dbo].[GetRevenueReport]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRevenueReport]
    @StartDate DATETIME,
    @EndDate DATETIME,
    @TripID INT
AS
BEGIN
    SELECT 
        OT.OrderTicketID,
        OT.PassengerID,
        OT.OrderDate,
        DT.SeatID,
        DT.Price,
        DT.IsBooked
    FROM 
        [DB_DoAnBanVeXe].[dbo].[DetailsTicket] DT
    INNER JOIN 
        [DB_DoAnBanVeXe].[dbo].[OrderTicket] OT
    ON 
        DT.OrderTicketID = OT.OrderTicketID
	INNER JOIN 
		Trip T
	ON
		DT.TripID = T.TripID
	INNER JOIN
		Route R
	ON
		T.RouteID = R.RouteID
    WHERE 
        OT.OrderDate BETWEEN @StartDate AND @EndDate
        AND R.RouteID = @TripID
        AND DT.IsBooked = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetRoleName]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Lấy Cấp bậc
CREATE PROC [dbo].[GetRoleName] @USERID INT
AS
BEGIN
	SELECT RoleName from Roles R INNER JOIN UserRoles UR ON R.RolesID = UR.RoleID 
	INNER JOIN UserAccount UA ON UR.UserID = UA.UserID 
	WHERE UA.UserID = @USERID
END
GO
/****** Object:  StoredProcedure [dbo].[GetSeatID]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSeatID] @SeatNumber nvarchar(100), @BusID int
AS
BEGIN
SELECT * FROM SEAT WHERE SeatNumber = @SeatNumber AND BusID = @BusID
END
GO
/****** Object:  StoredProcedure [dbo].[GetTicketReport]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetTicketReport] @OTID INT
AS
	SELECT DISTINCT *
	FROM DetailsTicket DT
	INNER JOIN TRIP T
	ON DT.TripID = T.TripID
	INNER JOIN ROUTE R
	ON T.RouteID = R.RouteID
	INNER JOIN Seat S
	ON DT.SeatID = S.SeatID
	WHERE OrderTicketID = @OTID
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUserID]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetUserByUserID] @userid int
as
BEGIN
	SELECT * from UserAccount
	WHERE UserID = @userid
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetUserByUsername] @username nvarchar(100)
as
BEGIN
	SELECT * from UserAccount
	WHERE Email = @username
END
GO
/****** Object:  StoredProcedure [dbo].[InsertDetailsTicket]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertDetailsTicket] @OrderTicketID INT, @TripID INT, @SeatID INT, @IsBooked int, @PRICE int
AS
BEGIN
	INSERT INTO DetailsTicket(OrderTicketID, TripID , SeatID, IsBooked, Price) 
    VALUES(@OrderTicketID,  @TripID, @SeatID, @IsBooked, @Price)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOrderTicket]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertOrderTicket] @pID int, @ORDERDATE nvarchar(100), @userID int
AS
	Insert into OrderTicket([PassengerID], [Total], [OrderDate], [UserID]) 
	VALUES (@pID, 0 ,@ORDERDATE, @UserID)
GO
/****** Object:  StoredProcedure [dbo].[InsertTrip]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[InsertTrip] 
@RouteID int, @BusID int, @DriverID int, @DeppLoc nvarchar(100), @ArrLoc nvarchar(100), @DeppTime nvarchar(100), @ArrTime nvarchar(100)
AS
BEGIN
		INSERT INTO Trip ([RouteID]
		  ,[BusID]
		  ,[DriverID]
		  ,[DepartureLocation]
		  ,[ArrivalLocation]
		  ,[DepartureTime]
		  ,[ArrivalTime]
		  )
		VALUES (@RouteID , @BusID , @DriverID , @DeppLoc, @ArrLoc , @DeppTime , @ArrTime)
END
GO
/****** Object:  StoredProcedure [dbo].[IsAdmin]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IsAdmin
CREATE PROC [dbo].[IsAdmin] @USERNAME NVARCHAR(100), @PASSWORD NVARCHAR(100)
AS
BEGIN
	SELECT Email, Password, UR.RoleID
	from UserAccount UA
	JOIN UserRoles UR
	ON UA.UserID=UR.UserID
	where Email=@USERNAME and Password = @PASSWORD AND  UR.RoleID = 1
END 
GO
/****** Object:  StoredProcedure [dbo].[IsLogin]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IsLogin] @USERNAME NVARCHAR(100), @PASSWORD NVARCHAR(100)
AS
BEGIN
	SELECT Email, Password
	from UserAccount
	where Email=@USERNAME and Password = @PASSWORD
END
GO
/****** Object:  StoredProcedure [dbo].[TIMCHUYENXE]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TIMCHUYENXE] 
    @DEPLOC NVARCHAR(100), 
    @ARRLOC NVARCHAR(100), 
    @SELECTEDDAY NVARCHAR(100)
AS
BEGIN
	DECLARE @ParsedDate DATETIME = CONVERT(DATETIME, @SELECTEDDAY, 120);
    SELECT 
        B.BusID, 
        B.BusNumber, 
        B.TotalSeat, 
        B.BusType, 
        T.DepartureTime, 
        T.ArrivalTime
    FROM 
        Bus B 
        INNER JOIN Trip T ON B.BusID = T.BusID
    WHERE 
        T.DepartureLocation = @DEPLOC 
        AND T.ArrivalLocation = @ARRLOC 
        AND T.DepartureTime >= @ParsedDate
        AND T.DepartureTime < DATEADD(DAY, 1, @ParsedDate );
END
GO
/****** Object:  StoredProcedure [dbo].[TIMDOANHTHU]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- TRUY VAN TIM DOANH THU 
CREATE PROC [dbo].[TIMDOANHTHU] 
	@STARTDAY DATE, @ENDDAY DATE, @DEPLOC NVARCHAR(30), @ARRLOC NVARCHAR(30),
	@TOTALINCOME DECIMAL(18, 2) OUT
AS
SET @TOTALINCOME = (Select sum(Total) 
 from OrderTicket OT
 JOIN DetailsTicket DT ON OT.OrderTicketID=DT.OrderTicketID
	JOIN Trip T ON DT.TripID=T.TripID
 where 
	OT.OrderDate BETWEEN @STARTDAY AND @ENDDAY
	AND
	T.DepartureLocation=@DEPLOC AND T.ArrivalLocation=@ARRLOC)
GO
/****** Object:  Trigger [dbo].[UPDATETOTAL]    Script Date: 16/12/2024 23:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE TRIGGER [dbo].[UPDATETOTAL] ON [dbo].[DetailsTicket]
 FOR INSERT
 AS
	UPDATE OrderTicket 
	SET Total += (SELECT PRICE FROM inserted)
	FROM inserted
	WHERE OrderTicket.OrderTicketID = inserted.OrderTicketID
GO
ALTER TABLE [dbo].[DetailsTicket] ENABLE TRIGGER [UPDATETOTAL]
GO
