
Set-Variable -Name EXPORT_DB -Value 'babblefish'
Set-Variable -Name TABLE_NAME -Value 'ATTACHMENT_CSV'
Set-Variable -Name EXPORT_HEADER_FILE_NAME  -Value 'ATTACHMENT_CSV_HEADERS.csv'
Set-Variable -Name EXPORT_TXT_FILENAME -Value 'ATTACHMENT_CSV.txt'
Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\'
cd $EXPORT_PATH

[string[]]$Filename = sqlcmd -d babblefish --% -S daffy-duck -E -h -1 -k1 -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\CreateCopyScriptFileName.sql"
$EXPORT_DATA_FILE_NAME = $filename[1].Replace(' ','')
$EXPORT_DATA_FILE_NAME = -join([string]$EXPORT_DATA_FILE_NAME, '.csv')
$EXPORT_DATA_FILE_NAME = -join([string]$EXPORT_PATH, [string]$EXPORT_DATA_FILE_NAME)

if (Test-Path $EXPORT_DATA_FILE_NAME) { del $EXPORT_DATA_FILE_NAME }

#### get headers
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME -c -T 

##### Get data and save in txt file
bcp "select attachid, [external id], [internal id], caseNumberref, transactionHandle,title,typeRef, directionRef, memo, filename, attachdate, attachtime,run_id from babblefish.dbo.ATTACHMENT_CSV;" queryout $EXPORT_TXT_FILENAME -d $EXPORT_DB -T -c -t ','


#### Combine both files
cat $EXPORT_HEADER_FILE_NAME,$EXPORT_TXT_FILENAME | sc $EXPORT_DATA_FILE_NAME

#### delete text file
del $EXPORT_TXT_FILENAME
del $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME
#sqlcmd  -E  -Q "DECLARE @colnames VARCHAR(max);select @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.information_schema.COLUMNS where table_name = 'ATTACHMENT_TEMPLATE_IMPORT';" > ATTACHMENT_TEMPLATE_IMPORT_HEADERS.csv
Write-Output "############################ Created ############################ " $EXPORT_DATA_FILE_NAME
