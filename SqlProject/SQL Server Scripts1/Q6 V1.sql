-- Address change in MAS or NS
SELECT
	ac.CustomerNo
   ,n.[Internal ID]
   ,n.ID
   ,n.[Company Name]
   ,ac.CustomerName
   ,n.[Billing Address 1] AS 'NS Billing Address1'
   ,ac.AddressLine1 AS 'MAS Address1'
	--,ac.AddressLine2
	--,ac.City
	--,ac.State
   ,n.[Date Created] AS 'NS Date Created'
   ,n.[Last Modified] AS 'NS Date Modiifed'
   ,ac.DateCreated 'MAS Date Created'
   ,ac.DateUpdated AS 'MAS Date Modified'
   ,ac.TermsCode
   ,n.Terms
FROM AR_CUSTOMER ac
	,NSCUSTOMERS n
WHERE ac.UDF_BWID = n.ID
AND n.[Billing Address 1] <> ac.AddressLine1
ORDER BY n.ID
