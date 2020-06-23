/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SalesOrderNo]
      ,[ItemCode]
      ,[ItemType]
      ,[ItemCodeDesc]
      ,[QuantityOrdered]
      ,[UnitPrice]
      ,[UnitCost]
      ,[ExtensionAmt]
      ,[UnitOfMeasureConvFactor]
      ,[QuantityPerBill]
      ,[LineDiscountPercent]
      ,[Valuation]
      ,[LotSerialFullyDistributed]
      ,[APDivisionNo]
      ,[VendorNo]
  FROM [babblefish].[dbo].[SO_SalesOrderDetail] where SalesOrderNo = '0069910'