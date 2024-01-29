# Set Destination
$InstallPath = "c:\Admin"
mkdir -Force $InstallPath\Source
# Download package
Invoke-WebRequest 'https://codeload.github.com/de-ramon/rms2_choco/zip/refs/heads/master' -OutFile $InstallPath\Source\rms2_choco.zip
Expand-Archive $InstallPath\Source\rms2_choco.zip $InstallPath
mkdir -Force $InstallPath\rms2_choco
Move-Item -Force -Path $InstallPath\rms2_choco-master\* -Destination $InstallPath\rms2_choco
Remove-Item -Force $InstallPath\rms2_choco-master
# Copy LNK-Files to the Desktop of the current users
Copy-Item $InstallPath\rms2_choco\*.lnk ([Environment]::GetFolderPath("Desktop"))
