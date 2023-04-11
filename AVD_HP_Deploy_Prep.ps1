$RG = "rg-avd-mtl"
$HP = "hp-avd-mtl"
$date = Get-Date -Format dd.MM.yyyy
$Hosts = "Host "

#Listing all the VM's in the host pool
$AVDHosts = Get-AzWvdSessionHost -ResourceGroupName $RG -HostPoolName $HP
ForEach($A in $AVDHosts) {
    $Hosts += $A.resourceid.split("/")[-1]
    $Hosts += " "
}
$AVDHostArray = $hosts.Split(" ")
$AVDHostArray | Out-File "S:\AVD-$Date.csv"
$AVDHost = import-csv "S:\AVD-$Date.csv"

#Drain stop all Hosts
ForEach($H in $AVDHost){
    $HostAVD = $H.host + ".MorrisTL.co.uk"
    Update-AzWvdSessionHost -ResourceGroupName $RG -HostPoolName $HP -Name $HostAVD -AllowNewSession:$False -Verbose
    Write-Host "Drain Stopping $HostAVD"
}

#check for singed in users & send them a sign out warning
$AVDUser = Get-AzWvdUserSession -HostPoolName $HP -ResourceGroupName $RG | select *
ForEach($U in $AVDUser){
    $Details = $AVDUser.name.Split("/")
    $Sessionhost = $Details[1]
    $SessionID = $Details[2]
    $Messagetitle = "Message from IT Support"
    $MessageBody = "Please sign out of the system urgently. You will be automatically signed out of the CK system in 2 minutes."
    Send-AzWvdUserSessionMessage -ResourceGroupName $RG -HostPoolName $HP -SessionHostName $SessionHost -UserSessionId $SessionID -MessageBody $MessageBody -MessageTitle $Messagetitle
}

Write-Host "2 minute wait for users to logout" -BackgroundColor Green
Start-Sleep -Seconds 120 -Verbose

#check for singed in users & log them out
ForEach($U in $AVDUser){
    $Details = $AVDUser.name.Split("/")
    $Sessionhost = $Details[1]
    $SessionID = $Details[2]
    remove-AzWvdUserSession -HostPoolName $HP -ResourceGroupName $RG -Id $SessionID -SessionHostName $Sessionhost -Verbose
    Write-Host "Logging $sessionHost out"
}

#Checking user session count
while ((Get-AzWvdUserSession -ResourceGroupName $RG -HostPoolName $HP).Count -gt 0) {
    Write-Host "Logging users Out" -BackgroundColor Green
}

