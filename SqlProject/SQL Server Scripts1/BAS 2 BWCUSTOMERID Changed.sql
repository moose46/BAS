/****** Script for SelectTopNRows command from SSMS  ******/
-- BAS 2
USE babblefish
go
DROP TABLE BAS2_BWCUSTOMERID

SELECT
	sae.[ACCOUNTID] AS 'SLX EXT'
   ,ac.CustomerName 'MAS'
   ,sae.BWCUSTOMERID 'SLX EXT BWCUSTOMERID'
   ,iif(sae.ACCOUNTID = n.[External ID], 'True','False') AS 'Does NS Match MAS'
   ,n.[Company Name] 'NS Company Name'
   ,sae.[MODIFYDATE]
   ,n.[External ID] 'NS External Id' INTO BAS2_BWCUSTOMERID
FROM SLX_ACCOUNT_EXT sae
	,NSCUSTOMERS n
	,AR_Customer ac
WHERE sae.BWCUSTOMERID = ac.UDF_BWID
AND n.ID = sae.BWCUSTOMERID
AND sae.MODIFYDATE > '12/1/2019'
ORDER BY MODIFYDATE DESC