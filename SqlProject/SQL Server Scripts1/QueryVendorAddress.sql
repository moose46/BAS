-- Purchase Order Header Vendor Address vs vendorNo

USE babblefish
GO
SELECT
	ppoh.APDivisionNo
   ,ppoh.VendorNo
    ,upper(ppoh.PurchaseName)
	,STRING_AGG(ppoh.APDivisionNo, ',')
  --,UPPER (PurchaseAddress1)
   --,upper(ppoh.PurchaseAddress2)
   --,ppoh.PurchaseState
   --,ppoh.PurchaseCity
   --,ppoh.PurchaseZipCode
   --,ppoh.CustomerNo
FROM PO_PurchaseOrderHeader ppoh
WHERE ppoh.DateCreated > DATEADD(YEAR, -1, GETDATE())
--AND ppoh.VendorNo LIKE 'BAU%'
GROUP BY ppoh.APDivisionNo
		,ppoh.VendorNo
		,ppoh.PurchaseName
		--,ppoh.PurchaseAddress1
		--,ppoh.PurchaseAddress2
		--,ppoh.PurchaseState
		--,ppoh.PurchaseCity
		--,ppoh.PurchaseZipCode
		--,ppoh.CustomerNo
ORDER BY ppoh.VendorNo, ppoh.APDivisionNo
