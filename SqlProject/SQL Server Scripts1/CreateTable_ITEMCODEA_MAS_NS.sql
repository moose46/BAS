USE [babblefish]
GO

/****** Object:  Table [dbo].[MAS_NS_XLAT_PART]    Script Date: 3/28/2020 11:59:37 AM ******/
DROP TABLE [dbo].[ITEMCODE_MAS_NS]
GO

/****** Object:  Table [dbo].[MAS_NS_XLAT_PART]    Script Date: 3/28/2020 11:59:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ITEMCODE_MAS_NS](
	[MAS] [nvarchar](255) NULL,
	[NETSUITE] [nvarchar](255) NULL,
	[DateCreated] datetime NOT NULL default CURRENT_TIMESTAMP,
	[DateUpdated] datetime NOT NULL default CURRENT_TIMESTAMP,
	id int IDENTITY (0,1)
) ON [PRIMARY]
GO


