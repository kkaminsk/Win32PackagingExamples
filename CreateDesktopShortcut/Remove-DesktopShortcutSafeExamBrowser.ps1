# Define paths for cleanup
$sebFilePath = Join-Path $env:ProgramData "SafeExamBrowser\ITA-SebClientSettings.seb"
$shortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "SafeExamBrowser.lnk"

# Remove the .seb file if it exists
if (Test-Path $sebFilePath) {
    try {
        Remove-Item -Path $sebFilePath -Force
        Write-Host "Removed SEB file: $sebFilePath"
    } catch {
        Write-Warning "Failed to remove SEB file: $_"
    }
} else {
    Write-Host "SEB file not found: $sebFilePath"
}

# Remove the desktop shortcut if it exists
if (Test-Path $shortcutPath) {
    try {
        Remove-Item -Path $shortcutPath -Force
        Write-Host "Removed shortcut: $shortcutPath"
    } catch {
        Write-Warning "Failed to remove shortcut: $_"
    }
} else {
    Write-Host "Shortcut not found: $shortcutPath"
}
