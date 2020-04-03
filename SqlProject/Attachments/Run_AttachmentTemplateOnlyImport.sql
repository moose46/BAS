-- USE this script TO CREATE the csv file data to be attached to the copy script files
-- to be used with CreateCSV_ATTACHMENT_TEMPLATE_IMPORT.ps1
-- Modified 3/9/2020
-- create the attachment_was_is data to create the batch file load scripts
-- modified 3/10/2020 to incude zip file numbering for auditing


USE babblefish
GO
TRUNCATE TABLE ATTACHMENT_TEMPLATE_IMPORT
DECLARE @audit_num INT
SET @audit_num = NEXT VALUE FOR audit_zipfiles_seq

DECLARE @attachment_name VARCHAR(32)
SET @attachment_name = 'Mail Merge%'

INSERT INTO ATTACHMENT_TEMPLATE_IMPORT (ATTACHID, [External ID], [Internal ID], caseNumberRef, transactionHandle, title, typeRef, directionRef, memo, filename, ATTACHDATE, audit_num, SourceFileName)
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
	   ,'Mail Merge-' + a.ACCOUNTID + '-' + SUBSTRING(a.filename, CHARINDEX(')', a.filename) + 2, LEN(a.filename)) AS 'filename'
	   ,a.ATTACHDATE
	   ,@audit_num
	   ,a.filename -- Source FileName
	FROM ATTACHMENT a
	LEFT JOIN NSCustomers n
		ON n.[External ID] = a.ACCOUNTID
	WHERE filename LIKE @attachment_name
	AND DATEPART(YEAR, a.ATTACHDATE) = 2015
	AND DATEPART(QUARTER, a.ATTACHDATE) = 1
	)

TRUNCATE TABLE ATTACHMENT_WAS_IS

-- Create was is file to be used to create copy batch files
INSERT INTO ATTACHMENT_WAS_IS (SourceFileName, TargetFileName, ExternalId, InternalId, audit_num, SourceFileNameRaw, AttachID)
	(SELECT
		REPLACE(REPLACE(a.filename, 'doc ', 'doc'), 'Mail Merge', '')
	   ,a.ACCOUNTID + '-' + SUBSTRING(filename, CHARINDEX(')', filename) + 2, LEN(filename))
	   ,a.ACCOUNTID
	   ,n.[Internal ID]
	   ,@audit_num
	   ,a.filename -- Source FileName Raw
	   ,a.ATTACHid
	FROM ATTACHMENT a
	LEFT JOIN NSCustomers n
		ON n.[External ID] = a.ACCOUNTID
	WHERE filename LIKE @attachment_name
	AND DATEPART(YEAR, a.ATTACHDATE) = 2015
	AND DATEPART(QUARTER, a.ATTACHDATE) = 1
	)

-- create an audit of this batch 
INSERT INTO AUDIT_ZIPFILES (audit_num, SourcePath, TargetPath, SourceFileName, TargetFileName, InternalId, ExternalId, ATTACHID)
	(SELECT
		awi.audit_num
	   ,awi.SourcePath
	   ,awi.TargetPath
	   ,awi.SourceFileName
	   ,ati.filename
	   ,awi.InternalId
	   ,awi.ExternalId
	   ,awi.ATTACHID
	FROM ATTACHMENT_TEMPLATE_IMPORT ati
		,ATTACHMENT_WAS_IS awi

	WHERE ati.SourceFileName = awi.SourceFileNameRaw
	)
	--SELECT @audit_num
