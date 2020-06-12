SELECT
	WarehouseCode
FROM SO_SalesOrderHeader
GROUP BY WarehouseCode
ORDER BY WarehouseCode

select WarehouseCode from SO_SalesOrderDetail 
GROUP BY WarehouseCode
ORDER BY WarehouseCode
