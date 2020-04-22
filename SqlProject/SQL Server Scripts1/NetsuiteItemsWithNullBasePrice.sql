USE babblefish
GO

SELECT
	Name
   ,[Internal ID] AS InternalID
   ,[External ID] AS ExternalID
   ,Items.[Base Price] AS base_price
   ,'Found'
FROM items
LEFT JOIN SO_SalesOrderDetail
	ON ItemCode = Items.Name
LEFT JOIN SO_SalesOrderHeader
	ON SO_SalesOrderDetail.SalesOrderNo = SO_SalesOrderDetail.SalesOrderNo
WHERE [Base Price] IS NULL
AND SO_SalesOrderHeader.OrderType = 'R'
AND SO_SalesOrderHeader.DateCreated >= DATEADD(YEAR, -1, GETDATE())
GROUP BY Name
		,[Internal ID]
		,[External ID]
		,[Base Price]
ORDER BY Name

--UNION
--SELECT
--	Name
--   ,[Internal ID] AS InternalID
--   ,[External ID] AS ExternalID
--   ,Items.[Base Price] AS base_price
--   ,'Not Found'
--FROM items
--LEFT JOIN SO_SalesOrderDetail
--	ON ItemCode NOT IN (SELECT
--				Name
--			FROM Items)
--LEFT JOIN SO_SalesOrderHeader
--	ON SO_SalesOrderDetail.SalesOrderNo = SO_SalesOrderDetail.SalesOrderNo
--WHERE [Base Price] IS NULL
--AND SO_SalesOrderHeader.OrderType = 'R'
--AND SO_SalesOrderHeader.DateCreated >= DATEADD(YEAR, -1, GETDATE())
--GROUP BY Name
--		,[Internal ID]
--		,[External ID]
--		,[Base Price]

