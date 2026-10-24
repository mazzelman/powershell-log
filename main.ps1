<#
.SYNOPSIS

This script has a log function that can be used to log various messages to a log file.

.DESCRIPTION

- The script supports to see which user is executing the script.
- The script supports to see if the script is running with administrator rights.
- The script supports to see the script path and if the script is running in a 64-bit process.

.LINK

https://www.marcelepp.de
#>

##==========================================================
## MARK: Create log folder and log file
##==========================================================

# The folder where the log file will be created.
$logDir = "C:\Logs"

# Create the folder for the log file if it doesn't exist.
if (-not (Test-Path -Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory -Force | Out-Null
}

# The name of the log file.
$logFile = Join-Path $logDir "My-Log-File.log"

##==========================================================
## MARK: FUNCTION Write-Log
##==========================================================
function Write-Log {
    param([string]$Message)
    $line = "{0}  {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    $line | Out-File -FilePath $logFile -Append -Encoding utf8
}

Write-Log "===== The script has been executed ====="
Write-Log "User: $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)"
Write-Log "Has Administrator Rights: $(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))"
Write-Log "Scriptpath: $PSCommandPath"
Write-Log "64-Bit-Process: $([Environment]::Is64BitProcess)"
Write-Log "===== The script has been completed ====="