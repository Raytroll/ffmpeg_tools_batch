@echo off
title Download : ffmpeg tools batch
if exist install.bat (echo Programme deja telecharger !
goto:choix)
goto:install
:choix
echo 1:oui
echo 2:non
set /p choix=voulez vous mettre a jour:
if %choix% == 1 (goto:wait)
if %choix% == 2 (exit)

:install
start https://drive.google.com/drive/u/0/folders/1vc6ixwv0198Cq1eMO_ITXKyTkt6ZTcTn
echo Waiting for file : install.zip ...

:wait
if exist install.zip (
powershell -command "Expand-Archive -Force .\install.zip .\\"
start install.bat
exit)
goto:wait
