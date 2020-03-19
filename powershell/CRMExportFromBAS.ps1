Set-Variable -Name EXPORT_DB -Value BAS_SLX_83

Set-Variable -Name EXPORT_PATH -Value 'p:\bcurtiss\export\'

cd P:\BCurtiss\export

Set-Variable -Name TABLE_NAME -Value 'ACCOUNT'

BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [$EXPORT_DB].[sysdba].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv


#================ account_ext

Set-Variable -Name TABLE_NAME -Value 'ACCOUNT_EXT'
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [$EXPORT_DB].[sysdba].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv
del $EXPORT_PATH\tmp.txt
del $EXPORT_PATH\HeadersOnly.csv

#================ product
Set-Variable -Name TABLE_NAME -Value 'PRODUCT'
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [$EXPORT_DB].[sysdba].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv

#=============== product_ext
Set-Variable -Name TABLE_NAME -Value 'PRODUCT_EXT'
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\HeadersOnly.csv -c -T -t ","

bcp "select * from [$EXPORT_DB].[sysdba].[$TABLE_NAME]" queryout $EXPORT_PATH\tmp.txt -T -t "," -c

cat  $EXPORT_PATH\HeadersOnly.csv, $EXPORT_PATH\tmp.txt | sc $EXPORT_PATH\$TABLE_NAME.csv


del $EXPORT_PATH\tmp.txt
del $EXPORT_PATH\HeadersOnly.csv
