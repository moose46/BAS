USE [babblefish]
GO

/****** Object:  Table [dbo].[SO_SalesOrderHeader]    Script Date: 3/31/2020 2:18:11 PM ******/
DROP TABLE [dbo].[SO_SalesOrderHeader]
GO

/****** Object:  Table [dbo].[SO_SalesOrderHeader]    Script Date: 3/31/2020 2:18:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SO_SalesOrderHeader](
	[SalesOrderNo] [nvarchar](255) primary key,
	[OrderDate] [datetime] NULL,
	[OrderType] [nvarchar](255) NULL,
	[OrderStatus] [nvarchar](255) NULL,
	[MasterRepeatingOrderNo] [nvarchar](255) NULL,
	[ShipExpireDate] [datetime] NULL,
	[ARDivisionNo] [nvarchar](255) NULL,
	[CustomerNo] [nvarchar](255) NULL,
	[BillToName] [nvarchar](255) NULL,
	[BillToAddress1] [nvarchar](255) NULL,
	[BillToAddress2] [nvarchar](255) NULL,
	[BillToAddress3] [nvarchar](255) NULL,
	[BillToCity] [nvarchar](255) NULL,
	[BillToState] [nvarchar](255) NULL,
	[BillToZipCode] [nvarchar](255) NULL,
	[BillToCountryCode] [nvarchar](255) NULL,
	[ShipToCode] [nvarchar](255) NULL,
	[ShipToName] [nvarchar](255) NULL,
	[ShipToAddress1] [nvarchar](255) NULL,
	[ShipToAddress2] [nvarchar](255) NULL,
	[ShipToAddress3] [nvarchar](255) NULL,
	[ShipToCity] [nvarchar](255) NULL,
	[ShipToState] [nvarchar](255) NULL,
	[ShipToZipCode] [nvarchar](255) NULL,
	[ShipToCountryCode] [nvarchar](255) NULL,
	[ShipVia] [nvarchar](255) NULL,
	[ShipZone] [nvarchar](255) NULL,
	[ShipZoneActual] [nvarchar](255) NULL,
	[ShipWeight] [nvarchar](255) NULL,
	[CustomerPONo] [nvarchar](255) NULL,
	[FOB] [nvarchar](255) NULL,
	[WarehouseCode] [nvarchar](255) NULL,
	[ConfirmTo] [nvarchar](255) NULL,
	[Comment] [nvarchar](255) NULL,
	[TermsCode] [nvarchar](255) NULL,
	[TaxSchedule] [nvarchar](255) NULL,
	[TaxExemptNo] [nvarchar](255) NULL,
	[InvalidTaxCalc] [nvarchar](255) NULL,
	[PrintSalesOrders] [nvarchar](255) NULL,
	[PrintPickingSheets] [nvarchar](255) NULL,
	[LastInvoiceOrderDate] [datetime] NULL,
	[LastInvoiceOrderNo] [nvarchar](255) NULL,
	[CurrentInvoiceNo] [nvarchar](255) NULL,
	[CheckNoForDeposit] [nvarchar](255) NULL,
	[CycleCode] [nvarchar](255) NULL,
	[FaxNo] [nvarchar](255) NULL,
	[BatchFax] [nvarchar](255) NULL,
	[BatchEmail] [nvarchar](255) NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[FreightCalculationMethod] [nvarchar](255) NULL,
	[LotSerialLinesExist] [nvarchar](255) NULL,
	[SalespersonDivisionNo] [nvarchar](255) NULL,
	[SalespersonNo] [nvarchar](255) NULL,
	[SplitCommissions] [nvarchar](255) NULL,
	[SalespersonDivisionNo2] [nvarchar](255) NULL,
	[SalespersonNo2] [nvarchar](255) NULL,
	[SalespersonDivisionNo3] [nvarchar](255) NULL,
	[SalespersonNo3] [nvarchar](255) NULL,
	[SalespersonDivisionNo4] [nvarchar](255) NULL,
	[SalespersonNo4] [nvarchar](255) NULL,
	[SalespersonDivisionNo5] [nvarchar](255) NULL,
	[SalespersonNo5] [nvarchar](255) NULL,
	[EBMUserType] [nvarchar](255) NULL,
	[EBMSubmissionType] [nvarchar](255) NULL,
	[EBMUserIDSubmittingThisOrder] [nvarchar](255) NULL,
	[PaymentType] [nvarchar](255) NULL,
	[OtherPaymentTypeRefNo] [nvarchar](255) NULL,
	[CancelReasonCode] [nvarchar](255) NULL,
	[PaymentTypeCategory] [nvarchar](255) NULL,
	[RMANo] [nvarchar](255) NULL,
	[JobNo] [nvarchar](255) NULL,
	[ResidentialAddress] [nvarchar](255) NULL,
	[CRMUserID] [nvarchar](255) NULL,
	[CRMPersonID] [nvarchar](255) NULL,
	[CRMOpportunityID] [nvarchar](255) NULL,
	[CRMCompanyID] [nvarchar](255) NULL,
	[CRMProspectID] [nvarchar](255) NULL,
	[TaxableSubjectToDiscount] [float] NULL,
	[NonTaxableSubjectToDiscount] [float] NULL,
	[TaxSubjToDiscPrcntOfTotSubjTo] [float] NULL,
	[DiscountRate] [float] NULL,
	[DiscountAmt] [float] NULL,
	[TaxableAmt] [float] NULL,
	[NonTaxableAmt] [float] NULL,
	[SalesTaxAmt] [float] NULL,
	[Weight] [float] NULL,
	[FreightAmt] [float] NULL,
	[DepositAmt] [float] NULL,
	[CommissionRate] [float] NULL,
	[SplitCommRate2] [float] NULL,
	[SplitCommRate3] [float] NULL,
	[SplitCommRate4] [float] NULL,
	[SplitCommRate5] [float] NULL,
	[NumberOfShippingLabels] [float] NULL,
	[LastNoOfShippingLabels] [float] NULL,
	[DateCreated] [datetime] NULL,
	[TimeCreated] [nvarchar](255) NULL,
	[UserCreatedKey] [nvarchar](255) NULL,
	[DateUpdated] [datetime] NULL,
	[TimeUpdated] [nvarchar](255) NULL,
	[UserUpdatedKey] [nvarchar](255) NULL,
	[UDF_LEADSOURCE] [nvarchar](255) NULL,
	[UDF_ORDERSUBTYPE] [nvarchar](255) NULL,
	[UDF_GSA] [nvarchar](255) NULL,
	[UDF_BAS_REP] [nvarchar](255) NULL,
	[UDF_ORDER_TYPE] [nvarchar](255) NULL,
	[UDF_TECHNICIAN] [nvarchar](255) NULL,
	[BillToDivisionNo] [nvarchar](255) NULL,
	[BillToCustomerNo] [nvarchar](255) NULL,
	[SalesOrderPrinted] [nvarchar](255) NULL,
	[PickingSheetPrinted] [nvarchar](255) NULL,
	[PromotedDate] [datetime] NULL,
	[UDF_AIR_TEST_PROGRAM] [nvarchar](255) NULL,
	[UDF_MAINTENANCE_PROGRAM] [nvarchar](255) NULL,
	[UDF_PM_END_DATE] [datetime] NULL,
	[UDF_PM_SIGNED_DATE] [datetime] NULL,
	[UDF_PM_START_DATE] [datetime] NULL,
	[UDF_AIRTEST_BA_MONTHS] [nvarchar](255) NULL,
	[UDF_AIRTEST_SEND_MONTHS] [nvarchar](255) NULL,
	[UDF_AT_END_DATE] [nvarchar](255) NULL,
	[UDF_AT_START_DATE] [nvarchar](255) NULL,
	[UDF_AT_SINGLE_MONTHS] [nvarchar](255) NULL,
	[UDF_PM_RUN_BRANCH] [nvarchar](255) NULL,
	[UDF_PM_RUN_MONTHS] [nvarchar](255) NULL,
	[UDF_PM_RUN_NAME] [nvarchar](255) NULL,
	[UDF_COMPRESSOR_MODEL_NUMBER] [nvarchar](255) NULL,
	[UDF_AIR_CONTROL_PANEL_MODEL] [nvarchar](255) NULL,
	[UDF_AIR_CONTROL_PANEL_SERIAL] [nvarchar](255) NULL,
	[UDF_COMPRESSOR_BLOCK_MODEL] [nvarchar](255) NULL,
	[UDF_COMPRESSOR_BLOCK_SERIAL] [nvarchar](255) NULL,
	[UDF_COMPRESSOR_SERIAL_NUMBER] [nvarchar](255) NULL,
	[UDF_EQUIPMENT_COVERED] [nvarchar](255) NULL,
	[UDF_FILL_STATION_MODEL] [nvarchar](255) NULL,
	[UDF_FILL_STATION_SERIAL_NUMBER] [nvarchar](255) NULL,
	[UDF_PURIFIER_MODEL] [nvarchar](255) NULL,
	[UDF_PURIFIER_SERIAL_NUMBER] [nvarchar](255) NULL,
	[UDF_STORAGE_MODEL] [nvarchar](255) NULL,
	[UDF_STORAGE_SERIAL] [nvarchar](255) NULL,
	[UDF_PM_CONTACT] [nvarchar](255) NULL,
	[UDF_PM_AIRTEST] [nvarchar](255) NULL,
	[UDF_PP_AMOUNT] [nvarchar](255) NULL,
	[UDF_PP_DATE] [nvarchar](255) NULL,
	[UDF_PREPAY] [nvarchar](255) NULL,
	[UDF_PREPAY_SO] [nvarchar](255) NULL,
	[UDF_TOTAL_PM_COST] [nvarchar](255) NULL,
	[UDF_EQ_SALES_NOTES] [nvarchar](255) NULL
) ON [PRIMARY]
GO

