param (
    [Parameter(Mandatory=$true, HelpMessage = "Choose from the following report options: System, Disk, Network or just press enter for the Full Report")]
    [AllowEmptyString()]
    [string]$TypeOfReport
    )

if ($TypeOfReport -eq "") {
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

elseif ($TypeOfReport -eq "System") {
write-output "Your computer's CPU, OS, RAM, Video reports are below: "

write-output "System Hardware Description:" 

systemHardware

write-output "Operating System Name and Version:" 

osVersion

write-output "Memory (RAM) vendor, description, size, bank, slot, total:" 

ramInfo

write-output "Video card (GPU) vendor, description and current screen resolution:" 

GPUInfo
}

elseif ($TypeOfReport -eq "Disks") {
write-output "Your computer's Disks report is below: "

write-output "Disk summary with vendor, model, size, free space"

diskSummary 
}

elseif ($TypeOfReport -eq "Network") {
write-output "Your computer's Network report is below: "

write-output "Network Adapter Configuration with IP, Description, Index, Subnet, DNS:" 

ipconfigList
}

else {
write-output "Incorrect parameter specified. Please type !? for help."
}