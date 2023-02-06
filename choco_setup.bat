@echo off
:: Name:     choco_setup.bat
:: Purpose:  Setup Windows-PC and update software
:: Version:  1.3
:: Date:     2021-11-16
:: Licence:  GPL
:: Author:   de_ramon - me@rms2.de
:: Dependencies: -
:: Remarks:
:: Sorry for german localisation...

:check_permissions
set IS_ELEVATED=0
whoami /groups | find "S-1-16-12288" > nul: && set IS_ELEVATED=1
if %IS_ELEVATED%==0 (
    echo Bitte mit Administrator-Rechten neu starten...
    pause
    exit /b 1
)

cd /d %~d0%~p0
set currentpath=%cd%

:: is chocolatey installed?
where /q choco.exe || goto :choco_install

:MENU
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXXXXXX=================---- Chocolatey-Setup ----=================XXXXXXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
echo (1) - Software-Update
echo (2) - Vorauswahl: PC %computername%
echo (3) - Vorauswahl: Minimal
echo (4) - Vorauswahl: Standard
echo (5) - Vorauswahl: Standard Internet
echo (6) - Vorauswahl: Test
echo (7) - Erstelle Installationslog
echo (8) - Installiere Chocolatey
echo (9) - Beende Skript
echo.
echo Was tun?
echo Nummer eingeben und dann Enter/Return
set /p asw=
if %asw%==1 goto choco_update
if %asw%==2 goto choco_host
if %asw%==3 goto choco_minimal
if %asw%==4 goto choco_standard
if %asw%==5 goto choco_standard_www
if %asw%==6 goto choco_test
if %asw%==7 goto choco_dump
if %asw%==8 goto choco_install
if %asw%==9 goto ende

:choco_install
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXX==================---- Start Chocolatey Setup ----==================XXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey
echo.
goto menu

:choco_update
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco upgrade all -y
echo.
goto menu

:choco_host
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXX==============---- Start Chocolatey Installation  ----==============XXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
if exist %currentpath%\host_%computername%.config (
  choco install -y %currentpath%\host_%computername%.config
) else (
  echo Datei host_%computername%.config nicht existent!
  pause
  cls
)
echo.
goto menu

:choco_standard
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco install -y %currentpath%\sel_standard.config
echo.
goto menu

:choco_standard_www
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco install -y %currentpath%\sel_standard_www.config
echo.
goto menu


:choco_minimal
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco install -y %currentpath%\sel_minimal.config
echo.
goto menu

:choco_freak
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco install -y %currentpath%\sel_coder.config
echo.
goto menu

:choco_test
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX==================---- Start Chocolatey Update  ----==================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco install -y %currentpath%\sel_test.config
echo.
goto menu

:choco_dump
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXX=============---- Dump Chocolatey Installation-Log  ----============XXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
call %currentpath%\choco_packagedump.cmd
echo.
goto menu

:ende
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXXXXXXXXXXXX==================---- END ----=================XXXXXXXXXXXXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
:EOF