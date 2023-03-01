$Office = Get-AzADUser | where { $_.OfficeLocation -like "blackburn" } | select Displayname, @{N='Office';E={$_.OfficeLocation}}, ID

New-AzADGroup -DisplayName "Blackburn Office" -GroupType "Unified" -MailEnabled -MailNickname "BlackburnOffice" -Visibility Private -Verbose

ForEach ($O in $Office) {
    Add-AzADGroupMember -TargetGroupDisplayName "Blackburn Office" -MemberObjectId $O.ID
}

$ID = (Get-azadgroup -DisplayName "Blackburn Office").Id

New-Team -GroupId $ID
