#sqlcmd --% -S CRM -E  -Q "select ATTACHMENT_WAS_IS from babblefish.information_schema.tables where table_type = 'BASE TABLE'"
#set BCP_EXPORT_SERVER=daffy-duck
Set-Variable -Name EXPORT_DB -Value 'babblefish'
Set-Variable -Name TABLE_NAME -Value 'ATTACHMENT_WAS_IS'
Set-Variable -Name EXPORT_HEADER_FILE_NAME  -Value 'ATTACHMENT_WAS_IS_HEADERS.csv'
Set-Variable -Name EXPORT_TXT_FILENAME -Value 'ATTACHMENT_WAS_IS.txt'
Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\'
Set-Variable -Name EXPORT_DATA_FILE_NAME -Value "ATTACHMENT_WAS_IS_EXPORT.csv"
cd $EXPORT_PATH
Write-Host $EXPORT_FILENAME
Write-Host $TABLE_NAME
#### get headers
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME -c -T 

##### Get data and save in txt file
bcp $TABLE_NAME out $EXPORT_TXT_FILENAME -d $EXPORT_DB -T -c -t ','


#### Combine both files
cat $EXPORT_HEADER_FILE_NAME,$EXPORT_TXT_FILENAME | sc $EXPORT_DATA_FILE_NAME

#### delete text file
del $EXPORT_TXT_FILENAME
#sqlcmd  -E  -Q "DECLARE @colnames VARCHAR(max);select @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.information_schema.COLUMNS where table_name = 'ATTACHMENT_WAS_IS';" > ATTACHMENT_WAS_IS_HEADERS.csv
