USE [master]
GO

/****** Object:  Table [dbo].[AR_Customer]    Script Date: 2/11/2020 8:16:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AR_Customer_lt](
	[ARDivisionNo] [nvarchar](255) NULL,
	[CustomerNo] [nvarchar](255) NULL,
	[CustomerName] [nvarchar](255) NULL,
	[AddressLine1] [nvarchar](255) NULL,
	[AddressLine2] [nvarchar](255) NULL,
	[AddressLine3] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[ZipCode] [nvarchar](255) NULL,
	[CountryCode] [nvarchar](255) NULL,
	[TelephoneNo] [nvarchar](255) NULL,
	[TelephoneExt] [nvarchar](255) NULL,
	[FaxNo] [nvarchar](255) NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[URLAddress] [nvarchar](255) NULL,
	[TaxSchedule] [nvarchar](255) NULL,
	[TaxExemptNo] [nvarchar](255) NULL,
	[TermsCode] [nvarchar](255) NULL,
	[UDF_BWID] [nvarchar](255) NULL,
) ON [PRIMARY]
GO


