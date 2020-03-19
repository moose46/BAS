-- USE this script TO CREATE the csv file data to be attached to the copy script files
-- to be used with CreateCSV_ATTACHMENT_CSV.ps1
-- Modified 3/9/2020
-- create the attachment_was_is data to create the batch file load scripts
-- modified 3/10/2020 to incude zip file numbering for auditing
-- renamed sql script to ATTACHMENT_CSV from ATTACHMENT_TEMPLATE_IMPORT 3/11/2020 
-- currently nailed up to 2015 1st quarter 1

USE babblefish
GO
TRUNCATE TABLE ATTACHMENT_CSV
TRUNCATE TABLE ATTACHMENT_WAS_IS
TRUNCATE TABLE AUDIT_ZIPFILES -- REMOVE after production run

DECLARE @run_id INT
SET @run_id = NEXT VALUE FOR audit_zipfiles_seq
-------------------------------------------------
DECLARE @AttachmentYear DATETIME
SET @AttachmentYear = '1/1/2015'
SET @AttachmentYear = DATEADD(YEAR, 1, @AttachmentYear)
----------------------------------------------------
DECLARE @AttachmentQuarter INT
SET @AttachmentQuarter = 1
---------------------------------------------------
DECLARE @attachment_name VARCHAR(32)
SET @attachment_name = 'Mail Merge%'


INSERT INTO ATTACHMENT_CSV (ATTACHID, [External ID], [Internal ID], caseNumberRef, transactionHandle, title, typeRef, directionRef, memo, FILENAME, ATTACHDATE, ATTACHTIME, run_id, SOURCEFILENAME)
	(SELECT
		a.ATTACHID
	   ,n.[External ID]
	   ,n.[Internal ID] 'Internal ID'
	   ,'' AS 'caseNumberRef'
	   ,'' AS 'transactionHandle'
	   ,a.DESCRIPTION AS 'title'
	   ,'' AS 'typeRef'
	   ,'' AS 'directionRef'
	   ,a.DESCRIPTION AS 'memo'
	   ,a.ACCOUNTID + '-' + SUBSTRING(a.filename, CHARINDEX(')', a.filename) + 2, LEN(a.filename)) AS 'NS_FILENAME'
	   ,CONVERT(DATE, a.ATTACHDATE) AS 'ATTACHDATE'
	   ,CONVERT(TIME, a.ATTACHDATE) AS 'ATTACHTIME'
	   ,@run_id
	   ,a.filename as 'SOURCEFILENAME'
	FROM ATTACHMENT a
	LEFT JOIN NSCUSTOMERS n
		ON n.[External ID] = a.ACCOUNTID
	WHERE filename LIKE @attachment_name
	AND DATEPART(YEAR, a.ATTACHDATE) = DATEPART(YEAR, @AttachmentYear)
	AND DATEPART(QUARTER, a.ATTACHDATE) = @AttachmentQuarter
	)


-- Create was is file to be used to create copy batch files
INSERT INTO ATTACHMENT_WAS_IS (SourceFileName, TargetFileName, ExternalId, InternalId, run_id, SourceFileNameRaw, ATTACHID)
	(SELECT
		REPLACE(REPLACE(a.FILENAME, 'doc ', 'doc'), 'Mail Merge', '')
	   ,a.ACCOUNTID + '-' + SUBSTRING(FILENAME, CHARINDEX(')', FILENAME) + 2, LEN(FILENAME))
	   ,a.ACCOUNTID
	   ,n.[Internal ID]
	   ,@run_id
	   ,a.FILENAME -- Source FileName Raw
	   ,a.ATTACHID
	FROM ATTACHMENT a
	LEFT JOIN NSCUSTOMERS n
		ON n.[External ID] = a.ACCOUNTID
	WHERE FILENAME LIKE @attachment_name
	AND DATEPART(YEAR, a.ATTACHDATE) = DATEPART(YEAR, @AttachmentYear)
	AND DATEPART(QUARTER, a.ATTACHDATE) = @AttachmentQuarter
	)

-- create an audit of this batch 
INSERT INTO AUDIT_ZIPFILES (run_id, SourcePath, TargetPath, SourceFileName, TargetFileName, InternalId, ExternalId, ATTACHID)
	(SELECT
		awi.run_id
	   ,awi.SourcePath
	   ,awi.TargetPath
	   ,awi.SourceFileName
	   ,ati.FILENAME
	   ,awi.InternalId
	   ,awi.ExternalId
	   ,awi.ATTACHID
	FROM ATTACHMENT_CSV ati
		,ATTACHMENT_WAS_IS awi

	WHERE ati.SourceFileName = awi.SourceFileNameRaw
	)
--SELECT @run_id

SELECT
	current_value
FROM sys.sequences s
WHERE Name = 'audit_zipfiles_seq'