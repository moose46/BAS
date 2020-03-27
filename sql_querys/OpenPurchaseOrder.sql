USE babblefish
GO

SELECT
	poh.PurchaseOrderNo AS externalid-- header
   ,poh.APDivisionNo masdivisionno
   ,poh.VendorNo AS masvendorno
   ,CASE
		WHEN (SELECT
					[Internal ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
			IS NOT NULL THEN (SELECT
					[Internal ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
		ELSE (SELECT
					-314159)
	END AS vendorid
   ,poh.APDivisionNo + '-' + poh.VendorNo AS netsuite_external_id
FROM PO_PurchaseOrderHeader poh
WHERE poh.DateCreated > DATEADD(YEAR, -1, GETDATE())

ORDER BY vendorid