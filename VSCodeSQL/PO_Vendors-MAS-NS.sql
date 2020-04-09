use babblefish
go
select
  *
from (
    select
      apv.VendorName MAS_VendorName,
      apv.APDivisionNo + '-' + apv.VendorNo as MAS_VendorID,
      nsv.[External ID] as NS_ExternalID
    from AP_Vendor apv
    right join PO_PurchaseOrderHeader poh on apv.VendorNo = poh.VendorNo
    right JOIN NS_Vendors nsv on nsv.Name = apv.VendorName
    where
      poh.DateCreated >= DATEADD(YEAR, -1, GETDATE()) --and VendorName like 'EAT%'
    group by
      apv.VendorName,
      apv.APDivisionNo,
      apv.VendorNo,
      nsv.[External ID]
  ) as ABS
where
  abs.NS_ExternalID <> abs.MAS_VendorID
order by
  MAS_VendorID