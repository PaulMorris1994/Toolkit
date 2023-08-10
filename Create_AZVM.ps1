Connect-AzAccount -Subscription 9d8f1854-faac-4ad0-a1cf-6d71afc17001

#NewVM
$RG = "rg-avd-images-uks"
$VNet = Get-AzVirtualNetwork -ResourceGroupName rg-avd-prod-uks -Name vnet-avd-avd-prod-uks
$SubnetName = "snet-avd-avd-001-prod-uks"
$SubnetID = $vnet.Subnets | ? { $_.Name -eq "$Subnetname" } | select -ExpandProperty ID
$ImageNIC = "ImageNIC"
$Name = Read-Host "Type new VM name"
$Location = "UKSouth"
$Gallerydefname = "cwk-avd-win10-multiuser-poc"
$GalleryName = "acgavdimagesukspoc"

$ImageSelection = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName | select Name
$teams= new-object -Type System.Collections.Arraylist
ForEach($I in $ImageSelection){
    $Image = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName -Name $I.Name | Select *
    $ImageName = ($Image).Name
    $Date = ($Image).PublishingProfile.PublishedDate
    $teams.Add([psCustomObject]@{
        "Image" = $ImageName;
        "Date"  = $Date})
}
$teams | select Image, Date | Sort Date -Descending | Out-Host

$ImageVersion = Read-Host "Type image name"
$Size = "Standard_B2s"
$Disk = "Delete"
$LicenseType = "Windows_Client"
$NIC = "Delete"
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#AzureComputeGallery
$image = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName -Name $ImageVersion

#Setting up Azure VM
$VM = New-AzVMConfig -VMName $Name -VMSize $Size -LicenseType $LicenseType
$vNic = New-AzNetworkInterface -Name $ImageNIC -ResourceGroupName $RG -Location $Location -SubnetId $subnetId -Verbose
$VM = Add-AzVMNetworkInterface -VM $VM -Id $vNic.ID
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName $Name -Credential $Cred
$VM = Set-AzVMSourceImage -VM $VM -Id $Image.ID
$VM = Set-AzVMBootDiagnostic -vm $VM -Disable
New-AZVM `
-vm $VM `
-ResourceGroupName $RG `
-Location $Location `
-OSDiskDeleteOption $Disk `
-DataDiskDeleteOption $Disk `
-Verbose

#VM, NIC and NSG details
#$VM = Get-AZVM -Name $Name
#$NicName = $vm.NetworkProfile.NetworkInterfaces.Id.Split('/')[-1]
#$NSG = (Get-AzNetworkInterface -Name $NicName).NetworkSecurityGroup.Id.Split('/')[-1]
#$NIC = Get-AzNetworkInterface -Name $NICName
#$Nic.NetworkSecurityGroup = $null

#Remove NSG
#Set-AzNetworkInterface -NetworkInterface $NIC
#Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name $nsg -Force -Confirm:$False -Verbose

#Assign license type
#$VM.LicenseType = "Windows_Client"
#Update-AzVM -ResourceGroupName $RG -VM $VM -Verbose

Disconnect-AzAccount -Confirm:$False
