# Using this method to check for fonts you can search the registry as well.
# Also if you find difficulty with this script you might have to use the Detect-FontFile.ps1 script to check for the font file in the system.
# Fill in the variables below as needed.
$applicationname = "Detect-RobotoFontFile"
$packageversion = "R1"
$date = Get-Date -Format "yyyy-MM-dd"
$FontName = "Roboto.ttf"
$FontsFolder = "$env:windir\Fonts"
$FontsFolderPath = "$FontsFolder\$FontName"

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
Write-Log "Checking for font TTF file $FontsFolderPath..."
Write-Host "Checking for font TTF file $FontsFolderPath..."

if (-Not (Test-Path -Path $FontsFolderPath -PathType Leaf)) {
    Write-Error "No TTF file found in $FontsFolderPath"
    exit 1
}
else {
    Write-Host "Font file found at $FontsFolderPath"
    Write-Log "Font file found at $FontsFolderPath"
    Exit 0 # Success
}