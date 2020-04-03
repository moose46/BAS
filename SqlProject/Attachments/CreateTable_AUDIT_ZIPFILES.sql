USE [babblefish]
GO

/****** Object:  Table [dbo].[CreateTable_AuditAttachmentsZipFile]    Script Date: 3/10/2020 9:10:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE AUDIT_ZIPFILES

CREATE TABLE [dbo].[AUDIT_ZIPFILES] (
	[run_id] int NOT NULL,
	[SourcePath] [varchar](255) NOT NULL,
	[TargetPath] [varchar](255) NOT NULL,
	[SourceFilename] [varchar](255) NOT NULL,
	[TargetFilename] [varchar](255) NOT NULL,
	[InternalId] [varchar](255) NULL,
	[ExternalId] [varchar](255) NOT NULL,
	[DateZipFileCreated] [datetime] NOT NULL,
	AttachId VARCHAR(32) NOT null -- from attach table
) ON [PRIMARY]
GO

ALTER TABLE [AUDIT_ZIPFILES] ADD CONSTRAINT
    [DateZipFileCreated] DEFAULT GETDATE() FOR [DateZipFileCreated]