/****** Script for SelectTopNRows command from SSMS  ******/
-- Reference Open Sales Order Template_MFG_FINAL.xlsx
-- creates table SO_COOKED
-- rwc 3/24/2020
-- added warehouse code, change from sod warehousecode to soh warehousecode
Select
  'Dropping the SO_COOKED Table ...'

USE babblefish
GO
  IF OBJECT_ID('dbo.SO_COOKED', 'U') IS NOT NULL DROP TABLE dbo.SO_COOKED;
GO
Select
  'Started Processing the SO_COOKED Table ...'
GO


SELECT
  SUBSTRING(
    soh.SalesOrderNo,
    PATINDEX('%[^%0]%', soh.SalesOrderNo),
    LEN(soh.SalesOrderNo)
  ) AS externalid -- SO Header
,
  SUBSTRING(
    soh.SalesOrderNo,
    PATINDEX('%[^%0]%', soh.SalesOrderNo),
    LEN(soh.SalesOrderNo)
  ) AS [tranId] -- SO Header
,
  soh.CustomerNo AS [Customer] -- AR Customer
,
  FORMAT(soh.OrderDate, 'MM/dd/yy') AS [trandate] -- SO Header
,
  orderstatus AS [orderstatus] -- SO Header
,
  UDF_PM_START_DATE AS [startdate],
  UDF_PM_END_DATE AS [enddate],
  CustomerPONo AS [otherrefnum] -- SO Header
,
  '?' AS [memo],
  soh.SalespersonNo AS [salesrep] -- SO Header
,
  soh.CRMOpportunityID AS [opportunity] -- SO Header
,
  '?' AS [saleseffectivedate],
  soh.UDF_LEADSOURCE AS [leadsource] -- SO Header
,
  '?' AS [partner],
  '?' AS [Department],
  '?' AS [Class],CASE
    WHEN (
      SELECT
        Description
      FROM MAS_WAREHOUSE
      WHERE
        soh.WarehouseCode = Warehouse
    ) = NULL THEN soh.WarehouseCode
    ELSE (
      SELECT
        Description
      FROM MAS_WAREHOUSE
      WHERE
        soh.WarehouseCode = Warehouse
    )
  END AS [Location] -- SO Header
,
  '?' AS [couponcode],
  '?' AS [promocode],
  sod.Discount AS [discount_discountItem] -- SO Details
,
  '?' AS [discount_discountrate],
  --sod.LineKey,sod.LineSeqNo,
  --added replace to correct comma's in csv file rwc 6/2/2020
  replace(sod.ItemCode,',',' ') AS [itemLine_item] -- SO Details
,CASE
    WHEN EXISTS (
      SELECT
        *
      FROM ITEMCODE_MAS_NS xl
      WHERE
        xl.MAS = REPLACE(sod.ItemCode, '/', '')
    ) THEN (
      SELECT
        xl.NETSUITE
      FROM ITEMCODE_MAS_NS xl
      WHERE
        xl.MAS = REPLACE(sod.ItemCode, '/', '')
    )
    ELSE (
      SELECT
        netsuite
      FROM ITEMCODE_MAS_NS
      WHERE
        MAS = REPLACE(sod.ItemCode, '/', '')
    )
  END AS xlated_part,CASE
    WHEN EXISTS (
      SELECT
        xl.MAS
      FROM ITEMCODE_MAS_NS xl
      WHERE
        xl.MAS = REPLACE(sod.ItemCode, '/', '')
    ) THEN (
      SELECT
        xl.NETSUITE
      FROM ITEMCODE_MAS_NS xl
      WHERE
        xl.MAS = REPLACE(sod.ItemCode, '/', '')
    )
    ELSE case
      -- removed per email FW: Credit Card Fee - got an answer from Mark
      -- when ItemCode like '/CC FEE' then REPLACE(Replace(sod.ItemCode, '/CC', 'Comment'), '/', '')
      when ItemCode like '/C' then REPLACE(Replace(sod.ItemCode, '/C', 'Comment'), '/', '')
      else REPLACE(sod.ItemCode, '/', '')
    end
  END AS final_part,
  sod.QuantityOrdered AS [itemLine_quantity] -- SO Details
,
  '?' AS [itemLine_serialNumbers],
  sod.UnitOfMeasure AS [itemLine_units] -- SO Details
,
  sod.UnitPrice as itemLine_salesPrice
  --end AS [itemLine_salesPrice],
  -- end of itemLine_salesPrice
  -- =============================================================
  -- start of itemLine_description
  --===============================================================
  ,case
    -- replace the itemLine_amount with the price from NetSuite
    when exists (
      select
        [External ID]
      from Items
      where
        replace(sod.ItemCode,'/','') = [External Id]
    ) then (
      select
        [Base Price] -- check with Kathy about this one
      from Items
      where
        replace(sod.ItemCode,'/','') = [External Id]
      group by
        [Base Price]
    )
    else -sod.UnitPrice -- SO Details can't find a price, make it negative
  end AS [itemLine_amount] -- SO Details
,case
    -- replace item description with the description from NetSuite
    when (ItemCode like '/BAS-PMFL2') then 'Semi Annual Preventative Maintenance'
    when (
      ItemCode like '/SLP-HP-WITH MAINTENANCE'
    ) then 'Single High Pressure Air Test. Quarterly Air Testing'
    when exists (
      select
        [External ID]
      from Items
      where
        sod.ItemCode = [External Id]
    ) then (
      select
	  -- 6/2/2020 added replace rwc
        replace([Description],',',' ')
      from Items
      where
        sod.ItemCode = [External Id]
      group by
        [Description]
    )
    else REPLACE(ItemCodeDesc, ',', '')
  end AS [itemLine_description] -- SO Details
  -- End of itemLineIte_description
  -- ========================================================
,
  soh.Comment as NetSuiteDescription, -- just a place holder to be updated later
  '?' AS [itemLine_isTaxable],
  '?' AS [itemLine_priceLevel],
  '?' AS [itemLine_department],
  '?' AS [itemLine_class],
  '?' AS [itemLine_location],
  '?' AS [itemLine_custom_Field_Name],
  '?' AS [itemLine_custom_Field_Name1],
  '?' AS [itemLine_custom_Field_Name2],
  '?' AS [shipdate],
  '?' AS [shipcarrier],
  '?' AS [shipmethod],
  '?' AS [shipcomplete],
  '?' AS [shipaddresslist],
  '?' AS [shipattention],
  -- added 6/8/2020 rwc
  replace([ShipToName],',',' ') AS [shipaddressee] -- SO Header
,
  replace([ShipToAddress1],',', ' ') AS [shipAddr1] -- SO Header
,
  replace([ShipToAddress2], ',', ' ') AS [shipAddr2] -- SO Header
,
  [ShipToCity] AS [shipCity] -- SO Header
,
  [ShipToCity] AS [shipState] -- SO Header
,
  [ShipToZipCode] AS [shipZip] -- SO Header
,
  [ShipToCountryCode] AS [shipCountry] -- SO Header
,
  '?' AS [shipPhone] --,arc.TermsCode AS [terms] -- AR Customer
,CASE
    WHEN EXISTS (
      SELECT
        TERMS_CODE
      FROM AR_CUSTOMER_TERMS_CODE
      WHERE
        TERMS_CODE = arc.TermsCode
    ) THEN (
      SELECT
        NS_TERMS
      FROM AR_CUSTOMER_TERMS_CODE
      WHERE
        TERMS_CODE = arc.TermsCode
    )
  END AS terms,
  '?' AS [billattention],
  replace([BillToName],',',' ') AS [billAddressee] -- SO Header
,
-- added 6/8/2020 to remove commas for csv file
  replace([BillToAddress1], ',',' ')AS [billAddr1] -- SO Header
,
  replace([BillToAddress2],',',' ') AS [billAddr2] -- SO Header
  -------------------------------------------------
,
  [BillToCity] AS [billCity] -- SO Header
,
  [BillToState] AS [billState] -- SO Header
,
  [BillToZipCode] AS [billZip] -- SO Header
,
  [BillToCountryCode] AS [billCountry] -- SO Header
,
  '?' AS [billPhone],
  '?' AS [currency],
  '?' AS [exchangerate],
  arc.TaxSchedule AS [istaxable],
  -- AR Customer
  '?' AS [taxitem],
  '?' AS [taxrate],
  [SalesOrderPrinted] AS [tobeprinted] -- SO Header
,
  '?' AS [tobeemailed],
  arc.EmailAddress AS [email] -- AR Customer
,
  '?' AS [tobefaxed],
  soh.FaxNo AS [fax] -- SO Header
,
  '?' AS [customermessage],
  '?' AS [custbody_nsts_ci_exclude],
  '?' AS [custom_Field_Name],
  '?' AS [custom_Field_Name1],
  '?' AS [custom_Field_Name2],
  soh.UDF_MAINTENANCE_PROGRAM,
  replace(soh.UDF_PM_CONTACT,',', ' ') as UDF_PM_CONTACT,
  soh.UDF_PM_SIGNED_DATE,
  replace(soh.UDF_AIR_TEST_PROGRAM,',',' ') as UDF_AIR_TEST_PROGRAM ,
  soh.UDF_AT_START_DATE,
  soh.UDF_AT_END_DATE,
  soh.UDF_AIRTEST_BA_MONTHS,
  soh.UDF_AT_SINGLE_MONTHS,
  soh.UDF_AIRTEST_SEND_MONTHS,
  soh.UDF_PREPAY,
  soh.UDF_PP_DATE,
  soh.UDF_PP_AMOUNT,
  -- 6/8/2020 rwc
  replace(soh.UDF_TOTAL_PM_COST,',','') as UDF_TOTAL_PM_COST,
  soh.UDF_PREPAY_SO,
  soh.UDF_PM_AIRTEST,
  soh.UDF_PM_RUN_MONTHS,
  soh.UDF_PM_RUN_BRANCH,
  soh.UDF_PM_START_DATE,
  soh.UDF_PM_END_DATE,
  soh.CustomerNo,
  soh.OrderType,
  sod.LineSeqNo INTO SO_COOKED
FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc ON arc.CustomerNo = soh.CustomerNo
WHERE
  OrderType = 'R'
  AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE()) -- AND soh.SalesOrderNo LIKE '%74886%'
ORDER BY
  sod.SalesOrderNo,
  sod.LineSeqNo,
  trandate,
  tranId
GO
Select
  'Query Completed, Now Adding Indexes'
Alter Table SO_COOKED
Add
  Id Int Identity(1, 1)
alter table SO_COOKED
add
  constraint pk_so_cooked primary key (id)
Select
  'Updating Netsuite Descriptions ...'

--update Netsuite descriptions
-- added replace 6/2/2020 to remove comma's causing the csv file to get out of line rwc
UPDATE SO_COOKED
SET NetSuiteDescription = replace(Description,',',' ')
FROM
SO_COOKED
INNER join Items on name = SO_COOKED.final_part

UPDATE SO_COOKED
set itemLine_salesPrice = [Base Price]
from SO_COOKED
INNER Join Items on name = SO_COOKED.final_Part



UPDATE SO_COOKED
set itemLine_amount = [Base Price] * itemLine_quantity
from SO_COOKED
INNER Join Items on name = SO_COOKED.final_Part

select 'Process Sales Orders is Now COmpleted'
