if (test-path S:\) {
    $Name = Hostname
$os = Get-CimInstance -ClassName CIM_OperatingSystem
$disk = Get-CimInstance -ClassName CIM_LogicalDisk -Filter "DeviceID='C:'"
$Laptop = Get-CimInstance -ClassName CIM_ComputerSystem
$Proc = Get-CimInstance -ClassName Win32_Processor
$RD = Get-CimInstance win32_bios
$HDD = Get-PhysicalDisk


     $Prop=[Ordered]@{
                'Manufacturer' = $laptop.Manufacturer
                'Laptop Model' = $laptop.model
                'RD' = $RD.ReleaseDate
                'ComputerName' = $laptop.name
                'Username' = $laptop.username
                'Serial Number' = $RD.SerialNumber            
                'OS Name' = $OS.caption
                'Drive Type' = $HDD.Mediatype
                'Disk Size C:' = $disk.Size /1gb -as [int]
                'Memory' = $laptop.TotalPhysicalMemory /1gb -as [int]
                'Processor' = $Proc.name   
                'OS Build' = $OS.buildNumber
                'FreeSpace C:' = $disk.FreeSpace / 1gb -as [int] 
                }
                $obj = New-Object -TypeName PSobject -Property $Prop | export-csv "S:\$Name.csv" -NoTypeInformation
}
else {
    $Name = Hostname
    $os = Get-CimInstance -ClassName CIM_OperatingSystem
    $disk = Get-CimInstance -ClassName CIM_LogicalDisk -Filter "DeviceID='C:'"
    $Laptop = Get-CimInstance -ClassName CIM_ComputerSystem
    $Proc = Get-CimInstance -ClassName Win32_Processor
    $RD = Get-CimInstance win32_bios
    $HDD = Get-PhysicalDisk


     $Prop=[Ordered]@{
                'Manufacturer' = $laptop.Manufacturer
                'Laptop Model' = $laptop.model
                'RD' = $RD.ReleaseDate
                'ComputerName' = $laptop.name
                'Username' = $laptop.username
                'Serial Number' = $RD.SerialNumber            
                'OS Name' = $OS.caption
                'Drive Type' = $HDD.Mediatype
                'Disk Size C:' = $disk.Size /1gb -as [int]
                'Memory' = $laptop.TotalPhysicalMemory /1gb -as [int]
                'Processor' = $Proc.name   
                'OS Build' = $OS.buildNumber
                'FreeSpace C:' = $disk.FreeSpace / 1gb -as [int]                                             
                }
                $obj = New-Object -TypeName PSobject -Property $Prop | export-csv "$home\documents\$Name.csv" -NoTypeInformation
}

If (Test-Path "S:\$Name.csv"){
   Read-Host "Your document is saved in the following location: "S:\$Name.csv"" }
Else {
   Read-Host "Your document is saved in the following location: "$home\documents\$Name.csv""
   }