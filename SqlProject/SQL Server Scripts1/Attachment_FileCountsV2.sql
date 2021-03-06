SELECT
	DATEPART(YEAR, a.ATTACHDATE) AS year
   ,DATEPART(QUARTER, a.ATTACHDATE) AS quarter
   ,a.filename,
   a.ATTACHID INTO ZIP_FILE_LIST
FROM ATTACHMENT a 
WHERE a.ATTACHDATE >= '1/1/2015'
GROUP BY DATEPART(YEAR, a.ATTACHDATE)
		,DATEPART(QUARTER, a.ATTACHDATE)
		,a.FILENAME
		,a.ATTACHID