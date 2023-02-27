$cred = Get-StoredCredential -Target automation
Invoke-Command -ComputerName CKSAZMAN001 -Credential $Cred {
start-adsyncsynccycle -policytype delta
}
