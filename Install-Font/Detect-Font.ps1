# Fill in the variables below as needed.
$applicationname = "Detect-RobotoFont"
$packageversion = "R1"
$date = Get-Date -Format "yyyy-MM-dd"
$FontName = "Roboto (TrueType)"  # Use the display name as seen in Fonts settings
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

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
Write-Log "Checking for $applicationname-R$packageversion..."
Write-Host "Checking for $applicationname-R$packageversion..."
Write-Log "Verifying source file: "$FontPath""
Write-Host "Verifying source file: "$FontPath""

if (Get-ItemProperty -Path $regPath -Name $FontName -ErrorAction SilentlyContinue) {
    Write-Output "Font '$FontName' is installed."
    exit 0
} else {
    Write-Output "Font '$FontName' is NOT installed."
    exit 1
}