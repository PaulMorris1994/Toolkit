$Folder = import-csv -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\paul morris\U Drive\Test_Move.csv"

ForEach ( $F in $Folder ) {
    Move-Item -Path $F.Path -Destination $F.Destination -Force -Verbose
    $ACL = Get-Acl "\\sacwkfsuks.file.core.windows.net\shareddrive\paul morris\acl"
    $fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule ("cknotts\$($F.SamAccountName)",'FullControl','ContainerInherit,ObjectInherit','None','Allow') -Verbose
    $Acl.SetAccessRule($fileSystemAccessRule)
    Set-ACL -Path $F.ACL -AclObject $ACL -Verbose
}
