$RG = "rg-avd-mtl"
$HP = "hp-avd-mtl"
$date = Get-Date -Format dd.MM.yyyy
$AVDHost = import-csv "S:\AVD-$Date.csv"

#Remove VM hosts from host pool
ForEach($AVD in $AVDHost){
    $HostAVD = $AVD.host + ".MorrisTL.co.uk"
    Remove-AzWvdSessionHost -ResourceGroupName $RG -HostPoolName $HP -Name $HostAVD -Verbose
    Write-Host "Removing $HostAVD from Host Pool" -BackgroundColor Green
}

#Checking VM count is Host Pool
#while ((Get-AzWvdSessionHost -ResourceGroupName $RG -HostPoolName $HP).Count -gt 0) {
#    Write-Host "Removing Hosts from Host Pool" -BackgroundColor Green
#}

#Remove recourses from RG
ForEach($AVD in $AVDHost){
    $VM = get-azvm -Name $AVD.Host | select *
    Remove-azvm -ResourceGroupName $RG -Name $AVD.Host -Force -Confirm:$False -Verbose
    $Disk = $VM.StorageProfile.OsDisk.name
    Remove-AzDisk -ResourceGroupName $RG -DiskName $Disk -Force -Confirm:$False -Verbose
    $NIC = $vm.NetworkProfile.NetworkInterfaces.Id.Split('/')[-1]
    Remove-AzNetworkInterface -ResourceGroupName $RG -Name $NIC -Force -Confirm:$False -Verbose
}