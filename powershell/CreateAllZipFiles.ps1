# this file invokes CreateCSV_ATTACHMENT_??_params.ps1 for all years and quarters
# or just by mail merge, and just attachments, or both
# menu lets you decide your action

function Invoke-Mail-Merge() {
  #Write-Host $Myselection
  Set-Variable -Name POWERSHELL_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell'
  Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\'
  Set-Variable -Name ERROR_FILENAME -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\error.log'
  Set-Variable -Name PROCESS_ALL_FILES -Value '.\ProcessAllFiles.ps1'

  #Change directorys
  Set-Location $POWERSHELL_PATH

  if (Test-Path $ERROR_FILENAME) { Remove-Item $ERROR_FILENAME }
  # Loop through all years and quarters
  for ($year = 2015; $year -lt 2021; $year++) {
    for ($quarter = 1; $quarter -lt 2; $quarter++) {
      Clear-Host
      Write-Host "Processing...." $year $quarter -foreground Green
      Powershell -Command "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\CreateCSV_ATTACHMENT_MM_params.ps1 $year $quarter"
    }
  }

  Set-Location $EXPORT_PATH
  if (Test-Path $PROCESS_ALL_FILES) { Remove-Item $PROCESS_ALL_FILES }

  "Set-Variable -Name ATTACHMENTS -Value 'E:\NETSUITE ATTACHMENTS\'" > $PROCESS_ALL_FILES

  "cd 'e:\netsuite attachments'" >> $PROCESS_ALL_FILES
  "if (Test-Path 'e:\netsuite attachments\myerror.log') {Remove-Item myerror.log}" >> $PROCESS_ALL_FILES
  Get-ChildItem *.ps1 | foreach-Object {
    if ($_.Name -notcontains "ProcessAllFiles.ps1") {
      #Write-Host $_.Name -ForegroundColor Green
      'PowerShell -Command .\' + $_.Name + ' 2>>myerror.log' >> $PROCESS_ALL_FILES
    }
  }
}
function Invoke-Attachments() {
  #Write-Host $Myselection
  Set-Variable -Name POWERSHELL_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell'
  Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\'
  Set-Variable -Name ERROR_FILENAME -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\error.log'
  Set-Variable -Name PROCESS_ALL_FILES -Value '.\ProcessAllFiles.ps1'

  #Change directorys
  Set-Location $POWERSHELL_PATH

  if (Test-Path $ERROR_FILENAME) { Remove-Item $ERROR_FILENAME }
  # Loop through all years and quarters
  for ($year = 2015; $year -lt 2021; $year++) {
    for ($quarter = 1; $quarter -lt 5; $quarter++) {
      Clear-Host
      Write-Host "Processing...." $year $quarter -foreground Green
      Powershell -Command "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell\CreateCSV_ATTACHMENT_AT_params.ps1 $year $quarter"
    }
  }

  Set-Location $EXPORT_PATH
  if (Test-Path $PROCESS_ALL_FILES) { Remove-Item $PROCESS_ALL_FILES }

  "Set-Variable -Name ATTACHMENTS -Value 'E:\NETSUITE ATTACHMENTS\'" > $PROCESS_ALL_FILES

  "cd 'e:\netsuite attachments'" >> $PROCESS_ALL_FILES
  "if (Test-Path 'e:\netsuite attachments\myerror.log') {Remove-Item myerror.log}" >> $PROCESS_ALL_FILES
  Get-ChildItem *.ps1 | foreach-Object {
    if ($_.Name -notcontains "ProcessAllFiles.ps1") {
      #Write-Host $_.Name -ForegroundColor Green
      'PowerShell -Command .\' + $_.Name + ' 2>>myerror.log' >> $PROCESS_ALL_FILES
    }
  }
}

function Invoke-Both()
{
  Write-Host "Mail Merge ..."
  Invoke-Mail-Merge
  Clear-Host
  Write-Host "Attachments ..."
  Invoke-Attachments
}
function Invoke-Selection {
  Param(
    [parameter(Mandatory = $true, position = 0, ParameterSetName = 'Selection')]
    [string[]]$Myselection
  )
  begin {
    switch ($Myselection) {
      '1' { 
        Invoke-Mail-Merge
      } '2'{
        Invoke-Attachments
      } '3' {
        Invoke-Both
      }
      Default { }
    }
  }
  end
  { }
}


function Show-Menu {
  param([string]$option = 'Menu')
  Clear-Host
  Write-Host "============= Create Zip and Csv Files ================"
  Write-Host "1: Press 1 for Mail Merge Only"
  Write-Host "2: Press 2 for Attachments Only"
  Write-Host "3: Press 3 for Both"
  Write-Host "Q: Press Q to Quit"
}
do {
  Show-Menu
  $input = Read-Host "Please make a selection"
  switch ($input) {
    '1' {
      Clear-Host
      Write-Host 'Mail Merge Only' -ForegroundColor Green
      Invoke-Selection('1')
    } '2' {
      Clear-Host
      Write-Host 'Attachments Only' -ForegroundColor red
      Invoke-Selection('2')
    } '3' {
      Clear-Host
      Write-Host 'Both Attachments and Mail Merge' -ForegroundColor yellow
      Invoke-Selection('3')
    } 'q' {
      return
    }
  }
}
until ($input -eq 'q')


Set-Variable -Name POWERSHELL_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\powershell'
Set-Variable -Name EXPORT_PATH -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\'
Set-Variable -Name ERROR_FILENAME -Value 'C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\crm\data_to_crm\error.log'
Set-Variable -Name PROCESS_ALL_FILES -Value '.\ProcessAllFiles.ps1'

#Change directorys
Set-Location $POWERSHELL_PATH

if (Test-Path $ERROR_FILENAME) { Remove-Item $ERROR_FILENAME }

