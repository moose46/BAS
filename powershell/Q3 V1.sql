USE babblefish
GO
--Q3
DROP TABLE MatchManyQ3

-- get the children
SELECT
	n.ID
   ,SUBSTRING(n.[ID], 1, CHARINDEX('-', n.ID) - 1) AS pid
   ,n.[Internal ID] AS internalId
   ,n.[External ID] AS externalId INTO MatchManyQ3
FROM NSCUSTOMERS n
WHERE n.ID LIKE ('%-%')

--get parents
INSERT INTO MatchManyQ3 (n.ID, pid, internalId, n.externalId)
	SELECT
	DISTINCT
		n.ID
	   ,-1 AS pid
	   ,n.[Internal ID] AS internalId
	   ,n.[External ID] AS externalId
	FROM NSCUSTOMERS n
	--,MatchManyQ3 mmq
	WHERE ISNUMERIC(n.ID) = 1



DROP TABLE Q3DATA_CHILDREN
SELECT
	ac.CustomerName
   ,n.[InforCRM AccountID] InfoAccountName
   ,ac.CreditLimit
   ,ac.ARDivisionNo
   ,n.EMAIL AS EmailAddress
   ,ac.UDF_BWID
   ,'CUSTOMER-Customer' AS Status
   ,n.[External ID] AS externalId
   ,ac.FaxNo
   ,'False' AS INDIVIDUAL
   ,n.Phone AS TelephoneNo
   ,'Breathing Air Solutions' AS PRIMARY_SUBSIDARY
   ,ac.TaxSchedule
   ,ac.TermsCode
   ,ac.URLAddress
   ,ac.AddressLine1
   ,ac.AddressLine2
   ,ac.AddressLine3
   ,ac.City
   ,ac.CountryCode
   ,'' AS Address_defaultBilling
   ,'' AS Address_defaultShipping
   ,ac.State
   ,ac.ZipCode
	--,mmq.ID
	--,mmq.pid
	--,mmq.internalId
   ,mmq.ID
--,n.[Internal ID]
--,n.ID
--,n.[External ID]
--,n.EMAIL
--,n.Phone
--,n.[Web Address]
INTO Q3DATA_CHILDREN
FROM AR_CUSTOMER ac
	,MatchManyQ3 mmq
	,ACCOUNT_EXT sae
	,NSCUSTOMERS n
WHERE mmq.externalId = sae.ACCOUNTID
AND CAST(sae.BWCUSTOMERID AS VARCHAR) = ac.UDF_BWID -- float - nvarchar
AND mmq.pid > 0
AND n.[External ID] = mmq.externalId


--INNER JOIN SLX_Account_ext sae
--	ON sae.BWCUSTOMERID = ac.CustomerNo -- matches customer with iternal bwcustomerid
--INNER JOIN MatchManyQ3 mmq -- matches account number to exteral id which is the account number
--	ON mmq.externalId = sae.ACCOUNTID
--LEFT OUTER JOIN NSCustomers n
--	ON n.[ID] = ac.UDF_BWID

--end of children

DROP TABLE Q3DATA_PARENT
SELECT
	ac.CustomerName
   ,n.[InforCRM AccountID] InfoAccountName
   ,ac.CreditLimit
   ,ac.ARDivisionNo
   ,n.EMAIL AS EmailAddress
   ,ac.UDF_BWID
   ,'CUSTOMER-Customer' AS Status
   ,n.[External ID] AS externalId
   ,ac.FaxNo
   ,'False' AS INDIVIDUAL
   ,n.Phone AS TelephoneNo
   ,'Breathing Air Solutions' AS PRIMARY_SUBSIDARY
   ,ac.TaxSchedule
   ,ac.TermsCode
   ,ac.URLAddress
   ,ac.AddressLine1
   ,ac.AddressLine2
   ,ac.AddressLine3
   ,ac.City
   ,ac.CountryCode
   ,'' AS Address_defaultBilling
   ,'' AS Address_defaultShipping
   ,ac.State
   ,ac.ZipCode
	--,mmq.ID
	--,mmq.pid
	--,mmq.internalId
   ,mmq.ID
--,n.[Internal ID]
--,n.ID
--,n.[External ID]
--,n.EMAIL
--,n.Phone
--,n.[Web Address]
INTO Q3DATA_PARENT

FROM AR_CUSTOMER ac
--WHERE ac.UDF_BWID IN (SELECT pid FROM MatchManyQ3 mmq)
INNER JOIN MatchManyQ3 mmq
	ON mmq.ID = ac.UDF_BWID
		AND mmq.pid < 0
		AND ac.UDF_BWID IN (SELECT
				pid
			FROM MatchManyQ3 mmq)
LEFT OUTER JOIN NSCUSTOMERS n
	ON n.[ID] = ac.UDF_BWID

