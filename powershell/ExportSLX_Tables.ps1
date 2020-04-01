

###############################################################
#                CRM
# R. W. Curtiss 3/2/2020 me@robertcurtiss.com
###############################################################

Set-Variable -Name EXPORT_PATH -Value 'p:\bcurtiss\export\'
Set-Variable -Name EXPORT_DB -Value "BAS_SLX_83"

#Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell'
#Set-Variable -Name EXPORT_DB -Value babblefish

cd $EXPORT_PATH

#=============== account

Set-Variable -Name TABLE_NAME -Value 'sysdba.ACCOUNT'
Set-Variable -Name FORMAT_NAME -value 'sysdba.ACCOUNT'
Set-Variable -Name BCP_FILE_NAME -Value 'ACCOUNT.bcp'
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ account_ext

Set-Variable -Name TABLE_NAME -Value 'sysdba.ACCOUNT_EXT' 
Set-Variable -Name BCP_FILE_NAME -Value 'sysdba.ACCOUNT_EXT.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNT_EXT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ product
Set-Variable -Name TABLE_NAME -Value 'sysdba.PRODUCT'
Set-Variable -Name FORMAT_NAME -value 'sysdba.PRODUCT_FORMAT'
Set-Variable -Name BCP_FILE_NAME -Value 'PRODUCT.bcp'
Set-Variable -Name FORMAT_FILE_NAME -value 'PRODUCT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ product_ext
Set-Variable -Name TABLE_NAME -Value 'sysdba.PRODUCT_EXT' 
Set-Variable -Name FORMAT_NAME -value 'sysdba.PRODUCT_EXT_FORMAT'
Set-Variable -Name BCP_FILE_NAME -Value 'PRODUCT_EXT.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'PRODUCT_EXT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ accountproduct
Set-Variable -Name TABLE_NAME -Value 'sysdba.ACCOUNTPRODUCT' 
Set-Variable -Name FORMAT_NAME -value 'sysdba.ACCOUNTPRODUCT_FORMAT'
Set-Variable -Name BCP_FILE_NAME -Value 'ACCOUNTPRODUCT.fmt' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNTPRODUCT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ accountproduct_ext
Set-Variable -Name TABLE_NAME -Value 'sysdba.ACCOUNTPRODUCT_EXT' 
Set-Variable -Name FORMAT_NAME -value 'sysdba.ACCOUNTPRODUCT_EXT_FORMAT'
Set-Variable -Name BCP_FILE_NAME -Value 'ACCOUNTPRODUCT_EXT.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ACCOUNTPRODUCT_EXT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ attachment
Set-Variable -Name TABLE_NAME -Value 'sysdba.ATTACHMENT' 
Set-Variable -Name BCP_FILE_NAME -Value 'ATTACHMENT.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ATTACHMENT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ history
Set-Variable -Name TABLE_NAME -Value 'sysdba.HISTORY' 
Set-Variable -Name BCP_FILE_NAME -Value 'HISTORY.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'HISTORY.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ address
Set-Variable -Name TABLE_NAME -Value 'sysdba.ADDRESS' 
Set-Variable -Name BCP_FILE_NAME -Value 'ADDRESS.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ADDRESS.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM

#================ addressext
Set-Variable -Name TABLE_NAME -Value 'sysdba.ADDRESSEXT' 
Set-Variable -Name BCP_FILE_NAME -Value 'ADDRESSEXT.bcp' 
Set-Variable -Name FORMAT_FILE_NAME -value 'ADDRESSEXT.fmt'


bcp "$TABLE_NAME" out $BCP_FILE_NAME -T -d $EXPORT_DB -n -q -S CRM
bcp "$TABLE_NAME" format nul -T -d $EXPORT_DB -n -f $FORMAT_FILE_NAME -x -S CRM



#sqlcmd --% -S (local) -E -Q "select * from TABLE" -d babblefish

#sqlcmd --% -S CRM -E  -Q "select TABLE_NAME from BAS_SLX_83.information_schema.tables where table_type = 'BASE TABLE'"