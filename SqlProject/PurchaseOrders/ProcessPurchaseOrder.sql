USE babblefish
GO
-- modified rwc 6/5/2020
SELECT
	poh.PurchaseOrderNo AS EXTERNALID-- header
	--poh.APDivisionNo masdivisionno
   ,poh.VendorNo
   ,CASE
		WHEN (SELECT
					[Internal ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
			IS NOT NULL THEN (SELECT
					[Internal ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)

		WHEN (SELECT
					[Internal Id]
				FROM NS_Vendors
				WHERE [External Id] LIKE ('%-' + poh.VendorNo + '%'))
			IS not NULL THEN (SELECT
					[Internal Id]
				FROM NS_Vendors
				WHERE [External Id] LIKE ('%-' + poh.VendorNo + '%'))
		ELSE (SELECT
					-314159)
	END AS netsuite_internal_id
	, '?' PURCHASE_CONTRACT
	, usercreatedkey
   ,poh.APDivisionNo + '-' + poh.VendorNo AS netsuite_external_id

FROM PO_PurchaseOrderHeader poh
WHERE poh.DateCreated > DATEADD(YEAR, -1, GETDATE())
--AND poh.VendorNo LIKE '%BAUER'
--and poh.VendorNo like 'AEROQU%'
--group by poh.APDivisionNo, VendorNo


ORDER BY netsuite_internal_id