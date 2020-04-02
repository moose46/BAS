USE babblefish
GO
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000)
	--[Inactive]
	[Name]
	--      ,[Duplicate]
	--      ,[Category]
	--      ,[Primary Subsidiary]
	--      ,[Primary Contact]
	--      ,[Phone]
	--      ,[Email]
	--      ,[Login Access]
	--      ,[Vendor Bank Fees]
	--      ,[InforCRM AccountID]
	--      ,[Sage100 External ID]
	--      ,[NextService Employee Location]
   ,[External ID]
   ,[Internal ID]
--      ,[InforCRM AccountID1]
FROM [babblefish].[dbo].[NS_Vendors]
WHERE [External ID] LIKE '%BAUER%'