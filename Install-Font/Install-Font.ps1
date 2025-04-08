# Fill in the $applicationname and $msiProductCode variables
$applicationname = "RobotoFont"
$packageversion = "R1"
$FontName = "YoutFont.ttf"
$date = Get-Date -Format "yyyy-MM-dd"
$FontPath = ".\Roboto.ttf"
$FontName = "Roboto.ttf"
$FontsFolder = "$env:windir\Fonts"

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

try {
    Test-Path $FontPath -ErrorAction Stop
} catch {
    Write-Host "Font file not found at $FontPath"
    Write-Log "Font file not found at $FontPath"
    exit 2
}

# Copy the font to the Fonts folder
try {
    Copy-Item -Path $FontPath -Destination $FontsFolder -ErrorAction Stop
} catch {
    Write-Host "Failed to copy the font file from '$FontPath' to '$FontsFolder'."
    Write-Log "Failed to copy the font file from '$FontPath' to '$FontsFolder'."
    exit 1
}

Write-Host "Copied the font file from '$FontPath' to '$FontsFolder'."
Write-Log "Copied the font file from '$FontPath' to '$FontsFolder'."

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class FontInstaller {
    [DllImport("gdi32.dll")]
    public static extern int AddFontResource(string lpFileName);
}
"@

# Register the font with the system
Write-Host "Register the font with the system."
Write-Log "Register the font with the system."
$FontDestPath = $FontsFolder + "\" + $FontName
[FontInstaller]::AddFontResource($FontDestPath)

if (Test-Path -Path $FontPath -PathType Leaf) {
    Write-Output "Font path exists: $FontDestPath"
    exit 0
    Write-Host "Font is installed successfully."
    Write-Log "Font is installed successfully."
} else {
    Write-Error "Font path not found: $FontDestPath"
    Write-Host "Font installation failed."
    Write-Log "Font installation failed."
    exit 1
}