$HP = "hp-avd-prod-uks"
$RG = "rg-avd-prod-uks"

$VM = (Get-AzWvdSessionHost -ResourceGroupName $RG -HostPoolName $HP | where { $_.Status -like "Available" }).Count
$User = (Get-AzWvdusersession -ResourceGroupName $RG -HostPoolName $HP).Count
$Date = get-date

$Export = [Ordered] @{
    "Date"        = $Date
    "VM Count"    = $VM
    "User Count"  =$User
}

New-Object -TypeName PSObject -Property $Export | export-csv -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\AVD Count\AVD_Logs.csv" -NoTypeInformation -Append

