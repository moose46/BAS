SELECT
	SO_SalesOrderDetail.SalesOrderNo
   ,Name
   ,soh.OrderType
   ,[Internal ID] AS InternalID
   ,[External ID] AS ExternalID
   ,Items.[Base Price] AS base_price
FROM items
LEFT JOIN SO_SalesOrderDetail
	ON ItemCode = Items.Name
left JOIN SO_SalesOrderHeader soh
	ON soh.SalesOrderNo = SO_SalesOrderDetail.SalesOrderNo
WHERE [Base Price] IS NULL
AND soh.OrderType = 'R'
AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE())
GROUP BY SO_SalesOrderDetail.SalesOrderNo
		,Name
		,soh.OrderType
		,[Internal ID]
		,[External ID]
		,[Base Price]
ORDER BY Name