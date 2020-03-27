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
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo ) is not null
			 THEN (SELECT
					[Internal ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
				ELSE
				(select -314159 )
	END AS vendorid
	,poh.APDivisionNo + '-' + poh.VendorNo as netsuite_external_id
FROM PO_PurchaseOrderHeader poh
where poh.DateCreated > DATEADD(YEAR, -1,GETDATE())

order by vendorid