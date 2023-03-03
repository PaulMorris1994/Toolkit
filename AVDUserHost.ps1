Connect-AzAccount -Subscription 9d8f1854-faac-4ad0-a1cf-6d71afc17001
$HP = "hp-avd-prod-uks"
$RG = "rg-avd-prod-uks"
$User = Read-Host "Type username"

Get-AzWvdUserSession -ResourceGroupName $RG -HostPoolName $HP | Where { $_.ActiveDirectoryUserName -like "*$User*" } | select ActiveDirectoryUserName, Name

