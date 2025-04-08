# Fill in the variables below as needed.
$applicationname = "RobotoFont-UnInstall"
$packageversion = "R1"
$date = Get-Date -Format "yyyy-MM-dd"
$FontName = "Roboto.ttf"

# Leave as-is
$FontsFolder = "$env:windir\Fonts"
$FontPath = "$FontsFolder\$FontName"

# Ensure the script runs in a 64-bit PowerShell environment
if (-not ([Environment]::Is64BitProcess)) {
    Write-Host "Switching to 64-bit PowerShell..."
    Start-Process -FilePath "$env:WINDIR\SysNative\WindowsPowerShell\v1.0\powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Log file path
$logFile = "$env:WINDIR\temp\Uninstall-$applicationname-$packageversion-$date.log"

# Function to log messages
function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append
}

# Start logging
Write-Log "Removing file: "$FontPath""
Write-Host "Removing file: "$FontPath""

# Remove the font from the Fonts folder
try {
    Remove-Item -Path $FontPath -Force
    Write-Host "Removed the font file from '$FontPath'."
    Write-Log "Removed the font file from '$FontPath'."
} catch {
    Write-Host "Failed to remove the font file from '$FontPath'."
    Write-Log "Failed to remove the font file from '$FontPath'."
    exit 1 # Failure to remove the font
}