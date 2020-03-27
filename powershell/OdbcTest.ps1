#run this script using 32bit powershell
# C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell_ise.exe
#DSN=SOTAMAS90;Description=MAS 90 4.0 ODBC Driver;Directory=D:\Sage\Sage 100 Advanced 2018\MAS90;Prefix=D:\Sage\Sage 100 Advanced 2018\MAS90\SY\, D:\Sage\Sage 100 Advanced 2018\MAS90\==\;ViewDLL=D:\Sage\Sage 100 Advanced 2018\MAS90\Home\;RemotePVKIOHost=MAS;RemotePVKIOPort=20222;CacheSize=4;DirtyReads=1;BurstMode=1;StripTrailingSpaces=1;SERVER=NotTheServer
#Get-OdbcDriver
#[System.Environment]::Is64BitProcess
$ConnectionString ="DSN=SOTAMAS90_silent;"

$conn = New-Object System.Data.Odbc.OdbcConnection($ConnectionString)


$conn.open()

$query = "select * from SO_SalesOrderHeader"
#$query = "select * from SY_Company"
$cmd = New-object System.Data.Odbc.OdbcCommand($query,$conn)
$ds = New-Object System.Data.DataSet
(New-Object System.Data.Odbc.OdbcDataAdapter($cmd)).fill($ds) | out-null

#$ds.Tables
$ds.Tables[0].Rows.Count
for($i=0;$i -lt $ds.Tables[0].Rows.Count;$i++)
{
    Write-Host "Value is : $($ds.Tables[0].Rows[$i][0])"
}

$conn.Close()
#try {
#    if(($conn.open()) -eq $true){
#        $conn.Close()
#        $true
#    } else
#    {
#        $false
#    }
#} catch {
#     Write-Host $_.Exception.Message
#}

