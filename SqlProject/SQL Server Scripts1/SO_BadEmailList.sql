-- find bad email addresses
-- ^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$
SELECT
	soh.SalesOrderNo
   ,BillToName
   ,soh.EmailAddress
FROM SO_SalesOrderHeader soh
WHERE NOT PATINDEX('%[^a-z,0-9,@,.,_,\-]%', soh.EmailAddress) = 0

SELECT
	arc.CustomerNo
   ,CustomerName
   ,UDF_BWID
   ,EmailAddress
FROM AR_Customer arc
WHERE NOT PATINDEX('%[^a-z,0-9,@,.,_]%', arc.EmailAddress) = 0

SELECT
	PurchaseOrderNo,
	VendorNo, EmailAddress
FROM PO_PurchaseOrderHeader
WHERE NOT PATINDEX('%[^a-z,0-9,@,.,_,\-]%', EmailAddress) = 0
