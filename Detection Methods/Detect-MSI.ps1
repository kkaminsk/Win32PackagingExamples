# Fill in the $applicationname and $msiProductCode variables
$applicationname = "DotNetHostingCore"
$version = "3.1.8"
$packageversion = "R1"
$msiproductcode = "{96d460cd-7378-4cf4-9af6-0aed85bac49e}"

# Ensure the script runs in a 64-bit PowerShell environment
if (-not ([Environment]::Is64BitProcess)) {
    Write-Host "Switching to 64-bit PowerShell..."
    Start-Process -FilePath "$env:WINDIR\SysNative\WindowsPowerShell\v1.0\powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Log file path
$logFile = "$env:WINDIR\temp\Detect-$applicationname-V$version-$packageversion.log"

# Function to log messages

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append
}

# Configure registry paths for searching for application presence.
$regPaths = 
    "HKLM:\SOFTWARE\Classes\Installer\Products",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall"

# Start logging
Write-Log "Checking for $applicationname-V$version..."
Write-Host "Checking for $applicationname-V$version..."
Write-Log "Verifying Product Code: $msiProductCode"
Write-Host "Verifying Product Code: $msiProductCode"
$foundProduct = $false

foreach ($regPath in $regPaths) {
    # Search through each registry path
    $items = Get-ItemProperty "${regPath}\*" -ErrorAction SilentlyContinue
    foreach ($item in $items) {
        # Match against the MSI product code
        if ($item.PSChildName -eq $msiProductCode -or $item.DisplayName -like "$msiproductcode") {
            $foundProduct = $true
            break
        }
    }
    if ($foundProduct) {
        break
    }
}

# Exit true if the MSI product code is found
if ($foundProduct) {
    Write-Log "$applicationname is installed."
    Write-Host "$applicationname is installed."
    exit 0
} else {
    Write-Log "$applicationname is not installed."
    Write-Host "$applicationname is not installed."
    exit 1
}