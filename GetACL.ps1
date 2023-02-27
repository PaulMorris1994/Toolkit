$Path = Read-Host "Please type the file path of the root folder you wish to get the ACL's of the subfolders"
$Export = Read-Host "Please type export path, including the new file name"
$FT = Get-ChildItem -Directory -Path $Path
Foreach ($F in $FT) {
    get-acl -Path $f.FullName | Select path, owner, AccessToString | export-csv -Path $Export -Append -NoTypeInformation
    }