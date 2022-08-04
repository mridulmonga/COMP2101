function ipconfigReport {
write-output "Your computer's current IP Configuration for enabled adapters is as follows:"
get-ciminstance Win32_networkadapterconfiguration | ? ipenabled | format-table IPAddress, Description, Index, SubnetMask, DNSDomain, DNSServer
}

ipconfigReport