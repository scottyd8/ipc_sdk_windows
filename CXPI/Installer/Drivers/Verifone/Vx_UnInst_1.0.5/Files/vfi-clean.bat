@echo OFF
call OSVer.bat	
echo osver =%osver%
SET os_ret=true

IF NOT EXIST "C:\PROGRAM FILES\VERIFONE\USB DRIVER" goto newvfidriver
echo Old version Present
rem pause
set currdir = %CD%
"C:\PROGRAM FILES\VERIFONE\USB DRIVER\unins000.exe" /SILENT
echo Removing files from DrvStore...
cd C:\Windows\system32\DRVSTORE
for /D %%f in (VFIUSB*) do rmdir %%f /s /Q
echo Removing OEM files...
cd c:\windows\inf
for /f "eol=: delims=" %%F in ('findstr /M VFIUSB-Serial c:\windows\inf\*.inf') do del "%%F"
del c:\windows\system32\drivers\vfienum.sys
del c:\windows\system32\drivers\vfiusbf.sys
goto:regcleaning
goto:enduninstall

:newvfidriver
IF NOT EXIST "C:\PROGRAM FILES\VERIFONE\USB DRIVER VX" goto novfidriver
echo New version Present
rem pause

copy vfi-uninst_patch.bat /Y "C:\PROGRAM FILES\VERIFONE\USB DRIVER VX\vfi-uninst.bat"

echo vfi-unins-patch apply
rem pause 

"C:\PROGRAM FILES\VERIFONE\USB DRIVER VX\unins000.exe" /SILENT
echo Removing files from DrvStore...
cd C:\Windows\system32\DRVSTORE
for /D %%f in (VFIUSB*) do rmdir %%f /s /Q
echo Removing OEM files...
cd c:\windows\inf
for /f "eol=: delims=" %%F in ('findstr /M VFIUSB-Serial c:\windows\inf\*.inf') do del "%%F"
del c:\windows\system32\drivers\VfiEnmV.sys
del c:\windows\system32\drivers\VFIUSBF.sys
rem Added for any residue of old driver present in PC.
del c:\windows\system32\drivers\vfienum.sys

goto:enduninstall

:novfidriver
echo No VeriFone USB Driver found.
rem pause

cd ..
copy Files\unins000.exe unins000.exe
copy Files\unins000.dat unins000.dat
rem rem pause

unins000.exe /SILENT

echo Removing files from DrvStore...
cd C:\Windows\system32\DRVSTORE
for /D %%f in (VFIUSB*) do rmdir %%f /s /Q
echo Removing OEM files...
cd c:\windows\inf
for /f "eol=: delims=" %%F in ('findstr /M VFIUSB-Serial c:\windows\inf\*.inf') do del "%%F"
del c:\windows\system32\drivers\VfiEnmV.sys
del c:\windows\system32\drivers\VFIUSBF.sys
rem Added for any residue of old driver present in PC.
del c:\windows\system32\drivers\vfienum.sys

rem rem pause
rem goto:regcleaning
goto:enduninstall

:regcleaning
echo in regcleaning
if %osver%==5.1 set os_ret=false
if %osver%==5.2 set os_ret=false
echo os_ver=%osver%
echo os_ret=%os_ret%
rem pause
IF "%os_ret%"=="true" (

if exist %windir%\system32\subinacl.exe (
   takeown /F %windir%\system32\subinacl.exe >nul
   icacls %windir%\system32\subinacl.exe /GRANT *S-1-1-0:F >nul
cls   
 Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /f >nul
cls
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /setowner=%username% >nul
Files\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /f >nul

cls
)
)

:enduninstall
echo in enduninstall
rem pause
cd %currdir%

rem rem pause
