USE [babblefish]
GO
/****** Object:  StoredProcedure [dbo].[spNetSuiteItemsWithNullBasePrice]    Script Date: 4/21/2020 6:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[spNetSuiteItemsWithNullBasePrice]
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

SELECT
	SO_SalesOrderDetail.SalesOrderNo
   ,Name
   ,soh.OrderType
   ,[Internal ID] AS InternalID
   ,[External ID] AS ExternalID
   ,Items.[Base Price] AS base_price
FROM items
LEFT JOIN SO_SalesOrderDetail
	ON ItemCode = Items.Name
left JOIN SO_SalesOrderHeader soh
	ON soh.SalesOrderNo = SO_SalesOrderDetail.SalesOrderNo
WHERE [Base Price] IS NULL
AND soh.OrderType = 'R'
AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE())
GROUP BY SO_SalesOrderDetail.SalesOrderNo
		,Name
		,soh.OrderType
		,[Internal ID]
		,[External ID]
		,[Base Price]
ORDER BY Name
END