




function systemHardware {
# This function is called for retrieving System Hardware Description and since no specific information was specified, it returns the defaul summary with no piping except list-formatting.

get-WMIObject Win32_ComputerSystem | format-list 

}



function osVersion {
# This function is called for retrieving the OS Name and Version

get-WMIObject Win32_OperatingSystem | select-object | format-list @{L='Operating System Name';E={$_.Name}}, @{L='Version (Build) Number';E={$_.BuildNumber}}

}




function processorSpec{
# This function is called for retrieving the processor description with current processor speed in ghz, number of total cores, and the size of L1,L2,L3 caches in KB (if available)

get-WMIObject Win32_processor | Select-Object | format-list Description, @{n='Speed(Ghz)';e={($_.CurrentClockSpeed/1000)}}, @{l='CoreCount';e={($_.NumberOfEnabledCore)}}, @{l="L1 Cache Size (KB)"
e={if($_.L1CacheSize){$_.L1CacheSize}else {("data unavailable")}}}, @{l='L2 Cache Size (KB)'
e={if($_.L2CacheSize){$_.L2CacheSize}else {("data unavailable")}}}, @{l='L3 Cache Size (KB)'
e={if($_.L3CacheSize){$_.L3CacheSize}else {("data unavailable")}}}

}

function ramInfo {
# This function is called for retrieving the memory info with size in GB, manufacturer labeled as vendor, slot showing bank position.

get-WMIObject Win32_physicalmemory | Select-Object | format-table -autosize -wrap @{L='Vendor';E={$_.Manufacturer}}, Description, @{n="Size(GB)";e={[math]::truncate($_.Capacity / 1GB)}}, @{L='Bank';E={$_.BankLabel}}, @{L='Slot';E={$_.DeviceLocator}}
write-output "
Total RAM installed in system:";get-wmiobject win32_computersystem | format-list @{n="Size(GB)";e={[math]::truncate($_.TotalPhysicalMemory / 1GB)}}

}





function diskSummary {
# This function provides a summary of physical disk drives and their partitions. If the vendor is not available the it prints data unavailable.


$diskdrives = Get-ciminstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Vendor=if($disk.vendor){disk.vendor}else{("data unavailable")}
                                                               Model=$disk.model
										   "Free Space(GB)"=$logicaldisk.freespace / 1gb -as [int]
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }



		
           }
      }
  }




}

function ipconfigReport {
write-output "Your computer's current IP Configuration for enabled adapters is as follows:"
get-ciminstance Win32_networkadapterconfiguration | ? ipenabled | format-table -autosize -wrap IPAddress, Description, Index, SubnetMask, DNSDomain, DNSServer
}


function GPUInfo {
# This function provides the video card (GPU) vendor, description and current screen resolution

get-wmiobject win32_videocontroller | select-object | format-list @{L='Vendor';E={$_.AdapterCompatibility}}, Description, @{L='Current Screen Resolution';E={$_.CurrentHorizontalResolution, $_.CurrentVerticalResolution}}
}


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

ipconfigReport

write-output "Video card (GPU) vendor, description and current screen resolution:" 

GPUInfo

write-output "Have a nice day!"

}