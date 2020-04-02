USE [babblefish]
GO

/****** Object:  Table [dbo].[PO_PurchaseOrderHeader]    Script Date: 3/31/2020 1:38:31 PM ******/
DROP TABLE [dbo].[PO_PurchaseOrderHeader]
GO

/****** Object:  Table [dbo].[PO_PurchaseOrderHeader]    Script Date: 3/31/2020 1:38:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PO_PurchaseOrderHeader](
	[PurchaseOrderNo] [nvarchar](255) primary key,
	[PurchaseOrderDate] [nvarchar] (255)NULL,
	[OrderType] [nvarchar](255) NULL,
	[MasterRepeatingOrderNo] [nvarchar](255) NULL,
	[RequiredExpireDate] [datetime] NULL,
	[APDivisionNo] [nvarchar](255) NULL,
	[VendorNo] [nvarchar](255) NULL,
	[PurchaseName] [nvarchar](255) NULL,
	[PurchaseAddress1] [nvarchar](255) NULL,
	[PurchaseAddress2] [nvarchar](255) NULL,
	[PurchaseAddress3] [nvarchar](255) NULL,
	[PurchaseCity] [nvarchar](255) NULL,
	[PurchaseState] [nvarchar](255) NULL,
	[PurchaseZipCode] [nvarchar](255) NULL,
	[PurchaseCountryCode] [nvarchar](255) NULL,
	[PurchaseAddressCode] [nvarchar](255) NULL,
	[ShipToCode] [nvarchar](255) NULL,
	[ShipToName] [nvarchar](255) NULL,
	[ShipToAddress1] [nvarchar](255) NULL,
	[ShipToAddress2] [nvarchar](255) NULL,
	[ShipToAddress3] [nvarchar](255) NULL,
	[ShipToCity] [nvarchar](255) NULL,
	[ShipToState] [nvarchar](255) NULL,
	[ShipToZipCode] [nvarchar](255) NULL,
	[ShipToCountryCode] [nvarchar](255) NULL,
	[OrderStatus] [nvarchar](255) NULL,
	[UseTax] [nvarchar](255) NULL,
	[PrintPurchaseOrders] [nvarchar](255) NULL,
	[OnHold] [nvarchar](255) NULL,
	[BatchFax] [nvarchar](255) NULL,
	[CompletionDate] [nvarchar](255) NULL,
	[ShipVia] [nvarchar](255) NULL,
	[FOB] [nvarchar](255) NULL,
	[WarehouseCode] [nvarchar](255) NULL,
	[ConfirmTo] [nvarchar](255) NULL,
	[Comment] [nvarchar](255) NULL,
	[ARDivisionNo] [nvarchar](255) NULL,
	[CustomerNo] [nvarchar](255) NULL,
	[TermsCode] [nvarchar](255) NULL,
	[LastInvoiceDate] [datetime] NULL,
	[LastInvoiceNo] [nvarchar](255) NULL,
	[Form1099] [nvarchar](255) NULL,
	[Box1099] [nvarchar](255) NULL,
	[LastReceiptDate] [datetime] NULL,
	[LastIssueDate] [nvarchar](255) NULL,
	[LastReceiptNo] [nvarchar](255) NULL,
	[LastIssueNo] [nvarchar](255) NULL,
	[PrepaidCheckNo] [nvarchar](255) NULL,
	[FaxNo] [nvarchar](255) NULL,
	[TaxSchedule] [nvarchar](255) NULL,
	[InvalidTaxCalc] [nvarchar](255) NULL,
	[PrepaidAmt] [float] NULL,
	[TaxableAmt] [float] NULL,
	[NonTaxableAmt] [float] NULL,
	[SalesTaxAmt] [float] NULL,
	[FreightAmt] [float] NULL,
	[PrepaidFreightAmt] [float] NULL,
	[InvoicedAmt] [float] NULL,
	[ReceivedAmt] [float] NULL,
	[FreightSalesTaxInvAmt] [float] NULL,
	[BackOrderLostAmt] [float] NULL,
	[DateCreated] [datetime] NULL,
	[TimeCreated] [nvarchar](255) NULL,
	[UserCreatedKey] [nvarchar](255) NULL,
	[DateUpdated] [datetime] NULL,
	[TimeUpdated] [nvarchar](255) NULL,
	[UserUpdatedKey] [nvarchar](255) NULL,
	[BatchEmail] [nvarchar](255) NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[LastPurchaseOrderDate] [datetime] NULL,
	[LastPurchaseOrderNo] [nvarchar](255) NULL,
	[SalesOrderNo] [nvarchar](255) NULL,
	[RequisitorName] [nvarchar](255) NULL,
	[RequisitorDepartment] [nvarchar](255) NULL,
	[UDF_SO_ALIAS_ITEM] [nvarchar](255) NULL,
	[UDF_SO_CUSTOMER_PO] [nvarchar](255) NULL,
	[UDF_SO_NUMBER] [nvarchar](255) NULL
) ON [PRIMARY]
GO


