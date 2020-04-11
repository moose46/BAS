cd C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy

 BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='SO_COOKED'; select @colnames;" queryout .\cooked_so_head.csv -c -T -t "," -d babblefish

 bcp "select * from babblefish.dbo.SO_COOKED" queryout cooked_so_tmp.csv -S daffy-duck -d babblefish -c -q  -T -t ","

 cat cooked_so_head.csv, cooked_so_tmp.csv | sc cooked_so.csv

 $cooked_data = Import-Csv cooked_so.csv

 del cooked_so_tmp.csv
 del cooked_so_head.csv
