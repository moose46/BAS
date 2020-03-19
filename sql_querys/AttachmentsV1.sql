USE babblefish
GO

SELECT
	awi.SourceFileName,
	awi.TargetPath,
	awi.ExternalId 'SLX AccountID'
   ,n.ID AS 'NS ID'
   ,n.[Internal ID] AS 'NS InternalID'
--,COUNT(*) AS cnt
--,COUNT(a.ACCOUNTID)
FROM ATTACHMENT_WAS_IS awi 
LEFT JOIN NSCustomers n
	ON n.[External ID] = awi.ExternalId
--,ACCOUNT_EXT ae
--	,NSCustomers n
--,HISTORY h
WHERE --(ae.ACCOUNTID = a.ACCOUNTID
--AND 
--h.HISTORYID = a.HISTORYID
----AND n.ID = CAST(ae.BWCUSTOMERID AS NVARCHAR)
--AND
--a.FILENAME LIKE 'Mail Merge\U6UJ9A000037%'  --AND a.ACCOUNTID = 'A6UJ9A00082N'

--GROUP BY n.ID, n.[Internal ID], a.ACCOUNTID
ORDER BY awi.ACCOUNTID

--SELECT d.compatibility_level FROM sys.databases d WHERE name = 'babblefish'

--BEGIN TRANSACTION
--INSERT INTO [babblefish].[dbo].[ATTACHMENT_WAS_IS] (SourceFileName , TargetFileName , SourcePath, TargetPath) VALUES ('boo1','boo2','xxx1','xxxx2');
--COMMIT

