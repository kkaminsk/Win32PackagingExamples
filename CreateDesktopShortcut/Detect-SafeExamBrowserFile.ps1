# Define application details
$applicationname = "Detect-SafeExamBrowserFile"  
$version = "1.0" 
$packageversion = "R1"
# Define the target file path
# Define source and destination paths
$destinationFolder = Join-Path $env:ProgramData "SafeExamBrowser"
$file = Join-Path $destinationFolder "ITA-SebClientSettings.seb"

# Define registry path
$registryPath = "HKLM:\Software\VCC\Management\$applicationname"

# Log file path
$logFile = "$env:WINDIR\temp\$applicationname-V$version-$packageversion.log" 

# Function to log messages
function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $logFile -Append
}

Write-Log "Searching for $file."
Write-Host "Searching for $file."

# Read and compare package version from the registry
if (Test-Path -Path $registrypath) {
    $existingpackageVersion = (Get-ItemProperty -Path $registrypath -Name "PackageVersion" -ErrorAction SilentlyContinue).PackageVersion
    if ($existingpackageVersion) {
        Write-Log "Existing package version found in registry: $existingpackageversion"
        Write-Host "Existing package version found in registry: $existingpackageversion"

        # Extract numeric part of package versions for comparison
        $existingversionnumber = [int]($existingpackageversion -replace "[^0-9]", "")
        $currentversionnumber = [int]($packageversion -replace "[^0-9]", "")

        if ($currentversionnumber -le $existingversionnumber) {
            Write-Log "Current package version ($packageversion) is not greater than existing package version ($existingpackageversion). Checking for file."
            Write-Host "Current package version ($packageversion) is not greater than existing package version ($existingpackageversion). Checking for file."
        }
    } else {
        Write-Log "No existing package version found in registry."
        Write-Host "No existing package version found in registry."
        exit 1
    }
} else {
    Write-Log "Registry path does not exist: $registrypath"
    Write-Host "Registry path does not exist: $registrypath"
}

# Ensure the registry path exists
if (-not (Test-Path -Path $registrypath)) {
    New-Item -Path $registrypath -Force | Out-Null
}

# Create or update the registry value
New-ItemProperty -Path $registrypath -Name 'PackageVersion' -Value $packageversion -PropertyType String -Force

# Check if the safe exam browser file exists
if (Test-Path -Path $file) {
    Write-Log "File exists: $file"
    Write-Host "File exists: $file"
    exit 0
} else {
    Write-Log "File NOT found: $file"
    Write-Host "File NOT found: $file"
    exit 1
}