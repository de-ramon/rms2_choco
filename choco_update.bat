@echo off
:: Name:     choco_update.bat
:: Purpose:  Update software via choco
:: Version:  1.1
:: Date:     2020-10-14
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

:choco_update
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XX=================---- Chocolatey: Beginn Update  ----=================XX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
choco upgrade all -y
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXX=================---- Chocolatey: Ende Update  ----=================XXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
goto menu
