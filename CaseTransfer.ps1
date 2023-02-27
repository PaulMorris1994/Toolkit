$Cases = Import-CSV "\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\Care\chetd\cases.csv"

Foreach ($C in $Cases) {

    $Folder = $c.Destination.Split("\")
    $DestinationTestMatter = [String]::Join('\',$folder[0],$Folder[1],$Folder[2],$Folder[3],$Folder[4])
    $DestinationTestNumber = [String]::Join('\',$folder[0],$Folder[1],$Folder[2],$Folder[3],$Folder[4],$Folder[5])
    $MatterFolder = [String]::Join('\',$folder[0],$Folder[1],$Folder[2],$Folder[3])
    $Matter = $folder[4]
    $Number = $folder[5]

    If(-Not(Test-Path $DestinationTestMatter)) {
       New-Item -ItemType Directory -Path $Matterfolder -Name $Matter -Verbose
       New-Item -ItemType Directory -Path $DestinationTestMatter -Name $Number -Verbose
       gci -Recurse -Path $C.Path | Copy-Item -Destination $c.Destination -Verbose
    }
    ElseIf(-Not(Test-Path $DestinationTestNumber)) {
       New-Item -ItemType Directory -Path $DestinationTestMatter -Name $Number -Verbose
       gci -Recurse -Path $C.Path | Copy-Item -Destination $c.Destination -Verbose
    }
    Else {
        Write-Host $C.Path -ForegroundColor red -BackgroundColor Black
        #gci -Recurse -Path $C.Path | where { $_.LastWriteTime -gt "11/28/2022 11:00:00" } | Copy-Item -Destination $c.Destination -Force -Verbose
        gci -Recurse -Path $C.Path | where { $_.LastWriteTime -gt "11/28/2022 11:00:00" } | fl FullName, LastWritetime
    }

}
