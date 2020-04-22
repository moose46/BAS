-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
use babblefish
GO

IF OBJECT_ID('GetAllRepeatingSalesOrders', 'P') IS NOT NULL  
   DROP PROCEDURE GetAllRepeatingSalesOrders;  
go
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GetAllRepeatingSalesOrders 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from SO_SalesOrderHeader soh 
	left join SO_SalesOrderDetail sod on soh.SalesOrderNo = sod.SalesOrderNo
	WHERE [soh].[OrderType] = 'R' and soh.DateCreated >= DATEADD(YEAR,-1,getdate()) 
END
GO
