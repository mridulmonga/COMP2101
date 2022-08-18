param ([string[]] $System, [string[]] $Disks, [string[]] $Network)

Import-Module Module200483237



function systemInformationScript {

#This main function calls all other functions to create a report for the system

write-output "Your computer's current system configuration report is below: "

write-output "System Hardware Description:" 

systemHardware

write-output "Operating System Name and Version:" 

osVersion

write-output "Processor Description, Speed, Cores, Cache sizes:" 

processorSpec

write-output "Memory (RAM) vendor, description, size, bank, slot, total:" 

ramInfo

write-output "Disk summary with vendor, model, size, free space"

diskSummary 

write-output "Network Adapter Configuration with IP, Description, Index, Subnet, DNS:" 

ipconfigList

write-output "Video card (GPU) vendor, description and current screen resolution:" 

GPUInfo

write-output "Have a nice day!"

}