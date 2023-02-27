Install-module Microsoft.Graph.Identity.Signins
Connect-MgGraph -Scopes UserAuthenticationMethod.ReadWrite.All
Select-MgProfile -Name beta
$Num = import-csv s:\AWH.csv

ForEach ($N in $Num) {
$N.UPN
Remove-MgUserAuthenticationPhoneMethod -UserId $N.UPN -PhoneAuthenticationMethodId 3179e48a-750b-4051-897c-87b9720928f7 -Verbose
New-MgUserAuthenticationPhoneMethod -UserId $N.UPN -phoneType "mobile" -phoneNumber "+44 $($N.Number)" -Verbose
Remove-AzADGroupMember -GroupDisplayName AAD_CA_Breakglass -MemberUserPrincipalName $N.UPN -Verbose
    }