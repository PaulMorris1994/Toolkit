$vm = get-azvm | where { $_.Name -like "*Prod*" } | select Name

ForEach ($V in $VM) {
Invoke-Command -ComputerName $V.Name -Credential $Cred { get-winevent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | Where { $_.id -like "21" -or $_.id -like "23" -or $_.id -like "24" -and $_.Message -like "*cknotts\paulm*" } | select-object -property Message, Id, TimeCreated } | export-csv -Path "U:\Paul Morris\Logs\pm.csv" -Append
}



