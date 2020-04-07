###############################################################
#                BABBLEFISH
# R. W. Curtiss 3/2/2020 me@robertcurtiss.com
###############################################################

Clear-Host
set-Variable -Name IMPORT_DB -Value babblefish

Set-Variable -Name IMPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_from_crm'
Set-Variable -Name IMPORT_DB -Value babblefish


cd $IMPORT_PATH

#================== account
Set-Variable -Name BCP_FILENAME -Value 'ACCOUNT.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'ACCOUNT'
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNT.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB

#================== account_ext

Set-Variable -Name BCP_FILENAME -Value 'ACCOUNT_EXT.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'ACCOUNT_EXT'
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNT_EXT.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB

#================= product

Set-Variable -Name BCP_FILENAME -Value 'PRODUCT.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'PRODUCT'
Set-Variable -Name FORMAT_FILE_NAME -value 'PRODUCT.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow

sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB

#================= ATTACHMENT

Set-Variable -Name BCP_FILENAME -Value 'ATTACHMENT.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'ATTACHMENT'
Set-Variable -Name FORMAT_FILE_NAME -value 'ATTACHMENT.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T -m 20000 -d $IMPORT_DB

#================= HISTORY

Set-Variable -Name BCP_FILENAME -Value 'HISTORY.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'HISTORY'
Set-Variable -Name FORMAT_FILE_NAME -value 'HISTORY.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB

#================= ADDRESS

Set-Variable -Name BCP_FILENAME -Value 'ADDRESS.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'ADDRESS'
Set-Variable -Name FORMAT_FILE_NAME -value 'ADDRESS.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB

#================= ADDRESS

Set-Variable -Name BCP_FILENAME -Value 'ADDRESSEXT.bcp'
Set-Variable -Name BABBLEFISH_TABLE_NAME -Value 'ADDRESSEXT'
Set-Variable -Name FORMAT_FILE_NAME -value 'ADDRESSEXT.fmt'

Write-Host "Refreshing $BABBLEFISH_TABLE_NAME Table ...." -ForegroundColor Yellow


sqlcmd  -E -Q "TRUNCATE TABLE $BABBLEFISH_TABLE_NAME"  -d $IMPORT_DB --% -S (local)
bcp $BABBLEFISH_TABLE_NAME in $BCP_FILENAME -f $FORMAT_FILE_NAME -T  -m 20000 -d $IMPORT_DB
