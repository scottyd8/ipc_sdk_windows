@echo off
echo UN-INSTALLER SETUP

SET VfiDc=devcon.exe
SET VfiDiFx=DIFxCmd32.exe

SET Msg1=Win-W7 Un-Installation
SET Msg2=
rem SET VfiCertPath=.\TestCert\certmgrx86

SET Vx-OS=Vx-7

call OSVer.bat	

IF %osver%==5.1 ( 
	echo in WIN XP

	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64"	(
		echo Ver is 5.1 - XP 64-bit
		del C:\Windows\system32\DIFxAPI.dll
		copy .\XP64DLL\DIFxAPI.dll C:\Windows\system32\
		difxcmd64.exe /u .\VX-xp\vfiusbf.inf 32
		del C:\Windows\system32\DIFxAPI.dll
	) 	ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" ( 
	IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" 	(
			echo Ver is 5.1-XP 64-bit
			del C:\Windows\system32\DIFxAPI.dll
			copy .\XP64DLL\DIFxAPI.dll C:\Windows\system32\
			difxcmd64.exe /u .\VX-xp\vfiusbf.inf 32
			del C:\Windows\system32\DIFxAPI.dll
		) ELSE (
			echo Ver is 5.1-XP 32-bit
			del C:\Windows\system32\DIFxAPI.dll
			copy .\XP32DLL\DIFxAPI.dll C:\Windows\system32\
			difxcmd32.exe /u .\VX-xp\vfiusbf.inf 32
			del C:\Windows\system32\DIFxAPI.dll
		)
	) 
) else if %osver%==5.2	(

	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		echo Ver is 5.2 XP 64-bit
		del C:\Windows\system32\DIFxAPI.dll
		copy .\XP64DLL\DIFxAPI.dll C:\Windows\system32\
		difxcmd64.exe /u .\VX-xp\vfiusbf.inf 32
		del C:\Windows\system32\DIFxAPI.dll
	) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" (
		IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
			echo Ver is 5.2 XP 64-bit
			del C:\Windows\system32\DIFxAPI.dll
			copy .\XP64DLL\DIFxAPI.dll C:\Windows\system32\
			difxcmd64.exe /u .\VX-xp\vfiusbf.inf 32
			del C:\Windows\system32\DIFxAPI.dll
		)	ELSE 	(
			echo Ver is 5.2 XP 32-bit
			del C:\Windows\system32\DIFxAPI.dll
			copy .\XP32DLL\DIFxAPI.dll C:\Windows\system32\
			difxcmd32.exe /u .\VX-xp\vfiusbf.inf 32
			del C:\Windows\system32\DIFxAPI.dll
		)
	) 
) else if %osver%==6.1 (
	echo OS is W7 
	set Msg1=Win-7 Un-Installation
	set Vx-OS=Vx-7
	set Vx-OS=Vx-7
	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		echo for Windows 7 64-bit OS 
		del C:\Windows\system32\DIFxAPI.dll
		difxcmd64.exe /u .\Vx-7\vfiusbf.inf 32
	) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" (
		IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64"	(
			echo for Windows 64-bit OS 
			del C:\Windows\system32\DIFxAPI.dll
			difxcmd64.exe /u .\Vx-7\vfiusbf.inf 32			
		) ELSE  (
			echo for Windows 32-bit OS using 32-bit installer
			del C:\Windows\system32\DIFxAPI.dll
			difxcmd32.exe /u .\Vx-7\vfiusbf.inf 32
		)  
	)
) 

rem clean up com ports
echo off
for /l %%x in (3, 1, 10) do (
   echo cleaning comport# %%x
   Comreset %%x
)

%VfiDc% rescan

del %VfiDc%
goto:eof
