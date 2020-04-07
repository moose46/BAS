SELECT
	vendorno
   ,apdivisionno
FROM PO_PurchaseOrderHeader
GROUP BY vendorno
		,APDivisionNo
		order by VendorNo