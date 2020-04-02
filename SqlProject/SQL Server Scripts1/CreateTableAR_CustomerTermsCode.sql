USE [babblefish]
GO

/****** Object:  Table [dbo].[AR_CUSTOMER_TERMS_CODE]    Script Date: 4/1/2020 9:04:20 AM ******/
DROP TABLE [dbo].[AR_CUSTOMER_TERMS_CODE]
GO

/****** Object:  Table [dbo].[AR_CUSTOMER_TERMS_CODE]    Script Date: 4/1/2020 9:04:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AR_CUSTOMER_TERMS_CODE](
	[TERMS_CODE] [nvarchar](max) primary key,
	[NS_TERMS] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


