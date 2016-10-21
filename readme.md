#Worldpay Total Windows IPC SDK (BETA)
The Integrated Payment Client SDK (IPC SDK) for Windows is a wonderful way for you to develop Windows applications that utilize the Worldpay Total APIs. This library takes care of all of the communications with a card reader, freeing you to concentrate on your business logic. Since all of the card data transfer is isolated from you, you never have to worry about EMV certification.

For more information on the Worldpay Total product offering, check out our [getting started] (https://www.worldpay.com/us/developers/apidocs/reference.html) pages.

##Package Layout

**readme.md** - This file in markdown  
**license** - The terms you agree to in using this software 
**WorldpayMW_Service_Install.bat** - This will install the Windows service and drivers required.
**/docs** - Directory containing any application notes or deeper level of documentation  
**/cxpi** - This includes the installer for the SDK.  
**/sampleApp** - This will contain any sammple applications and coding examples
 
##Requirements

| Platform           | Supported Devices|
|:------------------ |:----------------:|
| Windows 8 and later| Verifone VX 805  |
 
##Installation
The Windows IPC SDK is implemented as a Windows Service and accompanying driver for the card reader. These components are located in the /cxpi directory and should be downloadd to your machine before installing.

We will soon be providing a full fledged installer executable that will perform this task for you. You are free to distribute the installer with your application. We also provide a Windows batch file (**WorldpayMW\_Service\_Install.bat**), located in the root directory of this repository) that will install the components as well. This allows you the freedfom in incorporate the files into your own installer when the time comes.

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
