#sqlcmd --% -S CRM -E  -Q "select ATTACHMENT_TEMPLATE_IMPORT from babblefish.information_schema.tables where table_type = 'BASE TABLE'"
#set BCP_EXPORT_SERVER=daffy-duck

#Template file
# setup run this first
# C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\querys\Breating Air Solutions (Daffy-Duck)\Breating Air Solutions (Daffy-Duck)\CreateAttachmentTemplateOnlyImport.sql
# this produces ATTACHMENT_TEMPLATE_IMPORT_EXPORT.csv file

Set-Variable -Name EXPORT_DB -Value 'babblefish'
Set-Variable -Name TABLE_NAME -Value 'ATTACHMENT_TEMPLATE_IMPORT'
Set-Variable -Name EXPORT_HEADER_FILE_NAME  -Value 'ATTACHMENT_TEMPLATE_IMPORT_HEADERS.csv'
Set-Variable -Name EXPORT_TXT_FILENAME -Value 'ATTACHMENT_TEMPLATE_IMPORT.txt'
Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\ZipFileScripts'
#rename the export file to year-quarter-audit_num.csv'
Set-Variable -Name EXPORT_DATA_FILE_NAME -Value "2015-1-17.csv"
cd $EXPORT_PATH
Write-Host $EXPORT_FILENAME
Write-Host $TABLE_NAME

[string[]]$Filename = sqlcmd -d babblefish --% -S daffy-duck -E -h -1 -k1 -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\querys\Breating Air Solutions (Daffy-Duck)\Breating Air Solutions (Daffy-Duck)\CreateCopyScriptFileName.sql"
$EXPORT_FILENAME = $filename[1].Replace(' ','')
$EXPORT_FILENAME = -join([string]$EXPORT_FILENAME, '.ps1')
$EXPORT_FILENAME = -join([string]$EXPORT_PATH, [string]$EXPORT_FILENAME)



#### get headers
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME -c -T 

##### Get data and save in txt file
bcp $TABLE_NAME out $EXPORT_TXT_FILENAME -d $EXPORT_DB -T -c -t ','


#### Combine both files
cat $EXPORT_HEADER_FILE_NAME,$EXPORT_TXT_FILENAME | sc $EXPORT_DATA_FILE_NAME

#### delete text file
del $EXPORT_TXT_FILENAME
del $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME
#sqlcmd  -E  -Q "DECLARE @colnames VARCHAR(max);select @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.information_schema.COLUMNS where table_name = 'ATTACHMENT_TEMPLATE_IMPORT';" > ATTACHMENT_TEMPLATE_IMPORT_HEADERS.csv
