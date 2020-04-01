cd C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy

 BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='COOKED_SO'; select @colnames;" queryout .\cooked_so_head.csv -c -T -t "," -d babblefish

 bcp "select * from babblefish.dbo.COOKED_SO" queryout cooked_so.csv -S daffy-duck -d babblefish -c -q  -T -t ","

 cat cooked_so_head.csv, cooked_so.csv | sc cooked_so_final.csv

 $cooked_data = Import-Csv cooked_so_final.csv

