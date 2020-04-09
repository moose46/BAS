USE babblefish
GO

SELECT
	v.VendorName as MAS_Name, nsv.Name as NetSuite_Name
FROM Ap_Vendor v
LEFT JOIN PO_PurchaseOrderHeader poh
	ON poh.VendorNo = v.VendorNo
		AND poh.DateCreated >= DATEADD(YEAR, -1, getdate())
		AND OrderType = 'R'
left join NS_Vendors nsv on nsv.Name = v.VendorName