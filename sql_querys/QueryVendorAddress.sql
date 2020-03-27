SELECT
	ppoh.APDivisionNo
   ,ppoh.VendorNo,[ShipToAddress1]
FROM PO_PurchaseOrderHeader ppoh
WHERE ppoh.DateCreated > DATEADD(YEAR,-1,getdate())
GROUP BY ppoh.APDivisionNo
		,ppoh.VendorNo,ppoh.ShipToAddress1
