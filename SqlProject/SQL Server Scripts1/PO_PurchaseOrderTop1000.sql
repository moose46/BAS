/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PurchaseOrderNo]
      ,[PurchaseOrderDate]
      ,[OrderType]
      ,[MasterRepeatingOrderNo]
      ,[RequiredExpireDate]
      ,[APDivisionNo]
      ,[VendorNo]
      ,[PurchaseName]
      ,[PurchaseAddress1]
      ,[PurchaseAddress2]
      ,[PurchaseAddress3]
      ,[PurchaseCity]
      ,[PurchaseState]
      ,[PurchaseZipCode]
      ,[PurchaseCountryCode]
      ,[PurchaseAddressCode]
      ,[ShipToCode]
      ,[ShipToName]
      ,[ShipToAddress1]
      ,[ShipToAddress2]
      ,[ShipToAddress3]
      ,[ShipToCity]
      ,[ShipToState]
      ,[ShipToZipCode]
      ,[ShipToCountryCode]
      ,[OrderStatus]
      ,[UseTax]
      --,[PrintPurchaseOrders]
      --,[OnHold]
      ,[BatchFax]
      ,[CompletionDate]
      ,[ShipVia]
      ,[FOB]
      ,[WarehouseCode]
      ,[ConfirmTo]
      ,[Comment]
      ,[ARDivisionNo]
      ,[CustomerNo]
      ,[TermsCode]
      ,[LastInvoiceDate]
      ,[LastInvoiceNo]
      ,[Form1099]
      ,[Box1099]
      ,[LastReceiptDate]
      ,[LastIssueDate]
      ,[LastReceiptNo]
      ,[LastIssueNo]
      ,[PrepaidCheckNo]
      ,[FaxNo]
      ,[TaxSchedule]
      ,[InvalidTaxCalc]
      ,[PrepaidAmt]
      ,[TaxableAmt]
      ,[NonTaxableAmt]
      ,[SalesTaxAmt]
      ,[FreightAmt]
      ,[PrepaidFreightAmt]
      ,[InvoicedAmt]
      ,[ReceivedAmt]
      ,[FreightSalesTaxInvAmt]
      ,[BackOrderLostAmt]
      ,[DateCreated]
      ,[TimeCreated]
      --,[UserCreatedKey]
      ,[DateUpdated]
      ,[TimeUpdated]
      ,[UserUpdatedKey]
      ,[BatchEmail]
      ,[EmailAddress]
      ,[LastPurchaseOrderDate]
      ,[LastPurchaseOrderNo]
      ,[SalesOrderNo]
      ,[RequisitorName]
      ,[RequisitorDepartment]
      ,[UDF_SO_ALIAS_ITEM]
      ,[UDF_SO_CUSTOMER_PO]
      ,[UDF_SO_NUMBER]
  FROM [babblefish].[dbo].[PO_PurchaseOrderHeader]