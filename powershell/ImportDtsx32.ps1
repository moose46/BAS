
#run as adminstrator
Clear-Host
Write-Host "Refreshing Data from CRM MAS ....."

#cd C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_from_crm
Set-Location 'C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Binn'
Write-Host "Refreshing AR_Customer" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\AR_Customer' /SERVER DAFFY-DUCK /CHECKPOINTING OFF



Write-Host "All Tables From MAS Refreshed .... " -BackgroundColor Green


