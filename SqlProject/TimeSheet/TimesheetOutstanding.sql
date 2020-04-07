/****** Script for SelectTopNRows command from SSMS  ******/

USE babblefish
GO

SELECT TOP (1000)
	[InvoiceNumber]
   ,format(SUM([WorkedHours] * 65), '$###.00') AS total
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NULL
GROUP BY InvoiceNumber

SELECT
	format(SUM([WorkedHours] * 65), '$###.00') AS totalOustanding
FROM TimeSheets
WHERE CheckNumber IS NULL
