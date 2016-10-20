
@ECHO ON


set SCRIPT_DIR=%~dp0
echo %SCRIPT_DIR%
set SERVICE_EXE_PATH=%SCRIPT_DIR%\CXPI\Installer\Drivers\Verifone

rem set SERVICE_EXE_PATH=%1
rem set PATH=%PATH%;%SERVICE_EXE_PATH%
pushd %SERVICE_EXE_PATH%
pause
rem echo Working Directory %CD%
echo Installing Verifone Drivers...

setup.exe /silent /nonlegacy /com9
echo ---------------------------------------------------
echo Please complete Verifone installation before clicking any key
pause
pushd "%~dp0"
set SCRIPT_DIR=%~dp0
echo %SCRIPT_DIR%
set SERVICE_EXE_PATH=%SCRIPT_DIR%\CXPI
pushd %SERVICE_EXE_PATH%
pause
echo Working Directory %CD%
echo Installing WorldpayTotalIPC...
echo ---------------------------------------------------
WorldpayTotalIPC -INSTALL
echo ---------------------------------------------------
echo Done.
sc start worldpaytotalipc
popd
pause