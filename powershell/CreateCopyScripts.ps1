# Modified 3/9/2020 to include running 
# 3/19/2020
# 4/1/2020 changed directorys for output and sql script names to Process????
# used by CreateCSV_ATTACHMENT_??_params.ps1 to create script file to be run on CRM to create attactment zip files

Set-Variable -Name EXPORT_PATH -Value "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_to_crm\Attachments\"
Set-Variable -Name SQL_STATEMENT -Value "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\CreateTable_ATTACHMENT_CSV.sql"

# set the file name to year-quarter audit_num.ps1, get the last audit_num from attachment_template_import
[string[]]$Filename = sqlcmd -d babblefish --% -S daffy-duck -E -h -1 -k1 -i "C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\sql_querys\CreateCopyScriptFileName.sql"
$ExecutableFileName = $filename[1].Replace(' ', '')
$LOG_FILENAME = -join ([string]$ExecutableFileName, '.log')
$ZipFileName = -join ([string]$ExecutableFileName, '.zip')
$ExecutableFileName = -join ([string]$ExecutableFileName, '.ps1')
$ExecutableFileName = -join ([string]$EXPORT_PATH, [string]$ExecutableFileName)
$compressionLevel = '$compressionLevel'
$Myfalse = '$false'
Set-Location $EXPORT_PATH

if (Test-Path $ExecutableFileName) { Remove-Item $ExecutableFileName }
if (Test-Path $ZipFileName) { Remove-Item $ZipFileName }
"Add-Type -AssemblyName System.IO.Compression.FileSystem" >> $ExecutableFileName
"$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal" >> $ExecutableFileName

"Remove-Item -path  'e:\netsuite attachments\test\*' -Recurse" >> $ExecutableFileName
"if (Test-Path 'e:\netsuite attachments\$ZipFileName') {Remove-Item $ZipFileName}" >> $ExecutableFileName


#run sql to create new attachment , get filenames from the attachment_csv table

[string[]]$SourceFileNames = sqlcmd -d babblefish --% -S daffY-duck -E  -Q "select SourceFileName,',', TargetFileName from attachment_was_is"
Clear-Host
$shortName = [System.IO.Path]::GetFileName($ExecutableFileName)
Write-Host "Processing $shortName file..." -ForegroundColor red

if ($ExecutableFileName.Contains('MM')) {
    foreach ($c in $SourceFileNames) {
        $i = $c.Replace('\r', ' ').Replace('\n', '')
        #$x = $i.Split(',',2,$options)
        $from = $i -split ','
        #$from[0]
        #$from[1]
        $in = $from[0].Trim()
        #$in = $in.Replace('doc ','doc')
        #$to = $from[1].Replace(' ','')
        if ($from[0].Contains('\')) { 
            if ($from[1].Length -gt 0) { }
            $cmd = -join ("Copy-Item -Path `"E:\SalesLogixLan\SlxLanDocuments\Mail Merge", $in) + -join ("`" -Destination `"E:\NETSUITE ATTACHMENTS\test\") + -join ($from[1].Trim(), "`" -Recurse -Force") 
            $cmd  >> $ExecutableFileName
        }
    }
}

else {
    foreach ($c in $SourceFileNames) {
        $i = $c.Replace('\r', ' ').Replace('\n', '')
        #$x = $i.Split(',',2,$options)
        $from = $i -split ','
        #$from[0]
        #$from[1]
        $in = $from[0].Trim()
        #$in = $in.Replace('doc ','doc')
        #$to = $from[1].Replace(' ','')
        try {
            if ($from[1].Length -gt 0) {
                $cmd = -join ("Copy-Item -Path `"E:\SalesLogixLan\SlxLanDocuments\", $in) + -join ("`" -Destination `"E:\NETSUITE ATTACHMENTS\test\") + -join ($from[1].Trim(), "`" -Recurse -Force") 
                $cmd >> $ExecutableFileName
            }
            #Write-Host -NoNewline $filecount
            #$filecount = $filecount + 1
        }
        catch {
            $cmd >> error.log
            Write-Host  "Failed: " $cmd 
            Write-Host
        }
    }
}

"[System.IO.Compression.ZipFile]::CreateFromDirectory('E:\NETSUITE ATTACHMENTS\test','E:\NETSUITE ATTACHMENTS\$ZipFileName',$compressionLevel,$Myfalse)" >> $ExecutableFileName

#$false = '$false'

#Add-Type -AssemblyName System.IO.Compression.FileSystem
#$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
#[System.IO.Compression.ZipFile]::CreateFromDirectory('E:\NETSUITE ATTACHMENTS\$FILENAME.zip','E:\NETSUITE ATTACHMENTS\test',$compressionLevel,$false)
#"[System.IO.Compression.ZipFile]::CreateFromDirectory('E:\NETSUITE ATTACHMENTS\$filename.zip','E:\NETSUITE ATTACHMENTS\test',$compressionLevel,$false)" >> $ExecutableFileName

Write-Host "Created ... " $shortName -ForegroundColor Yellow


