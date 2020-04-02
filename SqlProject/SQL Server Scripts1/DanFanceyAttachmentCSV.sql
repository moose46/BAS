/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ATTACHID]
      ,[EXTERNAL ID]
      ,[INTERNAL ID]
      ,[CASENUMBERREF]
      ,[TRANSACTIONHANDLE]
      ,[TITLE]
      ,[TYPEREF]
      ,[DIRECTIONREF]
      ,[MEMO]
      ,[FILENAME]
      ,[ATTACHDATE]
      ,[ATTACHTIME]
      ,[RUN_ID]
      ,[SOURCEFILENAME]
  FROM [babblefish].[dbo].[ATTACHMENT_CSV]
  WHERE [SourceFileName] LIKE ('%U6UJ9A000009 (05-31-2016 11%') 
  OR  [SourceFileName] LIKE ('%U6UJ9A000009 (03-27-2014 10%') 
  OR  [SourceFileName] LIKE ('%U6UJ9A000009 (04-12-2016 01%') 