/****** Script for SelectTopNRows command from SSMS  ******/
USE babblefish
GO

SELECT
	[CustomerName]
   ,[udf_bwid]
   ,creditlimit
   ,[ardivisionno]
   ,[emailaddress]
   ,[udf_bwid] AS customerid
   ,faxno
   ,telephoneno
   ,taxschedule
   ,termscode
   ,[URLAddress]
   ,[AddressLine1]
   ,[AddressLine2]
   ,[AddressLine3]
   ,[City]
   ,[State]
   ,[ZipCode] AS zip
   ,[CountryCode]
   ,[State]
   ,n.id
FROM AR_Customer ac
INNER JOIN Account_ext sae
	ON sae.BWCUSTOMERID = ac.UDF_BWID
INNER JOIN Account sa
	ON sae.ACCOUNTID = sa.ACCOUNTID
		AND sa.Status = 'Active'
INNER JOIN NSCustomers n
	ON sae.BWCUSTOMERID = n.[External ID]

		--where [UDF_BWID] in 
		--	(SELECT[BWCUSTOMERID],SLX_Account.ACCOUNTID
		--		FROM [master].[dbo].[SLX_Account_ext],slx_account where
		--			[slx_account].[accountid] = slx_account_ext.accountid
		--		group by [BWCUSTOMERID],SLX_Account.ACCOUNTID
		--			having count(*) > 1
		--			)
		--			order by 2