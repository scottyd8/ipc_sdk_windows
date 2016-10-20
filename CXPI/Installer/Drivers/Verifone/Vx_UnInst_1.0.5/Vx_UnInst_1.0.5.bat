@echo off

if exist %windir%\system32\subinacl.exe (
del C:\Windows\System32\subinacl.exe
)

pushd "%~dp0"
msiexec /qn /x usb_installvfi32.msi

copy Files\subinacl.exe C:\Windows\system32\

set counter =0
set increment =5

set currdir=%CD%

cd Files

call vfi-clean.bat
cd %currdir%
call Files\OSVer.bat	

echo osver =%osver%


	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64"	(
		SET VfiDc=Files\devcon64.exe
		SET VxInstanceClear=Files\VxInstanceClear64.exe

	) 	ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" ( 
	IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" 	(
			SET VfiDc=Files\devcon64.exe
			SET VxInstanceClear=Files\VxInstanceClear64.exe
		) ELSE (
			SET VfiDc=Files\devcon32.exe
			SET VxInstanceClear=Files\VxInstanceClear32.exe
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

	IF /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		echo Ver is 5.2 XP 64-bit
		SET VxInstanceClear=
	) ELSE IF /I "%PROCESSOR_ARCHITECTURE%"=="X86" (
		IF /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
			echo Ver is 5.2 XP 64-bit
			SET VxInstanceClear=
		)
	) 
)

%VxInstanceClear%

%VfiDc% rescan 
SET VfiDc=Files\devcon32.exe
%VfiDc% rescan 

cls
@echo Cleanup succesfull!! 


