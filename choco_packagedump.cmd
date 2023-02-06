@echo off

REM powershell "Get-Choco-Packages.ps1 '-OutFile packages.config -DatePrefix -HostPrefix'"
REM powershell -file "Get-Choco-Packages.ps1 '-OutFile packages.config -DatePrefix -HostPrefix'"
REM powershell -executionPolicy bypass -noexit -file "Get-Choco-Packages.ps1" "-OutFile packages.config -DatePrefix -HostPrefix"
powershell -executionPolicy bypass -file "Get-Choco-Packages.ps1" -OutFile packages.config -DatePrefix -HostPrefix