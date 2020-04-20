USE [babblefish]
GO

/****** Object:  Table [dbo].[TimeSheets]    Script Date: 4/18/2020 4:41:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER TABLE [dbo].[TimeSheets] ALTER COLUMN [DateCreated] [datetime] NULL

GO

ALTER TABLE [dbo].[TimeSheets] ALTER COLUMN [DateUpdated]  [datetime] NULL
GO


ALTER TABLE ITEMCODE_MAS_NS
ADD CONSTRAINT pk_masns on COLUMN 