# GPU Partitioning

## A method to partition off resources from your graphics card so that it can be used inside your VMs

### Requirements

An existing Hyper-V Generation 2 Windows VM

### Instructions

1. Test to see if your GPU can be partitioned at all.On the Host, open a PowerShell prompt as administrator. Then run:

    ```powershell
    Get-VMPartitionableGpu #For Windows 10
    ```

    ```powershell
    Get-VMHostPartitionableGpu #For Windows 11
    ```

2. Open up Device Manager on the guest VM, and check the Display Adapters. You will see that your GPU is not present. Shut down the VM.
3. From the [Easy-GPU-PV](https://github.com/redlinejoes/Easy-GPU-PV) GitHub, download these two files:
    [Add-VMGpuPartitionAdapterFiles.psm1](https://github.com/redlinejoes/Easy-GPU-PV/blob/main/Add-VMGpuPartitionAdapterFiles.psm1)
    [Update-VMGpuPartitionDriver.ps1](https://github.com/redlinejoes/Easy-GPU-PV/blob/main/Update-VMGpuPartitionDriver.ps1)
4. From an admin PowerShell console, run this command:

    ```powershell
    .\Update-VMGpuPartitionDriver.ps1 -VMName "Name of your VM" -GPUName "AUTO"
    ```

    Edit that command with the name or your VM. GPU "AUTO" will automatically determine your GPU. These scripts will find all the driver files from your host machine, and copy the files to the VM. This can take some time.
5. With the VM still off, create a new *.ps1 PowerShell file on the host, and paste in this code:

    ```powershell
    $vm = "Name of your VM"
    if (Get-VMGpuPartitionAdapter -VMName $vm -ErrorAction SilentlyContinue) {
    Remove-VMGpuPartitionAdapter -VMName $vm
    }
    Set-VM -GuestControlledCacheTypes $true -VMName $vm
    Set-VM -LowMemoryMappedIoSpace 1Gb -VMName $vm
    Set-VM -HighMemoryMappedIoSpace 32Gb -VMName $vm
    Add-VMGpuPartitionAdapter -VMName $vm    
    ```

    This script will enable the GPU partitioning for your VM, and turn on some required settings.

6. Edit the first line and again put the name of your VM. Then run this script file in your PowerShell prompt by preceeding the filename with .\ just like you did with the previous script above.

7. Now we should have the drivers copied into the VM, and the GPU partitioning feature enabled. You can now turn on the VM, and go back to Device Manager and see if your GPU is now shown under Display Adapters

The solution above enables your GPU on an existing VM.

Everytime you update the graphics drivers on the host, you will need to repeat Step #4 to copy the new files to the VM.
