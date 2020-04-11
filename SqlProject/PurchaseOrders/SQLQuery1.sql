USE babblefish
GO

SELECT
	v.APDivisionNo + '-' + v.VendorName AS MAS_Name, v.VendorNo as MAS_VendorNo
   ,nsv.Name AS NetSuite_Name, nsv.[External ID]
FROM Ap_Vendor v
LEFT JOIN PO_PurchaseOrderHeader poh
	ON poh.VendorNo = v.VendorNo
		AND poh.DateCreated >= DATEADD(YEAR, -1, getdate())
		AND OrderType = 'R'
inner JOIN NS_Vendors nsv
	ON nsv.Name = v.VendorName
where v.VendorName like 'EAT%'
order by v.VendorName