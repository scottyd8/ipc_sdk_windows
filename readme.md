#Worldpay Total Windows IPC SDK

The Integrated Payment Client SDK (IPC SDK) for Windows is a wonderful way for you to develop Windows applications that utilize the Worldpay Total APIs. This library takes care of all of the communications with a card reader, freeing you to concentrate on your business logic. Since all of the card data transfer is isolated from you, you never have to worry about EMV certification.

For more information on the Worldpay Total product offering, check out our [getting started] (https://www.worldpay.com/us/developers/apidocs/reference.html) pages.

##Package Layout

**readme.md** - This file in markdown  
**license** - The terms you agree to in using this software 
**WorldpayTotalIPCSetup.exe** - This will install the Windows service and required drivers.
 
##Requirements

| Platform           | Supported Devices|
|:------------------ |:----------------:|
| Windows 7 and later| Verifone VX 805  |
 
##Installation
The Windows IPC SDK is implemented as a Windows Service and accompanying driver for the card reader. These components are installed via the WorldpayTotalIPCSetup.exe file. Please download this file to your machine before attempting to install. You are free to distribute the installer with your application.


###Important: Installing Using the installation file
For now, we are providing a Windows batch file that will install the components as well. You will have a couple of manual steps that are critical to getting things setup.

 1. Download and execute the Worldpay Total IPC installer executable.  Note the file is named "WorldpayTotalIPCSetup.exe."
 2. Click "Next" when the "Welcome to the Worldpay Total Integrated Payment Client Setup Wizard" screen is displayed.
 3. Enter your User Name / Password on the "Login Information" when prompted, then click Next.  Note:  This will be the same user name/password provided to you for logging into Virtual Terminal.  
 4. The next screen will prompt you to enter a unique friendly machine name to identify the computer where the install is being executed.  Enter a name and click "Next."
 5. Read the License Agreement on the next screen, then click "Accept" to accept the agreement.
 6. Click "Install" on the "Ready to Install" screen.
 7. A status bar will display progress while the Worldpay Total IPC is installed.
 8. Note:  You may see another window popup during the install. This popup is the installer for the VX805 USB driver.
 9. If your VX805 is not detected or you have not yet plugged it in, you will see a popup that reads "Vx805" not connected, please reconnect and  retry!"
	a. Plug in your VX805 into a USB port on your computer.  If it is already plugged in to a USB port, disconnect it, then plug it back in.  
	b. IMPORTANT:  Wait until the VX805 is fully booted up and the screen says "VERIFONE/WELCOME."  This may take up to one minute. Click "OK" on the popup window.
	   
 10. Last step displayed beneath the progress bar is "Configuring Terminal."   This can take several minutes.
 11. When complete The "Worldpay Total Integrated Payment Client has been successfully installed" screen is displayed.  You can click the "Readme" icon for more info, or finish to close the installer.


Note: The driver uses com9 for communicating with the card reader. You will need to make sure that this port is available and resolve any conflicts in your installation if not.

##Documentation

The Windows IPC SDK is REST based and uses the same calls and data structures as the non-IPC based REST API. You can find this documentation on the Worldpay [developer portal](https://www.worldpay.com/us/developers/apidocs/getstartrest.html).

When using the REST API documentation, please note two important distinctions:

###1. integrationType
The **developerApplication** object has one additional field called **integrationType**. This field must be set to 1 if you will be using a card reader to receive payments. If not, you can omit this parameter or set it to 0;

**JSON:**  

    developerApplication:  
        {  
        developerId: 12345678,  
        version: '1.2',  
        integrationType: 1  
        }  
When you set the integrationType to 1, you no longer need to fill in the card information. For instance, if you make an *authorize* request, you only need to fill in the *amount* and make the call. The SDK will fill in the rest and send it to the server for processing.


###2. localhost:8081
The endpoint for your transactions is different than the REST documentation. Currently all of the endpoints have the form:  

    https://gwapi.demo.securenet.com/api/Payments/XXX (where xxx is the function)

When using the IPC SDK, the endpoint needs to point to localhost rather than a remote server. You do this by replacing the first part of the url to localhost:8081

    localhost:8081/api/Payments/XXX (where xxx is the function)
    

##Worldpay Total Developer Resources
For information about getting your sandbox account, and comprehensive information about the Integrated Payment Hub REST API, see our developer resources at http://worldpay.us/developer
