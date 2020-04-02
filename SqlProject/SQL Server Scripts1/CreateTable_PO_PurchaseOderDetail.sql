USE [babblefish]
GO

/****** Object:  Table [dbo].[PO_PurchaseOrderDetail]    Script Date: 3/31/2020 1:57:05 PM ******/
DROP TABLE [dbo].[PO_PurchaseOrderDetail]
GO

/****** Object:  Table [dbo].[PO_PurchaseOrderDetail]    Script Date: 3/31/2020 1:57:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PO_PurchaseOrderDetail](
	[PurchaseOrderNo] [nvarchar](255) NULL,
	[LineKey] [nvarchar](255) NULL,
	[LineSeqNo] [nvarchar](255) NULL,
	[ItemCode] [nvarchar](255) NULL,
	[ExtendedDescriptionKey] [nvarchar](255) NULL,
	[ItemType] [nvarchar](255) NULL,
	[ItemCodeDesc] [nvarchar](255) NULL,
	[UseTax] [nvarchar](255) NULL,
	[RequiredDate] [datetime] NULL,
	[VendorPriceCode] [nvarchar](255) NULL,
	[PurchasesAcctKey] [nvarchar](255) NULL,
	[Valuation] [nvarchar](255) NULL,
	[UnitOfMeasure] [nvarchar](255) NULL,
	[WarehouseCode] [nvarchar](255) NULL,
	[ProductLine] [nvarchar](255) NULL,
	[MasterLineKey] [nvarchar](255) NULL,
	[Reschedule] [nvarchar](255) NULL,
	[JobNo] [nvarchar](255) NULL,
	[CostCode] [nvarchar](255) NULL,
	[CostType] [nvarchar](255) NULL,
	[ReceiptOfGoodsUpdated] [nvarchar](255) NULL,
	[WorkOrderNo] [nvarchar](255) NULL,
	[StepNo] [nvarchar](255) NULL,
	[SubStepPrefix] [nvarchar](255) NULL,
	[SubStepSuffix] [nvarchar](255) NULL,
	[WorkOrderType] [nvarchar](255) NULL,
	[AllocateLandedCost] [nvarchar](255) NULL,
	[VendorAliasItemNo] [nvarchar](255) NULL,
	[TaxClass] [nvarchar](255) NULL,
	[CommentText] [nvarchar](255) NULL,
	[AssetAccount] [nvarchar](255) NULL,
	[AssetTemplate] [nvarchar](255) NULL,
	[WeightReference] [nvarchar](255) NULL,
	[SalesOrderNo] [nvarchar](255) NULL,
	[CustomerPONo] [nvarchar](255) NULL,
	[Weight] [float] NULL,
	[QuantityOrdered] [float] NULL,
	[QuantityReceived] [float] NULL,
	[QuantityBackordered] [float] NULL,
	[MasterOriginalQty] [float] NULL,
	[MasterQtyBalance] [float] NULL,
	[MasterQtyOrderedToDate] [float] NULL,
	[QuantityInvoiced] [float] NULL,
	[UnitCost] [float] NULL,
	[OriginalUnitCost] [float] NULL,
	[ExtensionAmt] [float] NULL,
	[ReceivedAmt] [float] NULL,
	[InvoicedAmt] [float] NULL,
	[UnitOfMeasureConvFactor] [float] NULL,
	[ReceivedAllocatedAmt] [float] NULL,
	[InvoicedAllocatedAmt] [float] NULL,
	[PurchaseOrderHistoryDtlSeqNo] [nvarchar](255) NULL
) ON [PRIMARY]
GO

 create unique index UK_PODetail on dbo.PO_PurchaseOrderDetail([PurchaseOrderNo], LineKey)

