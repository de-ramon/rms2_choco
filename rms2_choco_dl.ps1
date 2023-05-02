$InstallPath = "c:\Admin"
md -Force $InstallPath\Source
Invoke-WebRequest 'https://codeload.github.com/de-ramon/rms2_choco/zip/refs/heads/master' -OutFile $InstallPath\Source\rms2_choco.zip
Expand-Archive $InstallPath\Source\rms2_choco.zip $InstallPath
md -Force $InstallPath\rms2_choco
Move-Item -Force -Path $InstallPath\rms2_choco-master\* -Destination $InstallPath\rms2_choco
Remove-Item $InstallPath\rms2_choco-master -Force

