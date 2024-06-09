@echo off
rem =======================================
rem TCK Management profile 1.1 
rem Generated by TCK installation procedure 
rem Copyright Dassault-Systemes 2000 
rem =======================================
set ERRORLEVEL=-
set ERRORLEVEL=
if defined TCK_ROOT_PATH @call "%TCK_ROOT_PATH%\TCK\command\tck_unset.bat">nul
rem =======================================
rem Path to the TCK tools, run time os name, installation and run time directories 
set TCKOS_Runtime=intel_a
set TCK_INSTALL_PATH=d:\Program Files (x86)\Dassault Systemes\B21
set TCK_ROOT_PATH=d:\Program Files (x86)\Dassault Systemes\B21\intel_a
rem =======================================
rem Variable to be set for single-user installation
set TCK_NO_SERVER=true
rem =======================================
rem Path to local TCK information directory
set TCK_LOCAL_INFO=C:\Program Files (x86)
rem =======================================
if "%TCK_ROOT_PATH%"=="" goto initfailed
set PATH=%PATH%;%TCK_ROOT_PATH%\TCK\command
goto :EOF
rem =======================================
:initfailed
echo.
echo Variable TCK_ROOT_PATH is not set.
echo Failed to set up environment.
echo.