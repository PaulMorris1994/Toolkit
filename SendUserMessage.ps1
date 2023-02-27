Connect-AzAccount -Subscription 9d8f1854-faac-4ad0-a1cf-6d71afc17001
$HP = "hp-avd-prod-uks"
$RG = "rg-avd-prod-uks"
$User = Read-Host "Type username"
$AVDUser = Get-AzWvdUserSession -HostPoolName $HP -ResourceGroupName $RG | where { $_.ActiveDirectoryUserName -eq "cknotts\$User" } | select *
$Details = $AVDUser.name.Split("/")
$Sessionhost = $Details[1]
$SessionID = $Details[2]
$Messagetitle = "Message from IT Support"
$MessageBody = Read-Host "Type Message"

Send-AzWvdUserSessionMessage -ResourceGroupName $RG -HostPoolName $HP -SessionHostName $SessionHost -UserSessionId $SessionID -MessageBody $MessageBody -MessageTitle $Messagetitle