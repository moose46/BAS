/****** Script for SelectTopNRows command from SSMS  ******/
-- Reference Open Sales Order Template_MFG_FINAL.xlsx

-- rwc 3/24/2020
-- added warehouse code, change from sod warehousecode to soh warehousecode
SELECT
	SUBSTRING(soh.SalesOrderNo, PATINDEX('%[^%0]%', soh.SalesOrderNo), LEN(soh.SalesOrderNo)) AS externalid -- SO Header
   ,SUBSTRING(soh.SalesOrderNo, PATINDEX('%[^%0]%', soh.SalesOrderNo), LEN(soh.SalesOrderNo)) AS [tranId] -- SO Header
   ,soh.CustomerNo AS [Customer] -- AR Customer
   ,FORMAT(soh.OrderDate, 'MM/dd/yy') AS [trandate] -- SO Header
   ,orderstatus AS [orderstatus] -- SO Header
   ,'?' AS [startdate]
   ,'?' AS [enddate]
   ,CustomerPONo AS [otherrefnum] -- SO Header
   ,'?' AS [memo]
   ,soh.SalespersonNo AS [salesrep] -- SO Header
   ,soh.CRMOpportunityID AS [opportunity] -- SO Header
   ,'?' AS [saleseffectivedate]
   ,soh.UDF_LEADSOURCE AS [leadsource] -- SO Header
   ,'?' AS [partner]
   ,'?' AS [Department]
   ,'?' AS [Class]
   ,CASE
		WHEN (SELECT
					Description
				FROM MAS_WAREHOUSE
				WHERE soh.WarehouseCode = Warehouse)
			= NULL THEN soh.WarehouseCode
		ELSE (SELECT
					Description
				FROM MAS_WAREHOUSE
				WHERE soh.WarehouseCode = Warehouse)
	END AS [Location] -- SO Header
   ,'?' AS [couponcode]
   ,'?' AS [promocode]
   ,sod.Discount AS [discount-discountItem] -- SO Details
   ,'?' AS [discount-discountrate]
   ,REPLACE(sod.ItemCode, '/', '') AS [itemLine_item] -- SO Details
   ,CASE
		WHEN (SELECT
					TO_NETSUITE
				FROM MAS_NS_XLAT_PART xl
				WHERE xl.FROM_MAS = REPLACE(sod.ItemCode, '/', ''))
			= NULL THEN REPLACE(sod.ItemCode, '/', '')
		ELSE (SELECT
					TO_NETSUITE
				FROM MAS_NS_XLAT_PART
				WHERE FROM_MAS = REPLACE(sod.ItemCode, '/', ''))
	END AS new_part
   ,sod.QuantityOrdered AS [itemLine_quantity] -- SO Details
   ,'?' AS [itemLine_serialNumbers]
   ,sod.UnitOfMeasure AS [itemLine_units] -- SO Details
   ,sod.UnitPrice AS [itemLine_salesPrice] -- SO Details
   ,[UnitPrice] AS [itemLine_amount] -- SO Details
   ,REPLACE(ItemCodeDesc, ',', '') AS [itemLine_description] -- SO Details
   ,'?' AS [itemLine_isTaxable]
   ,'?' AS [itemLine_priceLevel]
   ,'?' AS [itemLine_department]
   ,'?' AS [itemLine_class]
   ,'?' AS [itemLine_location]
   ,'?' AS [itemLine_custom:Field Name]
   ,'?' AS [itemLine_custom:Field Name1]
   ,'?' AS [itemLine_custom:Field Name2]
   ,'?' AS [shipdate]
   ,'?' AS [shipcarrier]
   ,'?' AS [shipmethod]
   ,'?' AS [shipcomplete]
   ,'?' AS [shipaddresslist]
   ,'?' AS [shipattention]
   ,[ShipToName] AS [shipaddressee] -- SO Header
   ,[ShipToAddress1] AS [shipAddr1]-- SO Header
   ,[ShipToAddress2] AS [shipAddr2]-- SO Header
   ,[ShipToCity] AS [shipCity]-- SO Header
   ,[ShipToCity] AS [shipState]-- SO Header
   ,[ShipToZipCode] AS [shipZip]-- SO Header
   ,[ShipToCountryCode] AS [shipCountry]-- SO Header
   ,'?' AS [shipPhone]
   ,arc.TermsCode AS [terms] -- AR Customer
   ,'?' AS [billattention]
   ,[BillToName] AS [billAddressee] -- SO Header
   ,[BillToAddress1] AS [billAddr1] -- SO Header
   ,[BillToAddress2] AS [billAddr2] -- SO Header
   ,[BillToCity] AS [billCity] -- SO Header
   ,[BillToState] AS [billState] -- SO Header
   ,[BillToZipCode] AS [billZip] -- SO Header
   ,[BillToCountryCode] AS [billCountry]-- SO Header
   ,'?' AS [billPhone]
   ,'?' AS [currency]
   ,'?' AS [exchangerate]
   ,arc.TaxSchedule AS [istaxable] -- AR Customer
   ,'?' AS [taxitem]
   ,'?' AS [taxrate]
   ,[SalesOrderPrinted] AS [tobeprinted] -- SO Header
   ,'?' AS [tobeemailed]
   ,arc.EmailAddress AS [email] -- AR Customer
   ,'?' AS [tobefaxed]
   ,soh.FaxNo AS [fax] -- SO Header
   ,'?' AS [customermessage]
   ,'?' AS [custbody_nsts_ci_exclude]
   ,'?' AS [custom:Field Name]
   ,'?' AS [custom:Field Name1]
   ,'?' AS [custom:Field Name2]
FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod
	ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc
	ON arc.CustomerNo = soh.CustomerNo
WHERE OrderType = 'R'
AND soh.SalesOrderNo LIKE '00715%'
ORDER BY trandate, tranId, sod.LineKey
