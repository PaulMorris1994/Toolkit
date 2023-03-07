Connect-ExchangeOnline -ShowBanner:$False
$Name = Read-Host "Type fullname"

Get-EXOMailboxFolderStatistics -Identity $Name | ? { $_.Identity -like "*inbox*" -or $_.Identity -like "*Archive*"} | ft identity, itemsinfolder, foldersize -AutoSize

Disconnect-ExchangeOnline -Confirm:$False