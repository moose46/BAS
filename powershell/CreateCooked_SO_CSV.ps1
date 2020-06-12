cd C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy

# output_filename added 6/12/2020 for Kathy testing
$OUTPUT_FILENAME = 'cooked_so-69520-70075.csv'
$OUTPUT_FILENAME = 'cooked_so.csv'

 BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='SO_COOKED'; select @colnames;" queryout .\cooked_so_head.csv -c -T -t "," -d babblefish

 bcp "select * from babblefish.dbo.SO_COOKED" queryout cooked_so_tmp.csv -S daffy-duck -d babblefish -c -q  -T -t ","

 cat cooked_so_head.csv, cooked_so_tmp.csv | sc $OUTPUT_FILENAME

 $cooked_data = Import-Csv $OUTPUT_FILENAME

 del cooked_so_tmp.csv
 del cooked_so_head.csv
