@echo off

setlocal

set CNEXT_LEVEL=%MkmkMACRO_LEVEL%\CNEXTLVL
set LEVEL=%MkmkMACRO_LEVEL%\LEVEL
set OS_LEVEL=%MkmkMACRO_LEVEL%\Windows_NT
set CMD_NAME=ITSiteManagerM

set CATReferenceSettingPath=

call StdMKMKCommand %*

