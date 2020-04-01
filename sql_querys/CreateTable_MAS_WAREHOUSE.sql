USE [babblefish]
GO

/****** Object:  Table [dbo].[MAS_WAREHOUSE]    Script Date: 3/29/2020 11:16:33 AM ******/
DROP TABLE [dbo].[MAS_WAREHOUSE]
GO

/****** Object:  Table [dbo].[MAS_WAREHOUSE]    Script Date: 3/29/2020 11:16:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MAS_WAREHOUSE](
	[Warehouse] [nvarchar](255) primary key,
	[Description] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Warehouse Name] [nvarchar](255) NULL
) ON [PRIMARY]
GO


