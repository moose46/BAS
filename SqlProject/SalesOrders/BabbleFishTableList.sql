/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      [TABLE_NAME]
  FROM [babblefish].[INFORMATION_SCHEMA].[TABLES]
  order by TABLE_NAME
