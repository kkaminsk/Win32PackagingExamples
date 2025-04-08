# Some fonts do not register in the registry, so we need to check the file system instead.
# Define application details
$applicationname = "Detect-Lockscreen"  
$version = "1.0" 
$packageversion = "R1"
# Define the target file path
$file = "C:\Windows\Web\Wallpaper\Lockscreen-v1.jpg"

# Define registry path
$registryPath = "HKLM:\Software\BigHatGroup\$applicationname"

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

# Read and compare version from the registry
if (Test-Path -Path $registrypath) {
    $existingversion = (Get-ItemProperty -Path $registrypath -Name "Version" -ErrorAction SilentlyContinue).Version
    if ($ExistingVersion) {
        Write-Log "Existing version found in registry: $existingversion"
        Write-Host "Existing version found in registry: $existingversion"
        exit 0

        if ([version]$version -le [version]$existingversion) {
            Write-Log "Current version ($version) is not greater than existing version ($existingversion). Exiting."
            Write-Host "Current version ($version) is not greater than existing version ($existingversion). Exiting."
            exit 1
        }
    } else {
        Write-Log "No existing version found in registry."
        Write-Host "No existing version found in registry."
        exit 1
    }
} else {
    Write-Log "Registry path does not exist: $registrypath"
    Write-Host "Registry path does not exist: $registrypath"
}

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
            Write-Log "Current package version ($packageversion) is not greater than existing package version ($existingpackageversion). Exiting."
            Write-Host "Current package version ($packageversion) is not greater than existing package version ($existingpackageversion). Exiting."
            exit 1
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

# Check if the lock screen image exists
if (Test-Path -Path $lockscreenFile) {
    Write-Log "File exists: $file"
    Write-Host "File exists: $file"
    exit 0
} else {
    Write-Log "File NOT found: $file"
    Write-Host "File NOT found: $file"
    exit 1
}