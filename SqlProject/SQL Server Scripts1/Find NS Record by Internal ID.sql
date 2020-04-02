/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      [External ID]
	  -- https://1208945.app.netsuite.com/app/common/entity/custjob.nl?id=18883
      ,[Internal ID] -- is the internal id in NS
      ,[InforCRM AccountID]
      ,[ID]
      ,[Name]
      ,[Company Name]
      ,[Phone]
      ,[Email]
      ,[Fax]
      ,[Billing Address 1]
      ,[Billing Address 2]
      ,[Billing City]
      ,[Billing State/Province]
      ,[Billing Zip]
      ,[Billing Country]
      ,[Shipping Address]
      ,[Billing Address]
      ,[Account]
      ,[Terms]
      ,[Price Level]
      ,[Taxable]
      ,[Branch Origin]
      ,[InforCRM Account Name]
      ,[Web Address]
  FROM [master].[dbo].[NSCustomers] WHERE [ID] LIKE '110152%' -- use the ID field from NS Customer List