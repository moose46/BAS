/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct ItemCode
      ,[ItemCodeDesc]
      ,[UnitPrice]

  FROM [babblefish].[dbo].[SO_SalesOrderDetail] where ItemCode = '04-0310' or ItemCode = '717'