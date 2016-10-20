@echo off
echo UN-INSTALLER SETUP
SET VfiDc=.\TestCert\i386\devcon.exe
SET VfiDiFx=DIFxCmd32.exe
SET VfiCertPath=.\TestCert\certmgrx86
SET Msg1=Win-Xp Uninstallation
SET Msg2=Removing driver for 32-bit OS using 32-bit installer
SET os_ret=true
SET Vx-OS=Vx-8
SET VxInstanceClear=VxInstanceClear32.exe
SET KEY_NAME=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\VeriFoneUSBF
SET VALUE_NAME=VfiMultiDevice
FOR /F "skip=2 tokens=1,2*" %%A IN ('REG QUERY "%KEY_NAME%" /v "%VALUE_NAME%" 2^>nul') DO (
	set MultiDeviceMode=%%C
)
rem main function
call:VfiProcArchDetect
call:VfiDriverInstall %Vx-OS%
goto:eof

rem function  - to detect the processor architecture and set variables
:VfiProcArchDetect

rem find OS 
call OSVer.bat	
IF %osver%==5.1 ( 
	SET Msg1=Win-Xp Uninstallation
	SET Vx-OS=Vx-Xp
)
IF %osver%==5.2 ( 
	SET Msg1=Win-2003 Uninstallation
	SET Vx-OS=Vx-2k3
)
IF %osver%==6.1 ( 
	SET Msg1=Win-7 Uninstallation
	SET Vx-OS=Vx-7
)
IF %osver%==6.2 ( 
	SET Msg1=Win-8 Uninstallation
	SET Vx-OS=Vx-8
)
IF %osver%==6.3 ( 
	SET Msg1=Win-8 Uninstallation
	SET Vx-OS=Vx-8
)

rem find proc arch

IF /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	SET VfiDiFx=DIFxCmd64.exe
	SET VfiCertPath=.\TestCert\certmgrx64
	SET VfiDc=.\TestCert\amd64\devcon.exe
	SET VxInstanceClear=VxInstanceClear64.exe
	SET Msg2=Removing driver for Windows 64-bit OS using 64-bit installer
) ELSE IF /I "%PROCESSOR_ARCHITECTURE%" == "X86" (
	IF /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" (
		SET VfiDiFx=DIFxCmd64.exe
		SET VfiCertPath=.\TestCert\certmgrx64
		SET VfiDc=.\TestCert\amd64\devcon.exe
		SET VxInstanceClear=VxInstanceClear64.exe
		SET Msg2=Removing driver for Windows 64-bit OS using 32-bit installer
	) ELSE (
		rem SET VfiDiFx=DIFxCmd32.exe
		rem SET VfiCertPath=.\TestCert\certmgrx32
		rem SET Msg2=Removing driver for Windows XP-32 OS using 32-bit installer
	)
)
IF %osver%==5.1 ( 
	echo in WIN XP

	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		echo Ver is 5.1 - XP 64-bit
		SET VxInstanceClear=
	) 	ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" ( 
	IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
			echo Ver is 5.1-XP 64-bit
			SET VxInstanceClear=
		)
	) 
) else if %osver%==5.2	(
		SET VxInstanceClear=
)


goto:eof

rem function - which installs driver and test certificates
:VfiDriverInstall
echo %Msg1%
echo %Msg2%

rem %VfiCertPath% -del -c -n "VeriFone Systems Inc" -s -r localMachine Root


%VfiDiFx% /u %~1\VFIUSBF.INF 32
rem echo clean up com ports


%VfiDc% rescan  
set currdir=%CD%
rem echo Removing files from DrvStore...

cd C:\Windows\system32\DRVSTORE

for /D %%f in (VFIUSB*) do rmdir %%f /s /Q

rem echo Removing OEM files...

cd c:\windows\inf
for /f "eol=: delims=" %%F in ('findstr /M VFIUSB-Serial c:\windows\inf\*.inf') do del "%%F"
del c:\windows\system32\drivers\VfiEnmV.sys
del c:\windows\system32\drivers\VFIUSBF.sys

cd %currdir%
echo calling for subinacl
if %osver%==5.1 set os_ret=false
if %osver%==5.2 set os_ret=false
IF "%os_ret%"=="true" (
   takeown /F subinacl.exe >nul
   icacls subinacl.exe /GRANT *S-1-1-0:F >nul

.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0203" /f >nul
cls

.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0206" /f >nul

cls

.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0207" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0208" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0209" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0213" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0216" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0217" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0218" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0219" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0215" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0220" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0221" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0222" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0223" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0224" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0225" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0226" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0227" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0228" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0229" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022A" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022B" /f >nul
cls
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022C" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022D" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_022E" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0230" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0231" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0232" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0235" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\Vid_11ca&Pid_0241" /f >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /setowner=%username% >nul
.\subinacl /subkeyreg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /grant=%username%=F >nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_0525&PID_A4A7" /f >nul
cls

)
%VxInstanceClear%
%VfiDc% rescan  

goto:eof