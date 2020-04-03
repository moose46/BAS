USE babblefish
GO

SELECT
	COUNT(*)
   ,SUM(CONVERT(BIGINT, FILESIZE)) / POWER(10, 9)
   ,COUNT(*) / 5000
FROM ATTACHMENT
WHERE ATTACHDATE > '1/1/2015'
