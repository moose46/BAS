set BCP_EXPORT_SERVER=daffy-duck
set BCP_EXPORT_DB=[babblefish]
set BCP_EXPORT_TABLE=[TERMS_MAP]

Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\'


Set-Variable -Name TABLE_NAME -Value 'TERMS_MAP'

BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $BCP_EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [babblefish].[dbo].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv


================ Q1DATA

Set-Variable -Name TABLE_NAME -Value 'Q1DATA'
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $BCP_EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [babblefish].[dbo].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv
del $EXPORT_PATH\tmp.txt
del $EXPORT_PATH\HeadersOnly.csv

================ Q2DATA
Set-Variable -Name TABLE_NAME -Value 'Q2DATA'
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $BCP_EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [babblefish].[dbo].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv
del $EXPORT_PATH\tmp.txt
del $EXPORT_PATH\HeadersOnly.csv

#sqlcmd --% -S (local) -E -Q "select customername from Q1DATA" -d babblefish

