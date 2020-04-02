/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000)
	[InvoiceNumber]
   ,format(sum([WorkedHours] * 65),'$###.00') as total
FROM [babblefish].[dbo].[Timesheets]
WHERE CheckNumber IS NULL
group by InvoiceNumber