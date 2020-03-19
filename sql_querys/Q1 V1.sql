-- need to create look up table for MAS with no matching SLX Accounts
USE babblefish
GO

DROP TABLE dbo.Q1DATA

-- modified 2/12/2020 per Kathy's email
-- modified 2/13/2020 per Kathys email
--I did notice a couple more filters you could put in . . .
--so the source data for new customers should be MAS
--and why don’t we filter OUT anything created BEFORE 11/26/19
--and also anything that has text in the account number field and has a null UDF_BWID.
SELECT
	--ac.DateCreated
	ac.CustomerName
   ,ac.CreditLimit
   ,ac.EmailAddress
   ,ac.UDF_BWID
   ,'CUSTOMER-Customer' AS Status
   ,ac.FaxNo
   ,'False' AS INDIVIDUAL
   ,ac.TelephoneNo
   ,'Breathing Air Solutions' AS PRIMARY_SUBSIDARY
   ,ac.TaxSchedule
   ,ac.TermsCode
   ,ac.URLAddress
   ,ac.AddressLine1
   ,ac.AddressLine2
   ,ac.AddressLine3
   ,ac.City
   ,ac.CountryCode
   ,ac.ZipCode  INTO Q1DATA
   --,ac.DateCreated
FROM AR_CUSTOMER ac
WHERE ac.UDF_BWID IS NULL -- AND ac.CustomerName = n.[Company Name]
--LEFT JOIN NSCUSTOMERS n
--	ON ac.UDF_BWID = n.ID -- NS Customer id = ar_customer.udf_bwid
--WHERE n.ID IS NULL -- filter out if already in nsuite
--AND ISNUMERIC(ac.UDF_BWID) > 0
AND ac.DateCreated > '11/19/2019'
--ORDER BY ac.DateCreated

--SELECT
--	COUNT(*)
--FROM AR_Customer ac
--LEFT JOIN SLX_Account_ext sae
--	ON ac.UDF_BWID = sae.BWCUSTOMERID
--WHERE sae.BWCUSTOMERID IS NULL

--SELECT ac.CustomerNo
--FROM AR_Customer ac
--LEFT JOIN NSCustomers n ON ac.CustomerNo = CONCAT('0',n.ID)
--WHERE n.ID IS null