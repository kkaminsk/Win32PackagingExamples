# Fill in the $taskName variable
$taskName = "ChangeMeTask"
$version = "1.0"
$packageversion = "R1"
$date = Get-Date -Format "yyyy-MM-dd"

# Ensure the script runs in a 64-bit PowerShell environment
if (-not ([Environment]::Is64BitProcess)) {
    Write-Host "Switching to 64-bit PowerShell..."
    Start-Process -FilePath "$env:WINDIR\SysNative\WindowsPowerShell\v1.0\powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Log file path
$logFile = "$env:WINDIR\temp\Detect-$taskName-V$version-$packageversion-$date.log"

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append
}

Write-Host "Checking for scheduled task: '$taskName'..."
Write-Log "Checking for scheduled task: '$taskName'..."

try {
    $task = Get-ScheduledTask -TaskName $taskName -ErrorAction Stop
    Write-Host "Scheduled task '$taskName' was found."
    Write-Log "Scheduled task '$taskName' was found."
    exit 0  # Success
}
catch {
    Write-Host "Scheduled task '$taskName' was NOT found."
    Write-Log "Scheduled task '$taskName' was NOT found."
    exit 1  # Failure
}
