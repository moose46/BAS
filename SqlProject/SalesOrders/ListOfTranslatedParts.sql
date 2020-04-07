/****** Script for SelectTopNRows command from SSMS  ******/
-- Reference Open Sales Order Template_MFG_FINAL.xlsx
-- creates table SO_COOKED
-- rwc 3/24/2020
-- added warehouse code, change from sod warehousecode to soh warehousecode
-- sent this to Kathy 4/6/2020 ListOfTransLatedParts.xlsx
USE babblefish
GO


SELECT distinct
   sod.ItemCode AS [itemLine_item] -- SO Details
   ,CASE
		WHEN EXISTS (SELECT
					*
				FROM ITEMCODE_MAS_NS xl
				WHERE xl.MAS = REPLACE(sod.ItemCode, '/', '')) THEN (SELECT
					xl.NETSUITE
				FROM ITEMCODE_MAS_NS xl
				WHERE xl.MAS = REPLACE(sod.ItemCode, '/', ''))
		ELSE (SELECT
					netsuite
				FROM ITEMCODE_MAS_NS
				WHERE MAS = REPLACE(sod.ItemCode, '/', ''))
	END AS xlated_part
   ,CASE
		WHEN EXISTS (SELECT
					xl.MAS
				FROM ITEMCODE_MAS_NS xl
				WHERE xl.MAS = REPLACE(sod.ItemCode, '/', '')) THEN (SELECT
					xl.NETSUITE
				FROM ITEMCODE_MAS_NS xl
				WHERE xl.MAS = REPLACE(sod.ItemCode, '/', ''))
		ELSE REPLACE(sod.ItemCode, '/', '')
	END AS final_part

FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod
	ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc
	ON arc.CustomerNo = soh.CustomerNo
WHERE OrderType = 'R' and sod.ItemCode is not null
--AND soh.SalesOrderNo LIKE '00715%'
ORDER BY sod.ItemCode
