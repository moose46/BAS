-- Purchase Order Header Vendor Address vs vendorNo

USE babblefish
GO
SELECT
	ppoh.APDivisionNo
   ,ppoh.VendorNo
   ,UPPER (PurchaseAddress1)
   ,ppoh.PurchaseAddress2
   ,ppoh.PurchaseState
   ,ppoh.PurchaseCity
   ,ppoh.PurchaseZipCode
   ,ppoh.CustomerNo
   ,ppoh.PurchaseName
FROM PO_PurchaseOrderHeader ppoh
WHERE ppoh.DateCreated > DATEADD(YEAR, -1, GETDATE())
--AND ppoh.VendorNo LIKE 'BAU%'
GROUP BY ppoh.APDivisionNo
		,ppoh.VendorNo
		,ppoh.PurchaseAddress1
		,ppoh.PurchaseAddress2
		,ppoh.PurchaseState
		,ppoh.PurchaseCity
		,ppoh.PurchaseZipCode
		,ppoh.CustomerNo
		,ppoh.PurchaseName
ORDER BY ppoh.VendorNo
