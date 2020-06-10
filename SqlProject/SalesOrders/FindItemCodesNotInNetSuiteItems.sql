SELECT
	'Dropping the itemsTemp Table ...'

USE babblefish
GO
  IF OBJECT_ID('dbo.itemsTemp', 'U') IS NOT NULL DROP TABLE dbo.itemsTemp;
GO
SELECT
	'Started Processing the itemsTemp Table ...'
GO


SELECT
	Name
   ,'N' AS Match INTO itemsTemp
FROM items
WHERE name IN (SELECT
		REPLACE(sod.ItemCode, '/', '')
	FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
	LEFT JOIN SO_SalesOrderDetail sod
		ON sod.SalesOrderNo = soh.SalesOrderNo
	LEFT JOIN AR_Customer arc
		ON arc.CustomerNo = soh.CustomerNo
	WHERE OrderType = 'R'
	AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE()))  --AND soh.SalesOrderNo LIKE '%74886%')
ORDER BY name
--  sod.SalesOrderNo,
--  sod.LineSeqNo

update itemsTemp set Match = 'Y' FROM
SO_COOKED
INNER join Items on name = SO_COOKED.final_part


