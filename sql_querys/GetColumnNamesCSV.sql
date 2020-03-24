
USE babblefish
GO
DECLARE @colnames VARCHAR(MAX)

SELECT
	@colnames = COALESCE(@colnames + ',', '') + COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ATTACHMENT'
SELECT @colnames

USE babblefish
GO
DECLARE @colnames VARCHAR(MAX)

SELECT ',' +  '''?'' as [' + COLUMN_NAME + ']'
	--@colnames -- = COALESCE(@colnames + ',', '') + COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderTemplate'
SELECT @colnames
