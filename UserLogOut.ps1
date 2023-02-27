$HP = "hp-avd-prod-uks"
$RG = "rg-avd-prod-uks"
$User = Read-Host "Type username"
$AVDUser = Get-AzWvdUserSession -HostPoolName $HP -ResourceGroupName $RG | where { $_.ActiveDirectoryUserName -eq "cknotts\$User" } | select *
$Details = $AVDUser.name.Split("/")
$Sessionhost = $Details[1]
$SessionID = $Details[2]

remove-AzWvdUserSession -HostPoolName $HP -ResourceGroupName $RG -Id $SessionID -SessionHostName $Sessionhost -Verbose
Read-Host "Job Completed"
