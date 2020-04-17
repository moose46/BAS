--find all matching vendors that are in both NetSuite and MAS
use babblefish
GO
SELECT
  nsv.Name 'NS_VendorName',
  nsv.[Internal ID] 'NS_InternalId',
  nsv.[External ID] 'NS_ExternalId',
  --apv.VendorName 'MAS_VendorName',
  apv.APDivisionNo 'MAS_Division',
  apv.VendorNo 'MAS_VendorNo'
FROM AP_Vendor apv,
  NS_Vendors nsv
WHERE
  --apv.VendorNo LIKE '%BAUER%' -- AND
  nsv.[External ID] = apv.APDivisionNo + '-' + apv.VendorNo
union
SELECT
  nsv.Name 'NS_VendorName',
  nsv.[Internal ID] 'NS_InternalId',
  nsv.[External ID] 'NS_ExternalId',
  --apv.VendorName 'MAS_VendorName',
  apv.APDivisionNo 'MAS_Division',
  apv.VendorNo 'MAS_VendorNo'
FROM AP_Vendor apv,
  NS_Vendors nsv
WHERE
  --apv.VendorNo LIKE '%BAUER%' -- AND
  nsv.Name = UPPER(apv.VendorName)
order by
  nsv.Name