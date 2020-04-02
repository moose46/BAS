/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	[CustomerNo]
FROM [babblefish].[dbo].[AR_Customer]
GROUP BY CustomerNo
HAVING COUNT(*) > 1

select poh.PurchaseOrderNo from PO_PurchaseOrderHeader poh
group by poh.PurchaseOrderNo
having count(*) > 1