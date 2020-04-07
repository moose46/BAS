/****** Script for SelectTopNRows command from SSMS  ******/
-- find all vendors that are in the vp_vendor table and po_header table since 1 year ago
-- then show that that they do not have a Netsuite ID

SELECT
	[VendorNo]
   ,[APDivisionNo]
   ,apv.APDivisionNo + '-' + apv.VendorNo AS 'NS_DerivedVendorNo'
   ,CASE
		WHEN (SELECT
					[External ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = apv.APDivisionNo + '-' + apv.VendorNo)
			IS NOT NULL THEN (SELECT
					[External ID]
				FROM NS_Vendors nsv
				WHERE [External ID] = apv.APDivisionNo + '-' + apv.VendorNo)
		ELSE (SELECT
					'No NS_External ID')
	END AS ExternalID
   ,'Vendor From AP_Vendor'
FROM [babblefish].[dbo].[AP_Vendor] apv
WHERE VendorNo IN (SELECT
		VendorNo
	FROM PO_PurchaseOrderHeader
	WHERE DateCreated >= DATEADD(YEAR, -1, getdate())
	AND (SELECT
			[External ID]
		FROM NS_Vendors nsv
		WHERE [External ID] = apv.APDivisionNo + '-' + apv.VendorNo)
	IS NULL)
--SELECT
--	[VendorNo]
--   ,[APDivisionNo]
--   ,apv.APDivisionNo + '-' + apv.VendorNo AS 'NS_DerivedVendorNo'
--   ,CASE
--		WHEN (SELECT
--					[External ID]
--				FROM NS_Vendors nsv
--				WHERE [External ID] = apv.APDivisionNo + '-' + apv.VendorNo)
--			IS NOT NULL THEN (SELECT
--					[External ID]
--				FROM NS_Vendors nsv
--				WHERE [External ID] = apv.APDivisionNo + '-' + apv.VendorNo)
--		ELSE (SELECT
--					'No NS_External ID')
--	END AS ExternalID
--   ,'Vendor From AP_Vendor'
--FROM [babblefish].[dbo].[AP_Vendor] apv
--WHERE VendorNo IN (SELECT
--		VendorNo
--	FROM PO_PurchaseOrderHeader
--	WHERE DateCreated >= DATEADD(YEAR, -1, getdate()))
--UNION
--SELECT
--	VendorNo
--   ,APDivisionNo
--   ,poh.APDivisionNo + '-' + poh.VendorNo AS 'NS_DerivedVendorNo'
--   ,CASE
--		WHEN (SELECT
--					[External ID]
--				FROM NS_Vendors nsv
--				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
--			IS NOT NULL THEN (SELECT
--					[External ID]
--				FROM NS_Vendors nsv
--				WHERE [External ID] = poh.APDivisionNo + '-' + poh.VendorNo)
--		ELSE (SELECT
--					'No NS_External ID')
--	END AS ExternalID
--   ,'Vendor From PO_Header'
--FROM PO_PurchaseOrderHeader poh
--LEFT JOIN NS_Vendors nsv
--	ON nsv.[External ID] = poh.APDivisionNo + '-' + poh.VendorNo
----left join NS_Vendors nsv on poh.VendorNo like('%' + nsv.[External ID] + '%') 
--WHERE DateCreated >= DATEADD(YEAR, -1, getdate())

--ORDER BY 1, 2
