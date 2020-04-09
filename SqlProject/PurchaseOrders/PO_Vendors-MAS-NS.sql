USE babblefish
GO
SELECT
	*
FROM (SELECT
		apv.VendorName MAS_VendorName
	   ,apv.APDivisionNo + '-' + apv.VendorNo AS MAS_VendorID
	   ,nsv.[External ID] AS NS_ExternalID
	FROM AP_Vendor apv
	RIGHT JOIN PO_PurchaseOrderHeader poh
		ON apv.VendorNo = poh.VendorNo
	RIGHT JOIN NS_Vendors nsv
		ON nsv.Name = apv.VendorName
	WHERE poh.DateCreated >= DATEADD(YEAR, -1, GETDATE()) --and VendorName like 'EAT%'
	GROUP BY apv.VendorName
			,apv.APDivisionNo
			,apv.VendorNo
			,nsv.[External ID]) AS ABS
WHERE abs.NS_ExternalID <> abs.MAS_VendorID
ORDER BY MAS_VendorID
  