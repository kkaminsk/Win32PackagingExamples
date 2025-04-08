# Using this method to check for fonts as not everything registers in the registry.
# Fill in the variables below as needed.
$applicationname = "Detect-RobotoFont"
$packageversion = "R1"
$date = Get-Date -Format "yyyy-MM-dd"
$FontToCheck = "Roboto"  # Just the font family name

# Ensure the script runs in a 64-bit PowerShell environment
if (-not ([Environment]::Is64BitProcess)) {
    Write-Host "Switching to 64-bit PowerShell..."
    Start-Process -FilePath "$env:WINDIR\SysNative\WindowsPowerShell\v1.0\powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Log file path
$logFile = "$env:WINDIR\temp\Detect-$applicationname-$packageversion-$date.log"

# Function to log messages
function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append
}

# Start logging
Write-Log "Checking for font $fonttocheck..."
Write-Host "Checking for font $fonttocheck..."

Add-Type -AssemblyName System.Drawing
$fonts = New-Object System.Drawing.Text.InstalledFontCollection
$fontNames = $fonts.Families | ForEach-Object { $_.Name }

if ($fontNames -contains $FontToCheck) {
    Write-Output "Font '$FontToCheck' is installed."
    Write-Log "Font '$FontToCheck' is installed."
    exit 0
} else {
    Write-Output "Font '$FontToCheck' is NOT installed."
    Write-Log "Font '$FontToCheck' is NOT installed."    
    exit 1
}