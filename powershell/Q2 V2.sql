--Some accounts in MAS have one “matching” account in SalesLogix. 
--The actual names may not match so they are matched on the field
--in MAS AR_Customer.UDF_BWID  to the account number in SLX ACCOUNT.ACCOUNT_EXT.BWCUSTOMERID.
--I used an Access query to first identify which SLX accounts only had one account (see below).
--Then I used the results of that query to match anything that had a matching AR_Customer.UDF_BWID.  
-- Kathy sent me back an excel spread sheet with some incorrect data 2/14/2020

USE babblefish
GO

DROP TABLE Q2DATA


SELECT
	ac.CustomerName
   ,sa.Account AS InformAccountName
   ,ac.CreditLimit
   ,ac.ARDivisionNo
   ,n.Email AS EmailAddress
   ,ac.UDF_BWID AS CustomerId
   ,'CUSTOMER-Customer' AS Status
   ,n.[External ID] AS externalId
   ,ac.FaxNo
   ,'False' AS INDIVIDUAL
   ,n.Phone AS TelephoneNo
   ,'Breathing Air Solutions' AS PRIMARY_SUBSIDARY
   ,ac.TaxSchedule
   ,ac.TermsCode
   ,n.[Web Address] AS URLAddress
   ,ac.AddressLine1
   ,ac.AddressLine2
   ,ac.AddressLine3
   ,ac.City
   ,ac.CountryCode
   ,'' AS Address_defaultBilling
   ,'' AS Address_defaultShipping
   ,ac.State
   ,ac.ZipCode AS Zip INTO Q2DATA -- matches the ID field in the customer list netsuite for debugging
FROM AR_CUSTOMER ac
	,ACCOUNT_EXT sae
	,ACCOUNT sa
	,NSCUSTOMERS n
WHERE ac.UDF_BWID IN (SELECT
		CAST(sae.BWCUSTOMERID AS VARCHAR)
	FROM ACCOUNT_EXT sae
	WHERE ISNUMERIC(sae.BWCUSTOMERID) > 0
	GROUP BY sae.BWCUSTOMERID
	HAVING COUNT(*) = 1)
AND  CAST(sae.BWCUSTOMERID AS VARCHAR) = ac.UDF_BWID -- float - varchar
AND sae.ACCOUNTID = sa.[﻿ACCOUNTID]
AND n.ID = ac.UDF_BWID
ORDER BY CustomerId

