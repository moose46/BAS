USE babblefish
GO


SELECT
	COUNT(*)
FROM Q2DATA qd
--The accounts that are in NetSuite that were identified as
--the MAS WITH ONE MATCHING SLX ACCOUNT do not yet have default shipping addresses.
--These accounts will have the external id
--from SLX (SLX - Account.AccountID or Account.Account_EXT.AccountID)
--and an internal ID in NetSuite
DROP TABLE Q4ACCOUNT_ADDRESSES

SELECT
	n.ID -- used for me to debug
   ,n.[Internal ID]
   ,sa.[﻿ACCOUNTID] AS externalId
   ,ae.C_SYSTEMADDRESS AS address1
   ,ae.C_SYSTEMADDRESS2 AS address2
	-- can't find address3
   ,ae.C_SYSTEMCITY AS city
   ,ae.C_SYSTEMSTATE AS state
   ,ae.C_SYSTEMZIP AS Zip
   ,n.[Billing Country] AS country
   ,'False' AS Address_defaultBilling
   ,'True' AS Address1_defaultShipping INTO Q4ACCOUNT_ADDRESSES
FROM ACCOUNT_EXT sae
LEFT JOIN Q2DATA qd
	ON qd.externalId = sae.ACCOUNTID
INNER JOIN NSCustomers n
	ON qd.externalId = n.[External ID]
INNER JOIN ACCOUNT sa
	ON sa.[﻿ACCOUNTID] = qd.externalId
INNER JOIN ACCOUNTPRODUCT a
	ON a.ACCOUNTID = sae.ACCOUNTID
INNER JOIN ACCOUNTPRODUCT_EXT ae
	ON ae.ACCOUNTPRODUCTID = a.ACCOUNTPRODUCTID
WHERE ae.C_SYSTEMADDRESS IS NOT NULL

