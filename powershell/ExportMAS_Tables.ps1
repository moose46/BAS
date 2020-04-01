#this script must be run in 32bit powershell

cd P:\BCurtiss\export

Clear-Host
Write-Host "Connecting to SOTAMAS90_silent...."

$ConnectionString = "DSN=SOTAMAS90_silent;"
$conn = New-Object System.Data.Odbc.OdbcConnection($ConnectionString)
$conn.Open()
#Export-Csv -Delimiter

function Export-TablesToCSV($tableName) {
        $query = "select * from $tableName"
        $cmd = New-object System.Data.Odbc.OdbcCommand($query, $conn)
        $ds = New-Object System.Data.DataSet
        (New-Object System.Data.Odbc.OdbcDataAdapter($cmd)).fill($ds) | Out-Null

        Write-Host "Creating $tableName Header ...." -ForegroundColor Red
        $header = $ds.Tables[0].Columns -join "|"

        $cols = $ds.Tables[0].Columns.Count
        $filename = "$tableName.csv"

        if(Test-Path $filename) { Clear-Content $filename}
        Add-Content $filename $header
        Write-Host "Exporting $tableName Data ...." -ForegroundColor Yellow

        for ($i = 0; $i -lt $ds.Tables[0].Rows.Count; $i++) {
            $rowData = ""
            for ($j = 0; $j -lt $cols; $j++) {
                $rowData = $rowData + "$($ds.Tables[0].Rows[$i][$j])|"
            }

            Add-Content  $filename $rowData
        }
        Write-Host "$filename Created ...." -ForegroundColor Green

 
}
Export-TablesToCSV AR_Customer
Export-TablesToCSV PO_PurchaseOrderHeader
Export-TablesToCSV PO_PurchaseOrderDetail
Export-TablesToCSV SO_SalesOrderHeader
Export-TablesToCSV SO_SalesOrderDetail

Write-Host "All Tables Exported From SOTAMAS90_silent...."
#[System.Environment]::Is64BitProcess
