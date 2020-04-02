
USE babblefish
GO

SELECT
	nsv.[External ID]
   ,nsv.Name
	--,nsv.[Address 1]
   ,SUBSTRING(nsv.[External ID], 0, 3) division
   ,SUBSTRING(nsv.[External ID], 4, 8) vendorno
   ,(SELECT
			STRING_AGG(APDivisionNo, ',')
		FROM (SELECT DISTINCT
				poh1.APDivisionNo
			FROM PO_PurchaseOrderHeader as poh1
			WHERE poh1.vendorno = vendorno) as yyy) as wwww  -- within group (order by poh.APDivisionNo ASC) as divisions
FROM NS_Vendors nsv
LEFT JOIN PO_PurchaseOrderHeader poh
	ON poh.vendorno = SUBSTRING(nsv.[External ID], 4, 8)
		AND poh.APDivisionNo = SUBSTRING(nsv.[External ID], 0, 3)
		AND poh.PurchaseOrderDate > DATEADD(YEAR, -1, GETDATE())
GROUP BY nsv.[External ID]
		,nsv.Name
		 --, nsv.[Address 1]
		,SUBSTRING(nsv.[External ID], 0, 3)
		,SUBSTRING(nsv.[External ID], 4, 8)
		,SUBSTRING(nsv.[External ID], 4, 8)
ORDER BY nsv.Name
