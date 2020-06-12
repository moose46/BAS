/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Warehouse]
      ,[Description]
      ,[Status]
      ,[Warehouse Name],CorrectedName

  FROM [babblefish].[dbo].[MAS_WAREHOUSE]