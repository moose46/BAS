USE babblefish
GO
SELECT
	VendorNo , APDivisionNo, nsv.[External ID]
FROM PO_PurchaseOrderHeader poh
left join NS_Vendors nsv on nsv.[External ID] = poh.APDivisionNo + '-' + poh.VendorNo 
--left join NS_Vendors nsv on poh.VendorNo like('%' + nsv.[External ID] + '%') 
where DateCreated >= DATEADD(YEAR,-1,getdate())

GROUP BY VendorNo,APDivisionNo, [External ID]
--having count(VendorNo) > 1
order by VendorNo