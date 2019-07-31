************************************************************
      StarPRNT SDK Ver 5.10.1
         Readme_En.txt             Star Micronics Co., Ltd.
************************************************************

 1. Overview
 2. Ver 5.10.1 Changes
 3. Contents
 4. Scope
 5. Limitation
 6. Copyright
 7. Release History

=============
 1. Overview
=============

  This package contains StarPRNT SDK Ver 5.10.1.
  StarIO/StarIO_Extension/SMCloudServices is a library for supporting to develop
  application for Star printers.

  Supported OS  :  iOS 8.0 - iOS 12.3

  Refer to help document including this package for details.


======================
 2. Ver 5.10.1 Changes
======================

  [StarIO]
    - Fixed Bugs
      * Fixed an issue that the app may crash when repeatedly executing the
        connectAsync method with LAN interface for a printer that does not exist
        in network.

  [StarIOExtension]
    - Fixed Bugs
      * Fixed an issue that the app may crash when repeatedly executing the
        connectAsync method with LAN interface for a printer that does not exist
        in network.
    - Fixed Bugs
      * Fixed the memory leak occurred when executing createBcrConnectParser,
        createDisplayConnectParser or createMelodySpeakerConnectParser method.


=============
 3. Contents
=============

  StarPRNT_iOS_SDK_V5_10_1
  |- Readme_En.txt                          // Release Notes (English)
  |- Readme_Jp.txt                          // Release Notes (Japanese)
  |- SoftwareLicenseAgreement_En.pdf        // Software License Agreement (English)
  |- SoftwareLicenseAgreement_Jp.pdf        // Software License Agreement (Japanese)
  |
  +- Documents
  |  |- StarPRNT_iOS_SDK_En.pdf             // StarPRNT SDK Document (English)
  |  |- StarPRNT_iOS_SDK_Jp.pdf             // StarPRNT SDK Document (Japanese)
  |  |- CommandEmulator_on_SMCS_En.pdf      // Supported command list of Command Emulator on SMCS (English)
  |  +- CommandEmulator_on_SMCS_Jp.pdf      // Supported command list of Command Emulator on SMCS (Japanese)
  |
  +- Software
  |  |- Distributables
  |  |  |- StarIO.framework                 // StarIO.framework (Ver 2.5.5)
  |  |  |- StarIO_Extension.framework       // StarIO_Extension.framework (Ver 1.13.1)
  |  |  +- SMCloudServices.framework        // SMCloudServices.framework (Ver 1.5)
  |  |
  |  |- ObjectiveC SDK                      // Samples (Ver 5.10.1)
  |  +- Swift SDK                           // Samples (Ver 5.10.1)
  |
  +- Others
     +- StarSoundConverter                  // Tools for converting sound format for melody speaker (Ver 1.0.0)


==========
 4. Scope
==========

  Please refer to the StarPRNT SDK document about the supported printers.

  Works with these Emulation:
     - StarPRNT Mode
     - Star Line Mode
     - Star Graphic Mode
     - ESC/POS
     - ESC/POS Mobile
     - Star Dot Impact

       Please refer to each command specification for details.
       You can download this manual from Star web site.


===============
 5. Limitation
===============

  1. Notification in case of SM-L Series
     It could take some time when an iOS device tries to connect to a printer via "Bluetooth Low Energy".
     Refer to the "getPort API" section on the StarPRNT SDK document for details.

  2. When using printer with Bluetooth Interface, please do not change the memory switch setting of "ASB Status" 
     from default value(invalid). (Bank 7/Bit C)
 
  3. In iOS 10.0 - 10.2.1 and 11.0 - 11.2.2, when using a Bluetooth printer, in rare cases, an error occurs
     when getPort, begin / endCheckedBlock is called, and thereafter the printer can not be discovered by
     the searchPrinter API. At this time, "Connected" is displayed in "Settings" - "Bluetooth", but the
     printer will not be displayed in "General" - "Information".

        [Restoration Method]
        Power off the printer once, or disconnect and reconnect Bluetooth from "Setting" app.

  4. It has been reported that the following models go out of service after getting unable to be 
     recognized by applications when "releasePort" is executed before all of a large volume data using 
     "writePort" is completely sent to the printer:

     - SM-S210i (Firmware 3.1 or higher)
     - SM-S230i (Firmware 1.3)
     - SM-T300i (Firmware 3.1 or higher)
     - SM-T400i (Firmware 3.1 or higher)

     The following product also may lose Bluetooth connection in the same condition.

     - mPOP

     (the issue is already reported to Apple)

     StarPRNT SDK loops writePort until the data is completely sent in sendCommands method included in 
     the Communication class but it is designed to make releasePort in case that it fails to send all
     the data within the designated time and in the result the above issue can happen.

     In order to eliminate the issue, please designate a proper length of time enough to complete the 
     print data sending, if you prefer your application to make the above procedure.

     For your information, if the printer goes out of service, you can shut down the connection on 
     the "Bluetooth" window of the setting screen and connect again, then the printer will come back. 

     Even if Bluetooth loses connection, with the Auto Connection function enabled, the connection 
     will be recovered automatically. Otherwise you will have to re-connect manually on the iOS "setting" window.

  5. In iOS 11, set sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
     Under our test environment, 0.2 sec sleep time is enough to avoid this problem.
     The appropriate sleep time is different depending on the environment.
     Please check under your own environment and set appropriate time for each environment.

  6. The libraries in this package are built in Xcode 10.1.
     If your application or library is built in other version of Xcode, and the version of Bitcode
     is different from ours, a problem may occur in application Archive.

     In this case, check Xcode version number, and use same version of Xcode as ours, or invalid Bitcode.
     You can change Bitcode settings from project setting,
     “Build Settings” - “Build Options” - “Enable Bitcode” setting.
     Change it to “No”.
  
  7. Precaution related to compatibility
     Beginning from StarPRNT SDK v5.6.0, the readPort behavior when a
     LAN printer is used has been changed as shown below.
     When the data that should be received when readPort is executed does not exist

     - v5.5.0 and before: Throws a PortException.
     - v5.6.0 and later: Returns 0.
 
     If your application uses “Throws a PortException”, change it to “Returns 0”.

  8. If mC-Sound was connected after the printer power was turned ON, melody speaker API does not work properly.
     Please turn on the printer after connecting mC-Sound to it.

  9. For users of Ethernet/Wireless LAN interface with mC-Print2/3, TSP100LAN, and TSP100IIILAN/W:
     To avoid a problem which sometimes fail getPort with Ethernet interface, the appropriate
     portSettings argument of getPort method is required.
     Under our test environment, the setting of argument to ";l1000" can avoid this problem.
     The appropriate argument is different depending on the environment. 
     Please check under your own environment and set the appropriate argument.


==============
 6. Copyright
==============

  Copyright 2016-2019 Star Micronics Co., Ltd. All rights reserved.


====================
 7. Release History
====================

  Ver.5.10.1
   2019/05/23 : [StarIO]
                 - Fixed Bugs
                   * Fixed an issue that the app may crash when repeatedly executing the
                     connectAsync method with LAN interface for a printer that does not exist
                     in network.

                [StarIOExtension]
                 - Fixed Bugs
                   * Fixed an issue that the app may crash when repeatedly executing the
                     connectAsync method with LAN interface for a printer that does not exist
                     in network.
                 - Fixed Bugs
                   * Fixed the memory leak occurred when executing createBcrConnectParser,
                     createDisplayConnectParser or createMelodySpeakerConnectParser method.

  Ver.5.10.0
   2019/03/07 : [StarIO]
                 - Improvement
                   * Reduce the waiting time to start printing for Bluetooth printers
                     (except SM-L200 and SM-L300) in StarLine and StarPRNT emulation.

                [StarIOExtension]
                 - Added features
                   * Added appendCjkUnifiedIdeographFont method.
                     It allows you to specify the priority of CJK integrated Kanji font in UTF-8.
                     Supported printer: TSP650II(JP2/TW) with firmware version 4.0 or later,
                     mC-Print2 and mC-Print3
                   * Added ExtMode which specifies the barcode mode (symbol width) conforming to
                     each command specification to SCBBarcodeWidth.
                 - Fixed Bugs
                   * On the LAN interface, SMResultCodeInUseError may be returned if you try to
                     connect to a device other than Star printer via the connectAsync method of
                     the StarIoExtManager class.
                     Fixed to return SMResultCodeFailedError.
                   * Fixed a bug that the appendBitmap method may append garbage data at the end
                     of graphic in StarLine emulation.
                   * Fixed a bug that the print start position on the horizontal axis is not set
                     to the head of the line even if 0 is specified for the position in the
                     appendBitmapWithAbsolutePosition method in page mode.

                [Objective-C SDK and Swift SDK]
                 - Changed sample code
                   * Changed the implementation of printing the sample of CJK unified ideographs
                     in UTF-8 to use the appendCjkUnifiedIdeographFont method.

  Ver.5.9.2
   2018/12/17 : [StarIO]
                 - getPort API
                   * Improve connectivity when continuously connecting via Ethernet/Wireless LAN
                     interface with mC-Print2/3, TSP100LAN, and TSP100IIILAN/W. 

                [StarIOExtension]
                 - Fixed a bug
                   * Fixed a bug that the didAccessoryDisconnect method of the StarIoExtManagerDelegate
                     protocol might be called even though the target printer is not disconnected after
                     the connect method of the StarIoExtManager class was called.

  Ver.5.9.1
   2018/11/28 : [StarIO]
                 - Bug Fix.
                   * Fixed an issue that build failed due to duplicated symbol error
                     when -all_load is set in Other Linker Flags of Build Settings.

  Ver.5.9.0
   2018/11/20 : [StarIO]
                 - Added features.
                   * Added some log output.
                 - Bug Fix.
                   * Fixed a bug that the getPort method may not wait until specified timeout
                     on the LAN interface even though the "l" option is set.

                [StarIOExtension]
                 - Added features.
                   * Added API for Melody Speaker control.
                 - Bug Fix.
                   * Fixed a bug that the error code returned by the didFailToConnectPort method might be incorrect.

                [SDK]
                 - Add Sample Code.
                   * Added sample codes for Melody Speaker control.

  Ver.5.8.0
   2018/10/18 : [StarIO]
                 - Added log function.

                [StarIOExtension]
                 - Added log function.
                 - Added 'connectAsync' method to StarIoExtManager class.
                 - Bug Fix:
                   - [Bluetooth, Lightning]
                     When the connect method is executed and the printer is turned on / off, 
                     some events may not occur.
                
                [StarPRNT SDK]
                 - Added Xcode 10 support.
                 - Added sample code of connectAsync API.
                 - Bug Fix:
                   - When the barcode reader is set to add LF to the scanned data, 
                     the application crashes after scanning the barcode.

  Ver.5.7.0
   2018/06/29 : [StarIO]
                - Fixed the Objective-C API which caused an application crash when called 
                  from Swift, so that it cannot be called from Swift.
                - Bug Fix:
                  - In case of using mC-Print with LAN interface, beginCheckBlock failed 
                    if it was used while a printer was in error condition.
                  - Garbage data was sometimes attached at the end of the return value 
                    by getFirmwareInformation method.
                  - The application sometimes crashed while getting data from barcode reader.

               [StarIOExtension]
                - End of support
                  - StarIoExt class
                    - createScaleCommandBuilder Method
                    - createScaleConnectParser Method
                    - createScaleWeightParser Method
                  - StarIoExtScaleModel Constants
                  - ISSCBBuilder class
                  - ISCPParser class
                    - createReceiveCommands Method
                  - ISSCWeightParser class
  
                [SMCloudServices]
                - Added features
　                - SMCloudServices.ShowRegistrationWindow Method
                    When the password of SCS dash board is changed, you can update local password too.
 
                [SDK]
                - Added sample codes for Print Re-Direction.
                - Changed UIAlertView to UIAlertController.
                
  Ver.5.6.0
   2018/05/21 : [StarIO]
                - Added features
                  - Added mC-Print2 and mC-Print3.
                  - Added options to portSettings of getPort method.
                  - Added the connectedInterface property to starPrinterStatus structure.
                - getPort API
                  - Change the behavior of getPort method for specify ESC/POS emulation.
                    Before : portName specified "TCP: xxx" and portSettings contains "portable".
                    After :  portName specified "TCP: xxx" and portSettings contains "portable" and “escpos”.
                  - Added a feature to specify the serial number of the printer after "BT:", "USB:" of portName.
                - readPort API
                  - Change the behavior of readPort method if there was no data to receive in the ethernet interface.
                    Before : Method throws the exception.
                    After: Method returns success.
                - Fixed Bugs:
                  - Fixed a bug that communication fails immediately after the printer returns from an error on the USB interface.
                  - Fixed a bug that apply: method of SMBluetoothManager class returns NO (failed) despite it success on the StarPRNT emulation.
                  - Fixed a bug that caused a link error with other companies libraries.

                [StarIOExtension]
                - Added features
                  - Added method for setting top margin.
                  - Added method for setting printable area.
                  - Added drive time parameter and delay time parameter to the appendSound method.

  Ver.5.5.0
   2018/02/06 : [StarIO]
                  - Changed to be able to get the firmware version of TSP100IIILAN and TSP100IIIW
                    with the getFirmwareInformation method.
                  - Fixed a bug that when TSP100IIIU and TSP100IIIBI are connected to iOS device
                    at the same time, printing may be performed from TSP100IIIU despite printing to
                    TSP100IIIBI.
                  - Changed to return an error by detecting the disconnection on Bluetooth and USB
                    interfaces in the getParsedStatus, beginCheckedBlock and endCheckedBlock methods.

                [StarIO_Extension.framework]
                  - Added method for setting or clearing horizontal tab.

                [Objective-C SDK and Swift SDK]
                  - Added Sample Codes.
                    * Implementation of the CJK unified ideographs printing sample under UTF-8.
                      (Supported by TSP650II(JP2/TW) with firmware version 4.0 or later only)

  Ver.5.4.1
   2017/10/20 : [Support OS]
                  - Added iOS 11 Support.
                  
                [StarIO.framework]
                  - Improved reliability of BLE 's getPort method.
                  - [ESC/POS mode + LAN] Bug Fix: When a printer error occurs during printing, 
                    the endCheckedBlock API throws an exception.

                [StarIO_Extension.framework]
                  - iOS 11
                    - Bug Fix: Printer may not be recognized.

                [SMCloudServices.framework]
                  - iOS 11
                    - Bug Fix: The close button is displayed larger than the original size

		[Objective-C SDK and Swift SDK]
                  - iOS 11
                    - Bug Fix: Printer may not be recognized.
                    - Bug Fix: Crash when you set the in-flight mode while printing on partial screen.
                  - Changed to show "Print photo from Library" and "Print Photo by Camera" when SP700 is selected.
                  - Enabled "Pairing and Connect Bluetooth" when printer is not selected.

  Ver.5.4.0
   2017/08/16 : [Support OS]
                  - Supported OS version: 8.0 or later.

                [StarIO]
                  - Improved communication reliability with SM-T300DW.
                  
                [StarIO_Extension.framework]
                  - Added API for Scale, Display control
                  - Added graphic data compression function for SM-L series.

                [Objective-C SDK and Swift SDK]
                  - Added sample codes for getting serial number, Firmware version and Framework version,
                    and setting Bluetooth.

                [Swift SDK]
                  - Changed the Bundle ID from jp.star-m.Swift-SDK to jp.star-m.stariosdk.
                    If you have already installed Ver 5.3.0, Ver 5.4.0 will be installed as the other app. 

  Ver.5.3.0
   2017/04/03 : [StarIO]
                  - Added support of TSP100IIIU and SM-L300(Bluetooth Low Energy).
                  - The performance when the getPort method failed on Ethernet was improved.

                [Objective-C SDK and Swift SDK]
                  - Add Sample Code.
                    * Implementation of BlackMark and PageMode.

                [Swift SDK]
                  - Supported Swift3.

  Ver.5.2.1
   2017/02/08 : [StarIO]
                  - Bug Fix.
                    * Fixed bluetooth communication failure with portable printer when portable printer is ESC/POS and in Sniff Mode.

  Ver.5.2.0
   2017/01/19 : [StarIO]
                  - Bug Fix.
                    * The apply method in SMBluetoothManager class is failed to perform for mobile printer and mPOP.
                    * Debug communication failure while Bluetooth printer in Sniff Mode.
                  - iOS 9
                    * Debug failure in API which was generated after getPort.
                  - iOS 10
                    * Fixed problem in SM-S210i, SM-S220i, SM-T300i and SM-T400i, when Raster data is printed out
                      printing succeeds at the first time, but failed from the second time.
                    * Fixed problem in SM-L200, when getPort is performed immediately after releasePort, it takes time to
                      connect an it fails in the connection according to the value of time out.

                [StarIO_Extension]
                  - Bug Fix.
                    * Modify both of connect/disconnect method in StarIoExtManager class, not be reentrant.

                [SMCloudServices]
                  - Version up.
                    * Added the uploadData method to the SMCSAllReceipts class.
                      Data which is transmitted by uploadData method is rendered to digital receipt image by Command Emulator on SMCS.
                      Refer to "CommandEmulator_on_SMCS_En.pdf" for details.
                    * Added the MicroReceipt function.
                      MicroReceipts function would be  helpful of reduce a running paper cost.

                [Objective-C SDK and Swift SDK]
                  - Add Sample Code.
                    * Implementation of the AllReceipts support on StarPRNT, StarLine and ESC/POS.
                    * Implementation of USB peripherals (2D barcode reader and scale) available at mPOP.
                  - Add supported command lists of AllReceipts command emulator.

  Ver.5.0.2
   2016/08/25 : [StarIO]
                  - Fixed an issue where the connected property and getOnlineStatus method does not work
                    in the mobile printer that is set to StarPRNT emulation.

  Ver.5.0.1
   2016/08/11 : [Objective-C SDK and Swift SDK]
                  - Add Sample Code.
                    * Printing of camera and photo library.
                    * Bluetooth connection and disconnection.
                    * Manual input of the port name and port settings.
                    * Selection of the opening and closing sensor of the cash drawer.
                    * Confirmation of device status.
                    * Sample print of German.
                    * Implementation of the application state transition.

                [StarIO.framework]
                  - Version up.
                    * Modification API.

                [StarIO_Extension.framework]
                  - Bug Fix.
                    * Measures to the repeated calls of the connection and disconnection.

                [SMCloudServices.framework]
                  - Version up.
                    * Modification API.

  Ver.5.0.0
   2016/03/28 : First release.
