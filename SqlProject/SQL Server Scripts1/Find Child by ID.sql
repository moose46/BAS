/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[pid]
      ,[internalId]
      ,[externalId]
  FROM [master].[dbo].[MatchManyQ3] WHERE ID like '110152%' -- this is the id field in NSuite
  -- the dashes are the children and the pid is the parent
  -- and parent record has a pid of -1