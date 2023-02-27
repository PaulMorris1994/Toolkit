$Office = Get-AzureADUser -All $True | where { $_.PhysicalDeliveryOfficeName -like "Worcester" } | select Displayname, @{N='Office';E={$_.PhysicalDeliveryOfficeName}}, ObjectID

New-AzADGroup -DisplayName "Worcester Office" -GroupType "Unified" -MailEnabled -MailNickname "WorcesterOffice" -Visibility Private

ForEach ($O in $Office) {
    Add-AzADGroupMember -TargetGroupDisplayName "Worcester Office" -MemberObjectId $O.ObjectID
}

$ID = (Get-azadgroup -DisplayName "Worcester Office").Id

New-Team -GroupId $ID