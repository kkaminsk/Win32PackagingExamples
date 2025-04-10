# Define source and destination paths
# Creating a desktop shortcut for Safe Exam Browser with Intune failed via COM
# Let's copy a shortcut to the desktop instead
$sourceFile = ".\ITA-SebClientSettings.seb"
$sourceFile2 = ".\Safe Exam Browser.lnk"
$destinationFolder = Join-Path $env:ProgramData "SafeExamBrowser"
$destinationFolder2 = [Environment]::GetFolderPath("Desktop")
$destinationFile = Join-Path $destinationFolder "ITA-SebClientSettings.seb"
$destinationFile2 = Join-Path $destinationFolder2 "Safe Exam Browser.lnk"

# Check if the source file exists
if (-Not (Test-Path $sourceFile)) {
    Write-Error "Source file not found: $sourceFile"
    exit 1
}

# Create destination folder if it doesn't exist
if (-Not (Test-Path $destinationFolder)) {
    try {
        New-Item -ItemType Directory -Path $destinationFolder -Force
        Write-Output "Created destination folder: $destinationFolder"
    } catch {
        Write-Error "Failed to create destination folder: $destinationFolder"
        exit 1
    }
}

# Copy the file
try {
    Copy-Item -Path $sourceFile -Destination $destinationFile -Force
    Write-Output "File copied successfully to $destinationFile"
} catch {
    Write-Error "Failed to copy file: $_"
    exit 1
}

# Check if the source file exists
if (-Not (Test-Path $sourceFile2)) {
    Write-Error "Source file not found: $sourceFile2"
    exit 1
}

# Create destination folder if it doesn't exist
if (-Not (Test-Path $destinationFolder2)) {
    try {
        New-Item -ItemType Directory -Path $destinationFolder2 -Force
        Write-Output "Created destination folder: $destinationFolder2"
    } catch {
        Write-Error "Failed to create destination folder: $destinationFolder2"
        exit 1
    }
}

# Copy the file
try {
    Copy-Item -Path $sourceFile -Destination $destinationFile2 -Force
    Write-Output "File copied successfully to $destinationFile2"
} catch {
    Write-Error "Failed to copy file: $_"
    exit 1
}

Write-Host "Shortcut created on desktop: $shortcutPath"