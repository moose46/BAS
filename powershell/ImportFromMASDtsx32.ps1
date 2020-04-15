
#run as adminstrator
Clear-Host
Write-Host "Refreshing Data from CRM MAS ....."

#cd C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_from_crm
Set-Location 'C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Binn'
Write-Host "Refreshing AR_Customer" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\AR_Customer_V1' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing AR_Customer Complete ...." -ForegroundColor Green

Write-Host "Refreshing SO_Header" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\SO_Header' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing SO_Header Complete ...." -ForegroundColor Green


Write-Host "Refreshing SO_Details" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\SO_Detail' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing SO_Details Complete ...." -ForegroundColor Green

Write-Host "Refreshing MAS AP_Vendor" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\Import_MAS_AP_Vendor' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing MAS AP_Vendor Complete ...." -ForegroundColor Green

Write-Host "Refreshing MAS Import_SO_ShipToAddress" -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\Import_SO_ShipToAddress' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing MAS Import_SO_ShipToAddress Complete ...." -ForegroundColor Green





Write-Host "All Tables From MAS Refreshed .... " -BackgroundColor Green

Write-Host "Refreshing Netsuite Tables .... " -ForegroundColor Green


Write-Host "Refreshing Netsuite Customers ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\NS_Customers' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing Netsuite Customers Completed " -ForegroundColor Green

Write-Host "Refreshing Netsuite Vendors ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\NS_Vendors' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "Refreshing Netsuite Vendors Completed " -ForegroundColor Green


Write-Host "Refreshing ALL Netsuite Tables Completed ... " -ForegroundColor Green

