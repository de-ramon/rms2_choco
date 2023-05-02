mkdir c:\Admin\Source | cd
Invoke-WebRequest 'https://codeload.github.com/de-ramon/rms2_choco/zip/refs/heads/master' -OutFile .\rms2_choco.zip
Expand-Archive .\rms2_choco.zip c:\Admin\
mkdir c:\Admin\rms2_choco
Move-Item -Force -Path C:\Admin\rms2_choco-master\* -Destination C:\Admin\rms2_choco
Remove-Item C:\Admin\rms2_choco-master -Force

