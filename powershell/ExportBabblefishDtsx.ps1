#run as adminstrator

Clear-Host
Set-Location 'C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Binn'

Write-Host "Exporting NewCustomersCSV.csv ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\NewCustomersCSV' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "NewCustomersCSV Completed .... " -ForegroundColor Green

Write-Host "Exporting AR_CustomerTermsCode.csv ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\AR_CustomerTermsCodeCSV' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "AR_CustomerTermsCodeCSV Completed .... " -ForegroundColor Green


# C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy\SO_COOKED.csv
Write-Host "Exporting SO_Cooked.csv ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\SO_CookedCSV' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "SO_Cooked.csv Completed .... " -ForegroundColor Green

Write-Host "Exporting MissingSOCustomers.xlst ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\MissingSOCustomers' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "MissingSOCustomers.xlst Completed .... " -ForegroundColor Green

Write-Host "Exporting AllItemCodes.xlst ...." -ForegroundColor Yellow
.\DTExec.exe /DTS '\MSDB\AllItemCodes' /SERVER DAFFY-DUCK /CHECKPOINTING OFF
Write-Host "AllItemCodes.xlst Completed .... " -ForegroundColor Green


Write-Host "All Data Exported From BabbleFish .... " -BackgroundColor Green
