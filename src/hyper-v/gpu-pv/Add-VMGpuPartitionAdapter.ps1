<#
.NOTES
    Script Name: PSNotes-Switch.ps1
    Author: Joseph Young <joe@youngsecurity.net>
    Date: 6/24/2023
    Copyright: (c) Young Security Inc.
    Licensed under the MIT License.
.SYNOPSIS
    This script boilerplate will present the end-user with three options to choose from.    
.DESCRIPTION
    This script is boilerplate to help setup a multiple choice prompt.
.EXAMPLE
    .\PSNotes-Switch.ps1 <arguments>    
#>
$vm = Read-Host "Enter the name of your VM"
#Write-Host "You entered the VM name: $vm"
if (Get-VMGpuPartitionAdapter -VMName $vm -ErrorAction SilentlyContinue) {
	Remove-VMGpuPartitionAdapter -VMName $vm
}
Set-VM -GuestControlledCacheTypes $true -VMName $vm
Set-VM -LowMemoryMappedIoSpace 1Gb -VMName $vm
Set-VM -HighMemoryMappedIoSpace 32Gb -VMName $vm
Add-VMGpuPartitionAdapter -VMName $vm