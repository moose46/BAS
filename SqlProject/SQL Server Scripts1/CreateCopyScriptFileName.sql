-- get the current audit_num from the attachment_template_import table
-- returns 2015_1_17   year_quarter_audit_num
-- 3/16/2020 removed run_id
-- added AT rwc 3/19/2020
USE babblefish
GO

SELECT
	CONCAT(DATEPART(YEAR, ati.ATTACHDATE), '_', DATEPART(QUARTER, ati.ATTACHDATE),'_', IIF(awi.MailMerge = 1,'MM', 'AT'))
FROM ATTACHMENT_CSV ati
INNER JOIN ATTACHMENT_WAS_IS awi ON ati.ATTACHID = awi.AttachID
GROUP BY DATEPART(YEAR, ati.ATTACHDATE)
		,DATEPART(QUARTER, ati.ATTACHDATE)
		,ati.run_id
		,awi.MailMerge