/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ACCOUNTID]
      ,[BWCUSTOMERID]
  FROM [master].[dbo].[SLX_Account_ext] sae
  WHERE sae.BWCUSTOMERID = '800582'