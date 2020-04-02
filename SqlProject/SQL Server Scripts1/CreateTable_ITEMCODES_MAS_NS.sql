USE [babblefish]
GO

/****** Object:  Table [dbo].[ITEMCODE_MAS_NS]    Script Date: 3/29/2020 11:30:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE TABLE [dbo].[ITEMCODE_MAS_NS](
--	[MAS] [nvarchar](255) NULL,
--	[NETSUITE] [nvarchar](255) NULL,
--	[DateCreated] [datetime] NOT NULL,
--	[DateUpdated] [datetime] NOT NULL,
--	[id] [int] IDENTITY(0,1) NOT NULL
--) ON [PRIMARY]
--GO

--ALTER TABLE [dbo].[ITEMCODE_MAS_NS] ADD  DEFAULT (getdate()) FOR [DateCreated]
--GO

--ALTER TABLE [dbo].[ITEMCODE_MAS_NS] ADD  DEFAULT (getdate()) FOR [DateUpdated]
--GO


create unique index ak_item_code_mas_ms
 on dbo.itemcode_mas_ns(mas)