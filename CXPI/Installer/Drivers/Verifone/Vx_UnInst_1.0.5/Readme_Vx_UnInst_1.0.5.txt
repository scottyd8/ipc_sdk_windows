Vx_UnInst_1.0.5
---------------

This is a VeriFone USB driver Vx-UnInstaller for the following driver versions,

 Vx_1.0.0.30
 Vx_1.0.0.37 B2
 Vx_1.0.0.43 B2
 Vx_1.0.0.43 B3

This utility is provided to clean the previously installed above mentioned VFI VX USB drivers 
and the driver residue present.


Changes added from last release.
--------------------------------

1. Added to support for un-installing with VeriFone USB driver Vx_1.0.0.43 B2 as well.
2. During Installation, Windows OS detection logic has been enhanced to accomodate non English Windows OS as well.
3. Fix provided for the issue that device is not enumerated correctly in VHQ setup , 
   as VHQ holding some of the ports , when driver installed with multidev option.


Usage.
------

1. Make sure to use this utility  (Vx_UnInst_1.0.5.bat) in command prompt with administrative privilege.

	Steps:

	Method1:
		1. Login to PC as System administrator.
		2. Copy the complete folder to any desired location.
		3. Double click on the "Vx_UnInst_1.0.5.bat".


	Method2:
		1. Login to PC as user with user administrator prieveleges.
		2. Copy the complete folder to any desired location.
		3. Right click on the "Vx_UnInst_1.0.5.bat".
		4. click on the "Run as Administrator".

Note:
 This utility will have message boxes which display the cleaning activity.

Recommendations
---------------

1. The folder "C:\Windows\System32" should have full permissions/privileges[Read/Write] for the working user. 

2. This utility can run on standalone PC's.

3. After using this utility, it is highly recommend to restart the PC.

Not to do:
----------

This tool should not be used, if VeriFone Mx, PP1000 Drivers are present in the PC, as their working get affected.
This tool should be used, only if VeriFone Vx driver is present in the PC.