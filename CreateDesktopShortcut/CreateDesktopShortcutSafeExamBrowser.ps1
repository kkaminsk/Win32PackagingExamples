# Define source and destination paths
$sourceFile = ".\ITA-SebClientSettings.seb"
$destinationFolder = Join-Path $env:ProgramData "SafeExamBrowser"
$destinationFile = Join-Path $destinationFolder "ITA-SebClientSettings.seb"

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

# Define the path to the target application
$targetPath = "C:\ProgramData\SafeExamBrowser\ITA-SebClientSettings.seb"

# Define the working directory
$workingDirectory = "C:\Program Files\SafeExamBrowser\Application\"

# Define the name and location of the shortcut
$desktopPath = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "SafeExamBrowser.lnk"

# Create a WScript.Shell COM object
$wShell = New-Object -ComObject WScript.Shell

# Create the shortcut
$shortcut = $wShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $targetPath
$shortcut.WorkingDirectory = $workingDirectory
$shortcut.WindowStyle = 1  # Normal window
$shortcut.Description = "Launch Safe Exam Browser"
$shortcut.Save()

Write-Host "Shortcut created on desktop: $shortcutPath"