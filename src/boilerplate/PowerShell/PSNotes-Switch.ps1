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
Write-Host "Please choose one of the following options:"
Write-Host "1. Enter a single hostname"
Write-Host "2. Enter a file containing hostnames"
Write-Host "3. Quit"

$selection = Read-Host "Enter your selection (1, 2, or 3)"

switch ($selection) {
    1 {
        Write-Host "You selected Option One."
        $HostName = Read-Host "Enter a hostname"
        Write-Host "You entered the hostname: $HostName"
        try {
            # Try something            
        }
        catch [System.Management.Automation.ItemNotFoundException] {
            # Do this if a terminating exception happens
            Write-Host "The $HostName was not found." -ForegroundColor Red    
        }
        catch {
            # Write out the exception message to the host
            Write-Host $PSItem.Exception.Message -ForegroundColor Red
        }
        finally {
            # Do this after the try block regardless of whether an exception occurred or not
            # Clears the error
            $Error.Clear()
        }
    }
    2 {
        Write-Host "You selected Option Two."
        $filePath = Read-Host "Enter the file path containing hostnames"
        Write-Host "You entered the file path: $filePath"
        # Declare the variable and content to import the list of hostanmes or IP addresses
        $Hosts = Get-Content $filePath
        try {
            ForEach ($HostName in $Hosts) {
                # Try something                
            }
        }
        catch [System.Management.Automation.ItemNotFoundException] {
            # Do this if a terminating exception happens
            Write-Host "The $HostName was not found." -ForegroundColor Red    
        }
        catch {
            # Write out the exception message to the host
            Write-Host $PSItem.Exception.Message -ForegroundColor Red
        }
        finally {
            # Do this after the try block regardless of whether an exception occurred or not
            # Clears the error
            $Error.Clear()
        }
    }
    3 {
        Write-Host "Quitting script..."
        return
    }
    default {
        Write-Host "Invalid selection. Please enter 1, 2, or 3."
    }
}