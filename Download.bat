@echo off
title Download : ffmpeg tools batch
if exist install.bat (echo Programme deja telecharger !
timeout 3 /nobreak
exit)
start https://drive.google.com/drive/u/0/folders/1vc6ixwv0198Cq1eMO_ITXKyTkt6ZTcTn
echo Waiting for file : install.zip ...
:wait
if exist install.zip (
powershell -command "Expand-Archive -Force .\install.zip .\\"
start install.bat
exit)
goto:wait