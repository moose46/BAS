/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT
--	format([InvoiceNumber],'000') AS [Invoice Number]
--	--,[WorkedDate]
--   ,format(CAST(SUM(WorkedHours) AS MONEY) * 65, '$###.00') AS Total
--FROM [babblefish].[dbo].[Timesheets]
--GROUP BY InvoiceNumber
--ORDER BY InvoiceNumber


UPDATE Timesheets
SET CheckNumber = 1890
WHERE InvoiceNumber = 1
UPDATE Timesheets
SET CheckNumber = 1890
WHERE InvoiceNumber = 2
UPDATE Timesheets
SET CheckNumber = 21339
WHERE InvoiceNumber = 3
UPDATE Timesheets
SET CheckNumber = 21339
WHERE InvoiceNumber = 4
UPDATE Timesheets
SET CheckNumber = 21388
WHERE InvoiceNumber = 5
UPDATE Timesheets
SET CheckNumber = 21594
WHERE InvoiceNumber = 6

UPDATE Timesheets
SET CheckNumber = 21594
WHERE InvoiceNumber = 7

UPDATE Timesheets
SET CheckNumber = 21529
WHERE InvoiceNumber = 8

UPDATE Timesheets
SET CheckNumber = 21594
WHERE InvoiceNumber = 9


SELECT
	format([InvoiceNumber], '000') AS [Invoice Number]
   ,CheckNumber AS [Check Number]
	--,[WorkedDate]
   ,format(CAST(SUM(WorkedHours) AS MONEY) * 65, '$###.00') AS [Amount Paid]
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NOT NULL
GROUP BY InvoiceNumber
		,CheckNumber
ORDER BY InvoiceNumber


SELECT
	format(CAST(SUM(WorkedHours) AS MONEY) * 65, '$###.00') AS [Total Amount Paid]
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NOT NULL


SELECT
	format([InvoiceNumber], '000') AS [Invoice Number]
   ,'XXXX' AS [Check Number]
   ,format(SUM([WorkedHours] * 65), '$###.00') AS [Amount Outstanding]
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NULL
GROUP BY InvoiceNumber


SELECT
	format(CAST(SUM(WorkedHours) AS MONEY) * 65, '$###.00') AS [Total Amount Outstanding]
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NULL

SELECT
	format(CAST(SUM(WorkedHours) AS MONEY) * 65, '$###.00') AS [Total Amount Earned]
FROM [babblefish].[dbo].[Timesheets]
