@echo off
rem
rem

if "%TEMP%" NEQ "" set VBTtmp=%TEMP%
if "%TMP%" NEQ "" set VBTtmp=%TMP%

set > %VBTtmp%/WSADInitEnv.txt
