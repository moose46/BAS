USE [babblefish]
GO
/****** Object:  StoredProcedure [dbo].[spNetSuiteItemsWithNullBasePrice]    Script Date: 4/21/2020 11:36:45 AM ******/
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
	Name
   ,[Internal ID] AS InternalID
   ,[External ID] AS ExternalID
   ,Items.[Base Price] AS base_price
FROM items
LEFT JOIN SO_SalesOrderDetail
	ON ItemCode = Items.Name
LEFT JOIN SO_SalesOrderHeader
	ON SO_SalesOrderDetail.SalesOrderNo = SO_SalesOrderDetail.SalesOrderNo
WHERE [Base Price] IS NULL
AND SO_SalesOrderHeader.OrderType = 'R'
AND SO_SalesOrderHeader.DateCreated >= DATEADD(YEAR, -1, GETDATE())
GROUP BY Name
		,[Internal ID]
		,[External ID]
		,[Base Price]
ORDER BY Name
END
