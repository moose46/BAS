/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	[MAS]
FROM [babblefish].[dbo].[ITEMCODE_MAS_NS]
GROUP BY MAS
HAVING COUNT(MAS) > 1