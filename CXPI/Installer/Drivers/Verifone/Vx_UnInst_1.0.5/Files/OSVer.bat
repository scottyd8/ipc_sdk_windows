@Echo OFF

:: Get windows Version numbers
For /f "tokens=2 delims=[]" %%G in ('ver') Do (set WinVersion=%%G) 
For /f "tokens=2,3,4 delims=. " %%G in ('echo %WinVersion%') Do (set WinMajor=%%G& set WinMinor=%%H& set WinBuild=%%I) 
Echo Major version:%WinMajor%
Echo  Minor Version:%WinMinor%.%WinBuild%
Set osver=%WinMajor%.%WinMinor%
Echo osver=%osver%
