@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
title Extract Packs
goto:Main-code
net session >nul 2>&1
if %errorLevel% == 0 (
        echo Starting...
		timeout 1 /nobreak
		cls
    ) else (
		Powershell Start-Process install.bat -Verb runAs
		cls
		exit
    )
::-------------------------------------------------------------------------------------
:Main-code
if not exist ".\\Launcher\ffmpeg" (mkdir Launcher
echo Installation de la base...
powershell -command "Expand-Archive -Force .\Base.zip .\Launcher"
echo Installation de la base terminee
timeout 5 /nobreak
cls)

set /a choix=0
if not exist .\\Launcher\Tools (
echo Voulez vous installer les outils 350 Mb
echo 1:oui
echo 2:non
set /p choix=Faites un choix:)

if %choix%==1 (
cls
mkdir .\\Launcher\Tools
echo Installation des outils...
powershell -command "Expand-Archive -Force .\Tools.zip .\Launcher\Tools"
echo Installation des outils terminee
timeout 5 /nobreak
cls)



set /a choix=0
if not exist .\\Launcher\Extras (
echo Voulez vous installer les Extras 65 Mb
echo 1:oui
echo 2:non
set /p choix=Faites un choix:)

if %choix%==1 (
cls
mkdir .\\Launcher\Extras
echo Installation des Extras...
powershell -command "Expand-Archive -Force .\Extras.zip .\Launcher\Extras"
echo Installation des Extras terminee
timeout 5 /nobreak
cls)

cls
echo %CD%
set c=0
for /F "tokens=*" %%a in (Main.bin) do (set /a c= !c!+1
title !c! Lignes traitees)
::-------------------------------------------------------------------------------------
if not exist ".\\Launcher\Launcher.bat" (goto:extract-script)
set /p patch=<Main.ini
set /p old-patch=<".//Launcher/Launcher.bat"
echo %patch%
echo ---------------------------------
echo %old-patch%
timeout 3 /nobreak
cls

::-------------------------------------------------------------------------------------
if !patch! == !old-patch! (echo Pas mise a jour : %patch%
timeout 2 /nobreak
exit)
if not !patch! == !old-patch! (echo Update to : %patch%)

timeout 3 /nobreak
cls
:extract-script
title Extract Packs
if exist .\\Launcher\Launcher[old].bak (erase .\\Launcher\Launcher[old].bak)
ren ".\\Launcher\Launcher.bat" "Launcher[old].bak"
copy "Main.bin" "./Launcher/"
ren ".\\Launcher\Main.bin" "Launcher.bat"
move ".\\Launcher\Launcher[old].bak" ".\\Launcher\backup"
cls
echo Mise a jour terminee
timeout 4 /nobreak
exit