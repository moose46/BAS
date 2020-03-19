/****** Script for SelectTopNRows command from SSMS  ******/
-- 2016 2 quarter only
SELECT TOP (1000) [SourcePath]
      ,[TargetPath]
      ,[SourceFileName]
      ,[TargetFileName]
      ,[ExternalId]
      ,[title]
      ,[tranDate]
      ,[memo]
      ,[InternalId]
      ,[run_id]
      ,[SourceFileNameRaw]
      ,[AttachID]
      ,[MailMerge]
      ,[DateCreated]
  FROM [babblefish].[dbo].[ATTACHMENT_WAS_IS]
  WHERE [SOURCEFILENAME] LIKE('%Mario%') OR SOURCEFILENAME LIKE('%Fancey%')