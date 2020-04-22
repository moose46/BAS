/****** Script for SelectTopNRows command from SSMS  ******/
use babblefish
go

SELECT count( [SalesOrderNo])
      ,[ItemCode]
  FROM [babblefish].[dbo].[FEE_TMP]
  group by ItemCode