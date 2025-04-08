# Define the path to the target application
$targetPath = "C:\Program Files\SafeExamBrowser\Application\SafeExamBrowser.exe"

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