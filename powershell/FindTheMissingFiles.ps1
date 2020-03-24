if(Test-Path booboo.txt -PathType leaf)
{
    Write-Host "Yes" -ForegroundColor Green
}
else {
    Write-Host "No" -ForegroundColor Red
}