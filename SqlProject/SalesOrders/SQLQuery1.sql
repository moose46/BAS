USE babblefish
GO

--select * from SO_SalesOrderHeader
--where UDF_EQ_SALES_NOTES like '%CC%' or Comment like '%CC%'

SELECT
	--sod.SalesOrderNo
	sod.ItemCode + char(9) AS ItemCode
   ,COUNT(soh.SalesOrderNo) AS SO_Count
FROM SO_SalesOrderDetail sod
LEFT JOIN SO_SalesOrderHeader soh
	ON soh.SalesOrderNo = sod.SalesOrderNo
WHERE sod.ItemCode LIKE '%FEE%'
AND Soh.DateCreated >= DATEADD(YEAR, -1, getdate())
AND soh.OrderType = 'R'
OR sod.ItemCode LIKE '%/C'
GROUP BY --Sod.SalesOrderNo
sod.ItemCode

SELECT
	COUNT(*)
   ,sod1.ItemCode + char(9) AS ItemCode
FROM SO_SalesOrderDetail sod1
WHERE sod1.SalesOrderNo = (SELECT
		SalesOrderNo
	FROM SO_SalesOrderDetail
	WHERE ItemCode LIKE '%FEE%'
	OR ItemCode LIKE '%/C'
	AND sod1.SalesOrderNo = SalesOrderNo
	GROUP BY SalesOrderNo
			,ItemCode)
GROUP BY sod1.ItemCode


SELECT
	customerno
   ,[ARDivisionNo]
   ,sod.ItemCode
   ,ItemCodeDesc
   ,OrderType
FROM SO_SalesOrderHeader soh
LEFT JOIN SO_SalesOrderDetail sod
	ON sod.SalesOrderNo = soh.SalesOrderNo
WHERE soh.SalesOrderNo = '0068463'--and soh.OrderType = 'R'
