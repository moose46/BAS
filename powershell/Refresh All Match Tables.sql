DROP TABLE MatchOneQ2
DELETE FROM MatchManyQ3
DROP TABLE Q1DATA

--- Q2
	SELECT
		sae.BWCUSTOMERID
	   ,sa.ACCOUNT INTO [dbo].[MatchOneQ2]
	FROM SLX_Account_ext sae
		,Slx_account sa
	WHERE sa.STATUS = 'Active'
	AND sa.[﻿ACCOUNTID] = sae.ACCOUNTID
	GROUP BY BWCUSTOMERID
			,sa.ACCOUNT
	HAVING COUNT(*) = 1

--Q3
INSERT INTO [dbo].[MatchManyQ3] (BWCUSTOMERID)
	SELECT
		sae.BWCUSTOMERID
	FROM SLX_Account_ext sae
		,Slx_account sa
	WHERE sa.STATUS = 'Active'
	AND sa.[﻿ACCOUNTID] = sae.ACCOUNTID
	GROUP BY BWCUSTOMERID
--HAVING COUNT(*) = 2

SELECT
	ac.CustomerName
   ,ac.CreditLimit
   ,ac.ARDivisionNo
   ,ac.EmailAddress
   ,ac.UDF_BWID
   ,'CUSTOMER-Customer' AS Status
   ,ac.FaxNo
   ,'False' AS INDIVIDUAL
   ,ac.TelephoneNo
   ,'Breathing Sir Solutions' AS PRIMARY_SUBSIDARY
   ,ac.TaxSchedule
   ,ac.TermsCode
   ,ac.URLAddress
   ,ac.AddressLine1
   ,ac.AddressLine2
   ,ac.AddressLine3
   ,ac.City
   ,ac.CountryCode
   ,ac.ZipCode INTO [dbo].[Q1DATA]
FROM AR_Customer ac
WHERE ac.UDF_BWID = ''



