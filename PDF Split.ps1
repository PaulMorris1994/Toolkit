if (Get-Module -name PSWritePDF) {
    $PDF = gci -file -Path "S:\PDF Split" | select fullname
    $Name = Read-host "Type file export name"

    Split-PDF -FilePath $PDF.Fullname -OutputFolder "S:\PDF Split\Output" -OutputName "$Name" -IgnoreProtection -Verbose
    Read-Host "Job Completed"
}
Elseif (Get-InstalledModule -Name PSWritePDF){
    Import-Module -Name  PSWritePDF

    $PDF = gci -file -Path "S:\PDF Split" | select fullname
    $Name = Read-host "Type file export name"

    Split-PDF -FilePath $PDF.Fullname -OutputFolder "S:\PDF Split\Output" -OutputName "$Name" -IgnoreProtection -Verbose
    Read-Host "Job Completed"
}
Else {
    Install-Module -Name PSWritePDF
    Import-Module -Name PSWritePDF

    $PDF = gci -file -Path "S:\PDF Split" | select fullname
    $Name = Read-host "Type file export name"

    Split-PDF -FilePath $PDF.Fullname -OutputFolder "S:\PDF Split\Output" -OutputName "$Name" -IgnoreProtection -Verbose
    Read-Host "Job Completed"
}