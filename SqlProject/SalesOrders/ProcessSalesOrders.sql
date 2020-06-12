/****** Script for SelectTopNRows command from SSMS  ******/
-- Reference Open Sales Order Template_MFG_FINAL.xlsx
-- creates table SO_COOKED
-- rwc 3/24/2020
-- added warehouse code, change from sod warehousecode to soh warehousecode
SELECT
	'Dropping the SO_COOKED Table ...'

USE babblefish
GO
  IF OBJECT_ID('dbo.SO_COOKED', 'U') IS NOT NULL DROP TABLE dbo.SO_COOKED;
GO
SELECT
	'Started Processing the SO_COOKED Table ...'
GO


SELECT
	SUBSTRING(
	soh.SalesOrderNo,
	PATINDEX('%[^%0]%', soh.SalesOrderNo),
	LEN(soh.SalesOrderNo)
	) AS externalid -- SO Header
   ,SUBSTRING(
	soh.SalesOrderNo,
	PATINDEX('%[^%0]%', soh.SalesOrderNo),
	LEN(soh.SalesOrderNo)
	) AS [tranId] -- SO Header
   ,soh.CustomerNo AS [Customer] -- AR Customer
   ,FORMAT(soh.OrderDate, 'MM/dd/yy') AS [trandate] -- SO Header
   ,orderstatus AS [orderstatus] -- SO Header
   ,FORMAT(soh.UDF_PM_START_DATE, 'MM/dd/yyyy') AS custbody_bas_pm_start_date
   ,FORMAT(soh.UDF_PM_END_DATE, 'MM/dd/yyyy') AS custbody_bas_pm_end_date
   ,CustomerPONo AS [otherrefnum] -- SO Header
   ,soh.SalespersonNo AS [salesrep] -- SO Header
   ,'Service: Field Service' AS [Department]
   ,CASE
		WHEN (SELECT
					CorrectedName
				FROM MAS_WAREHOUSE
				WHERE soh.WarehouseCode = Warehouse)
			= NULL THEN soh.WarehouseCode
		ELSE (SELECT
					CorrectedName
				FROM MAS_WAREHOUSE
				WHERE soh.WarehouseCode = Warehouse)
	END AS [Location] -- SO Header
   ,sod.Discount AS [discount_discountItem] -- SO Details

	--sod.LineKey,sod.LineSeqNo,
	--added replace to correct comma's in csv file rwc 6/2/2020
   ,REPLACE(sod.ItemCode, ',', ' ') AS [itemLine_item] -- SO Details
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
		ELSE CASE
				-- removed per email FW: Credit Card Fee - got an answer from Mark
				-- when ItemCode like '/CC FEE' then REPLACE(Replace(sod.ItemCode, '/CC', 'Comment'), '/', '')
				WHEN ItemCode LIKE '/C' THEN REPLACE(REPLACE(sod.ItemCode, '/C', 'Comment'), '/', '')
				ELSE REPLACE(sod.ItemCode, '/', '')
			END
	END AS final_part
   ,sod.QuantityOrdered AS [itemLine_quantity] -- SO Details
   ,sod.UnitPrice AS itemLine_salesPrice
	--end AS [itemLine_salesPrice],
	-- end of itemLine_salesPrice
	-- =============================================================
	-- start of itemLine_description
	--===============================================================
   ,CASE
		-- replace the itemLine_amount with the price from NetSuite
		WHEN EXISTS (SELECT
					[External ID]
				FROM Items
				WHERE REPLACE(sod.ItemCode, '/', '') = [External Id]) THEN (SELECT
					[Base Price] -- check with Kathy about this one
				FROM Items
				WHERE REPLACE(sod.ItemCode, '/', '') = [External Id]
				GROUP BY [Base Price])
		ELSE -sod.UnitPrice -- SO Details can't find a price, make it negative
	END AS [itemLine_amount] -- SO Details
   ,CASE
		-- replace item description with the description from NetSuite
		WHEN (ItemCode LIKE '/BAS-PMFL2') THEN 'Semi Annual Preventative Maintenance'
		WHEN (
			ItemCode LIKE '/SLP-HP-WITH MAINTENANCE'
			) THEN 'Single High Pressure Air Test. Quarterly Air Testing'
		WHEN EXISTS (SELECT
					[External ID]
				FROM Items
				WHERE sod.ItemCode = [External Id]) THEN (SELECT
					-- 6/2/2020 added replace rwc
					REPLACE([Description], ',', ' ')
				FROM Items
				WHERE sod.ItemCode = [External Id]
				GROUP BY [Description])
		ELSE REPLACE(ItemCodeDesc, ',', '')
	END AS [itemLine_description] -- SO Details
	-- End of itemLineIte_description
	-- ========================================================
   ,soh.Comment AS NetSuiteDescription
   , -- just a place holder to be updated later
	'Yes' AS [itemLine_isTaxable]
   ,'BASE PRICE' AS [itemLine_priceLevel]
   ,
	-- added 6/8/2020 rwc
	REPLACE([ShipToName], ',', ' ') AS [shipaddressee] -- SO Header
   ,REPLACE([ShipToAddress1], ',', ' ') AS [shipAddr1] -- SO Header
   ,REPLACE([ShipToAddress2], ',', ' ') AS [shipAddr2] -- SO Header
   ,[ShipToCity] AS [shipCity] -- SO Header
   ,[ShipToCity] AS [shipState] -- SO Header
   ,[ShipToZipCode] AS [shipZip] -- SO Header
   ,[ShipToCountryCode] AS [shipCountry] -- SO Header
   ,CASE
		WHEN EXISTS (SELECT
					TERMS_CODE
				FROM AR_CUSTOMER_TERMS_CODE
				WHERE TERMS_CODE = arc.TermsCode) THEN (SELECT
					NS_TERMS
				FROM AR_CUSTOMER_TERMS_CODE
				WHERE TERMS_CODE = arc.TermsCode)
	END AS terms
   ,SOH.ConfirmTo AS [billattention]
   ,REPLACE([BillToName], ',', ' ') AS [billAddressee] -- SO Header
   ,
	-- added 6/8/2020 to remove commas for csv file
	REPLACE([BillToAddress1], ',', ' ') AS [billAddr1] -- SO Header
   ,REPLACE([BillToAddress2], ',', ' ') AS [billAddr2] -- SO Header
	-------------------------------------------------
   ,[BillToCity] AS [billCity] -- SO Header
   ,[BillToState] AS [billState] -- SO Header
   ,[BillToZipCode] AS [billZip] -- SO Header
   ,[BillToCountryCode] AS [billCountry] -- SO Header
   ,'?' AS [exchangerate]
   ,arc.TaxSchedule AS [istaxable]
	-- AR Customer
   ,arc.EmailAddress AS [email] -- AR Customer
   ,soh.FaxNo AS [fax] -- SO Header
   ,soh.UDF_MAINTENANCE_PROGRAM
   ,REPLACE(soh.UDF_PM_CONTACT, ',', ' ') AS UDF_PM_CONTACT
   ,FORMAT(soh.UDF_PM_SIGNED_DATE, 'MM/dd/yyyy') AS UDF_PM_SIGNED_DATE
   ,REPLACE(soh.UDF_AIR_TEST_PROGRAM, ',', ' ') AS UDF_AIR_TEST_PROGRAM
   ,FORMAT(CAST(soh.UDF_AT_START_DATE AS DATE), 'MM/dd/yyyy') AS UDF_AT_START_DATE
   ,FORMAT(CAST(soh.UDF_AT_END_DATE AS DATE), 'MM/dd/yyyy') AS UDF_AT_END_DATE
   ,soh.UDF_AIRTEST_BA_MONTHS
   ,soh.UDF_AT_SINGLE_MONTHS
   ,soh.UDF_AIRTEST_SEND_MONTHS
   ,soh.UDF_PREPAY
   ,FORMAT(CAST(soh.UDF_PP_DATE AS DATE), 'MM/dd/yyyy') AS UDF_PP_DATE
   ,soh.UDF_PP_AMOUNT
   ,
	-- 6/8/2020 rwc
	REPLACE(soh.UDF_TOTAL_PM_COST, ',', '') AS UDF_TOTAL_PM_COST
   ,soh.UDF_PREPAY_SO
   ,soh.UDF_PM_AIRTEST
   ,soh.UDF_PM_RUN_MONTHS
   ,soh.UDF_PM_RUN_BRANCH
   ,FORMAT(soh.UDF_PM_START_DATE, 'MM/dd/yyyy') AS UDF_PM_START_DATE
   ,FORMAT(soh.UDF_PM_END_DATE, 'MM/dd/yyyy') AS UDF_PM_END_DATE
   ,soh.CustomerPONo
   ,soh.OrderType
   ,sod.LineSeqNo INTO SO_COOKED
FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod
	ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc
	ON arc.CustomerNo = soh.CustomerNo
WHERE OrderType = 'R'
AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE())
--AND soh.SalesOrderNo LIKE '%69520%'
--and soh.SalesOrderNo between 69520 and 70075 for kathy testing
ORDER BY sod.SalesOrderNo,
sod.LineSeqNo,
trandate,
tranId
GO
SELECT
	'Query Completed, Now Adding Indexes'
Alter Table SO_COOKED
Add
  Id Int Identity(1, 1)
alter table SO_COOKED
add
  constraint pk_so_cooked primary key (id)
SELECT
	'Updating Netsuite Descriptions ...'
GO
--update Netsuite descriptions
-- added replace 6/2/2020 to remove comma's causing the csv file to get out of line rwc
UPDATE SO_COOKED
SET NetSuiteDescription = REPLACE(Description, ',', ' ')
FROM SO_COOKED
INNER JOIN Items
	ON name = SO_COOKED.final_part
GO
UPDATE SO_COOKED
SET itemLine_salesPrice = [Base Price]
FROM SO_COOKED
INNER JOIN Items
	ON name = SO_COOKED.final_Part

GO
SELECT
	'Updating itemLine_amount..'

UPDATE SO_COOKED
SET itemLine_amount = [Base Price] * itemLine_quantity
FROM SO_COOKED
INNER JOIN Items
	ON name = SO_COOKED.final_Part
GO
SELECT
	'Process Sales Orders is Now Completed!'
GO