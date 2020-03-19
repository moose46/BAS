
Function Get-CopyAttachments{
Param([string]$source, [string]$destination)
$sourcePath = 'c:\'
$targetPath = 'c:\'

    echo $source, $sourcePath
    #xcopy  C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\import_from_bas\ACCOUNT.csv C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\import_from_bas\archive\ACCOUNT.csv

}
Get-CopyAttachments("boo","boooo")
sqlcmd --% -S (local) -E -Q "select accountid,filename  from ATTACHMENT" -d babblefish

