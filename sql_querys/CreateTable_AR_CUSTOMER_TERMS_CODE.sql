USE [babblefish]
GO

/****** Object:  Table [dbo].[AR_CUSTOMER_TERMS_CODE]    Script Date: 4/1/2020 9:20:52 AM ******/
DROP TABLE [dbo].[AR_CUSTOMER_TERMS_CODE]
GO

/****** Object:  Table [dbo].[AR_CUSTOMER_TERMS_CODE]    Script Date: 4/1/2020 9:20:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AR_CUSTOMER_TERMS_CODE](
	[TERMS_CODE] [nvarchar](6) primary key,
	[NS_TERMS] [nvarchar](256) NOT NULL
) 
GO


