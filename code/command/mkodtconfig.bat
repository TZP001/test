@echo off

setlocal

rem -------------------------------------------------------------------------------------
rem   SHELL DE LANCEMENT DE LA COMMANDE UTILISATEUR  -->   " mkodtconfigM "
rem -------------------------------------------------------------------------------------

set CMD_NAME=mkodtconfigM.exe

set Path=%Path%;%MkmkSHLIB_PATH%
if NOT DEFINED _DEBUG_ %CMD_NAME% %*

