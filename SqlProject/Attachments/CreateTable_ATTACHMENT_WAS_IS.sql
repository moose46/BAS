-- 3/10/2020 added attachid
--contains the current zip file creation along with attachment_template_import to geneerate the csv files
USE [babblefish]
GO

/****** Object:  Table [dbo].[ATTACHMENT_WAS_IS]    Script Date: 3/5/2020 2:24:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE ATTACHMENT_WAS_IS
GO
CREATE TABLE [dbo].[ATTACHMENT_WAS_IS] (
	[SourcePath] [VARCHAR](MAX) NULL
   ,[TargetPath] [VARCHAR](MAX) NULL
   ,[SourceFileName] [VARCHAR](MAX) NULL
   ,[TargetFileName] [VARCHAR](256) NOT NULL -- removed unique key 3/17/2020 rwc
   ,[ExternalId] [VARCHAR](60) NULL
   ,[title] [NVARCHAR](40) NULL
   ,[tranDate] [DATE] NULL
   ,[memo] [NVARCHAR](4000) NULL
   ,[InternalId] [NVARCHAR](64) NULL
   ,run_id INT NOT NULL
   ,SourceFileNameRaw VARCHAR(255) NOT NULL
   ,AttachID VARCHAR(32) NOT NULL
   ,MailMerge INT NOT NULL
   ,DateCreated DATE NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ATTACHMENT_WAS_IS] ADD DEFAULT ('\\crm\SalesLogixLan\SlxLanDocuments\') FOR [SourcePath]
GO

ALTER TABLE [dbo].[ATTACHMENT_WAS_IS] ADD DEFAULT ('E:\NETSUITE ATTACHMENTS\') FOR [TargetPath]
GO

ALTER TABLE [dbo].[ATTACHMENT_WAS_IS] ADD DEFAULT ('title') FOR [title]
GO

GO
ALTER TABLE [dbo].[ATTACHMENT_WAS_IS] ADD DEFAULT 1 FOR MailMerge
GO

ALTER TABLE [dbo].[ATTACHMENT_WAS_IS] ADD DEFAULT GETDATE() FOR DateCreated
GO
