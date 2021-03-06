﻿Param(
    [Parameter(Mandatory = $true,
        HelpMessage = "You must provide a year")]
    [int]$year,
    [Parameter(Mandatory = $true,
        HelpMessage = "You must provide a quarter")]
    [int]$quarter

)
# Change the name of sql command to process mail merge attachments
sqlcmd -d babblefish -o error.log -E  -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\ProcessAttachmentsMailMerge.sql" -v p_year=$year p_quarter=$quarter --% -S daffY-duck

Set-Variable -Name EXPORT_DB -Value 'babblefish'
Set-Variable -Name TABLE_NAME -Value 'ATTACHMENT_CSV'
Set-Variable -Name EXPORT_HEADER_FILE_NAME  -Value 'ATTACHMENT_CSV_HEADERS.csv'
Set-Variable -Name EXPORT_TXT_FILENAME -Value 'ATTACHMENT_CSV.txt'
Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_to_crm\MM\'
if (!(Test-Path $EXPORT_PATH)) {New-Item -ItemType Directory -Force -Path $EXPORT_PATH} 
Set-Location $EXPORT_PATH
#Write-Host $EXPORT_PATH
[string[]]$Filename = sqlcmd -d babblefish --% -S daffy-duck -E -h -1 -k1 -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\CreateCopyScriptFileName.sql"
#write-host $Filename

#$EXPORT_DATA_FILE_NAME = $filename[1].Replace(' ', '')
$EXPORT_DATA_FILE_NAME = -join([string]$year, '_') + -join([string]$quarter, '_MM')
#$EXPORT_DATA_FILE_NAME = -join([string]$quarter, '_MM')
if($EXPORT_DATA_FILE_NAME.Length -eq 0) { # no data found for this year and quarter
    Write-Host "Skipping, bad $year / $quarter"
    return
}
$EXPORT_DATA_FILE_NAME = -join ([string]$EXPORT_DATA_FILE_NAME, '.csv')
$EXPORT_DATA_FILE_NAME = -join ([string]$EXPORT_PATH, [string]$EXPORT_DATA_FILE_NAME)


#sqlcmd -d babblefish --% -S daffY-duck -E  -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\Attachment_MM_params.sql" -v p_year='1/1/2017'

if (Test-Path $EXPORT_DATA_FILE_NAME) { Remove-Item $EXPORT_DATA_FILE_NAME }

#### get headers
#Clear-Host
$shortName = [System.IO.Path]::GetFileName($EXPORT_DATA_FILE_NAME)

Write-Host "Creating $EXPORT_DATA_FILE_NAME Headers ..." -foreground Magenta
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from $EXPORT_DB.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='$TABLE_NAME'; select @colnames;" queryout $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME -c -T >> .\mylog.log

##### Get data and save in txt file
#Clear-Host
Write-Host "Fetching AttachmentData ..." -ForegroundColor Yellow
bcp "select attachid, [external id], [internal id], caseNumberref, transactionHandle,title,typeRef, directionRef, memo, filename, attachdate, attachtime,run_id from babblefish.dbo.ATTACHMENT_CSV;" queryout $EXPORT_PATH\$EXPORT_TXT_FILENAME -d $EXPORT_DB -T -c -t ',' >> .\mylog.log


#### Combine both files
Get-Content $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME, $EXPORT_PATH\$EXPORT_TXT_FILENAME | sc $EXPORT_DATA_FILE_NAME

#### delete text file
#Remove-Item $EXPORT_TXT_FILENAME
#Remove-Item $EXPORT_PATH\$EXPORT_HEADER_FILE_NAME
#sqlcmd  -E  -Q "DECLARE @colnames VARCHAR(max);select @colnames = COALESCE(@colnames + ',', '') + column_name from babblefish.information_schema.COLUMNS where table_name = 'ATTACHMENT_TEMPLATE_IMPORT';" > ATTACHMENT_TEMPLATE_IMPORT_HEADERS.csv
Clear-Host
Write-Output "Creating ... $shortName"
#cd "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\"
PowerShell -Command C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\CreateCopyScripts.ps1 -FILE_TYPE MM -YEAR $year
#remove-item $EXPORT_PATH\*.csv
