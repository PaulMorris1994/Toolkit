get-disk
$Disk = read-host "Please enter drive number you would like to format"
clear-disk -number $Disk -RemoveData -RemoveOEM
read-host "Select any key to close"