$DownloadUrl = "https://storage1cactl.blob.core.windows.net/public/dotnet-hosting-3.1.8-win.exe"
$DownloadPath = "$env:USERPROFILE\Downloads\dotnet-hosting-3.1.8-win.exe"
# Download the file using Invoke-WebRequestInvoke-WebRequest -Uri $DownloadUrl -OutFile $DownloadPathWrite-Host "Download completed: $DownloadPath"