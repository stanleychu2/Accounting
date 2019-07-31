//
//  Communication.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Communication.h"

#import "AppDelegate.h"

@implementation Communication

+ (BOOL)sendCommands:(NSData *)commands
                port:(SMPort *)port
   completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port beginCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (BeginCheckedBlock)";
                break;
            }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < (uint32_t) commands.length) {
                uint32_t written = [port writePort:commands.bytes :total :(uint32_t) commands.length - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < (uint32_t) commands.length) {
                break;
            }
            
            port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
            
            [port endCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (EndCheckedBlock)";
                break;
            }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommandsDoNotCheckCondition:(NSData *)commands
                                   port:(SMPort *)port
                      completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < (uint32_t) commands.length) {
                uint32_t written = [port writePort:(unsigned char *) commands.bytes :total :(uint32_t) commands.length - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < (uint32_t) commands.length) {
                break;
            }
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)parseDoNotCheckCondition:(ISCPParser *)parser
                            port:(SMPort *)port
               completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    NSData *commands = [parser createSendCommands];
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < (uint32_t) commands.length) {
                uint32_t written = [port writePort:(unsigned char *) commands.bytes :total :(uint32_t) commands.length - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < (uint32_t) commands.length) {
                break;
            }
            
            startDate = [NSDate date];     // Restart
            
            NSMutableData *receivedData = [NSMutableData data];
            
            while (YES) {
                uint8_t buffer[1024 + 8] = {0};
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 1.0) {     // 1000mS!!!
                    title   = @"Printer Error";
                    message = @"Read port timed out";
                    break;
                }
                
                [NSThread sleepForTimeInterval:0.01];     // Break time.
                
                uint32_t readLength = [port readPort:buffer :0 :1024];
                
                if (readLength == 0) {
                    continue;
                }
                
                [receivedData appendBytes:buffer length:readLength];
                
                int recvDataLength = (int) receivedData.length;
                
                uint8_t *recvDataBytes = (uint8_t *) receivedData.bytes;

                if (parser.completionHandler(recvDataBytes, &recvDataLength) == StarIoExtParserCompletionResultSuccess) {
                    title   = @"Send Commands";
                    message = @"Success";
                    
                    result = YES;
                    break;
                }
            }
            
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommands:(NSData *)commands
            portName:(NSString *)portName
        portSettings:(NSString *)portSettings
             timeout:(NSInteger)timeout
   completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :(uint32_t) timeout];
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port beginCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (BeginCheckedBlock)";
                break;
            }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < (uint32_t) commands.length) {
                uint32_t written = [port writePort:(unsigned char *) commands.bytes :total :(uint32_t) commands.length - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < (uint32_t) commands.length) {
                break;
            }
            
            port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
            
            [port endCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (EndCheckedBlock)";
                break;
            }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommandsDoNotCheckCondition:(NSData *)commands
                               portName:(NSString *)portName
                           portSettings:(NSString *)portSettings
                                timeout:(NSInteger)timeout
                      completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :(uint32_t) timeout];
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < (uint32_t) commands.length) {
                uint32_t written = [port writePort:(unsigned char *) commands.bytes :total :(uint32_t) commands.length - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < (uint32_t) commands.length) {
                break;
            }
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (void)sendCommandsForPrintReDirectionWithCommands:(NSData *)commands
                                            timeout:(uint32_t)timeout
                                         completion:(void (^)(BOOL, NSString *))completionHandler {
    BOOL result = NO;

    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    SMPort *port = nil;
    
    NSMutableString *resultString = [NSMutableString string];
    
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    
    for (NSUInteger i = 0; i < appDelegate.settingManager.settings.count; i++) {
        PrinterSetting *setting = appDelegate.settingManager.settings[i];
        
        NSString *portName = setting.portName;
        NSString *portSettings = setting.portSettings;
        
        @try {
            while (YES) {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
 //             port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :(uint32_t) timeout];
                port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
                
                if (port == nil) {
                    message = @"Fail to Open Port";
                    break;
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                NSOperatingSystemVersion version = {11, 0, 0};
                BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
                if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                    [NSThread sleepForTimeInterval:0.2];
                }
                
                StarPrinterStatus_2 printerStatus;
                
                [port beginCheckedBlock:&printerStatus :2];
                
                if (printerStatus.offline == SM_TRUE) {
                    message = @"Printer is offline (BeginCheckedBlock)";
                    break;
                }
                
                NSDate *startDate = [NSDate date];
                
                uint32_t total = 0;
                
                while (total < (uint32_t) commands.length) {
                    uint32_t written = [port writePort:(unsigned char *) commands.bytes :total :(uint32_t) commands.length - total];
                    
                    total += written;
                    
                    if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                        message = @"Write port timed out";
                        break;
                    }
                }
                
                if (total < (uint32_t) commands.length) {
                    break;
                }
                
                port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
                
                [port endCheckedBlock:&printerStatus :2];
                
                if (printerStatus.offline == SM_TRUE) {
                    message = @"Printer is offline (EndCheckedBlock)";
                    break;
                }
                
                message = @"Success";
                
                result = YES;
                break;
            }
        }
        @catch (PortException *exc) {
            message = @"Write port timed out (PortException)";
        }
        @finally {
            if (port != nil) {
                [SMPort releasePort:port];
                
                port = nil;
            }
        }

        NSString *categoryTitle = (i == 0) ? @"[Destination]" : @"[Backup]";
        [resultString appendFormat:@"%@\n", categoryTitle];
        [resultString appendFormat:@"Port Name: %@\n", portName];
        [resultString appendFormat:@"%@\n\n", message];
        
        if (result == YES) {
            break;
        }
    }
    
    if (completionHandler != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(result, resultString);
        });
    }
}

+ (void)connectBluetooth:(SendCompletionHandler)completionHandler {
    [[EAAccessoryManager sharedAccessoryManager] showBluetoothAccessoryPickerWithNameFilter:nil completion:^(NSError *error) {
        BOOL result;
        
        NSString *title   = @"";
        NSString *message = @"";
        
        if (error != nil) {
            NSLog(@"Error:%@", error.description);
            
            switch (error.code) {
                case EABluetoothAccessoryPickerAlreadyConnected :
                    title   = @"Success";
                    message = @"";
                    
                    result = YES;
                    break;
                case EABluetoothAccessoryPickerResultCancelled :
                case EABluetoothAccessoryPickerResultFailed    :
                    title   = nil;
                    message = nil;
                    
                    result = NO;
                    break;
                default                                       :
//              case EABluetoothAccessoryPickerResultNotFound :
                    title   = @"Fail to Connect";
                    message = @"";
                    
                    result = NO;
                    break;
            }
        }
        else {
            title   = @"Success";
            message = @"";
            
            result = YES;
        }
        
        if (completionHandler != nil) {
            completionHandler(result, title, message);
        }
    }];
}

+ (BOOL)disconnectBluetooth:(NSString *)modelName
                   portName:(NSString *)portName
               portSettings:(NSString *)portSettings
                    timeout:(NSInteger)timeout
          completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            if ([modelName hasPrefix:@"TSP143IIIBI"]) {
                unsigned char commandBytes[] = {0x1b, 0x1c, 0x26, 0x49};     // Only TSP143IIIBI
                
                StarPrinterStatus_2 printerStatus;
                
                [port beginCheckedBlock:&printerStatus :2];
                
                if (printerStatus.offline == SM_TRUE) {
                    title   = @"Printer Error";
                    message = @"Printer is offline (BeginCheckedBlock)";
                    break;
                }
                
                NSDate *startDate = [NSDate date];
                
                uint32_t total = 0;
                
                while (total < sizeof(commandBytes)) {
                    uint32_t written = [port writePort:commandBytes :total :sizeof(commandBytes) - total];
                    
                    total += written;
                    
                    if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                        title   = @"Printer Error";
                        message = @"Write port timed out";
                        break;
                    }
                }
                
                if (total < sizeof(commandBytes)) {
                    break;
                }
                
//              port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
//
//              [port endCheckedBlock:&printerStatus :2];
//
//              if (printerStatus.offline == SM_TRUE) {
//                  title   = @"Printer Error";
//                  message = @"Printer is offline (EndCheckedBlock)";
//                  break;
//              }
            }
            else {
                if ([port disconnect] == NO) {
                    title   = @"Fail to Disconnect";
                    message = @"Note. Portable Printers is not supported.";
                    break;
                }
            }
            
            title   = @"Success";
            message = @"";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)confirmSerialNumber:(NSString *)portName
               portSettings:(NSString *)portSettings
                    timeout:(NSInteger)timeout
          completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :(uint32_t) timeout];
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            unsigned char commandBytes[] = {0x1b, 0x1d, ')', 'I', 0x01, 0x00, 49};     // <ESC><GS>')''I'pLpHfn
            
            while (total < sizeof(commandBytes)) {
                uint32_t written = [port writePort:commandBytes :total :sizeof(commandBytes) - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >=  3.0) {     //  3000mS!!!
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
            }
            
            if (total < sizeof(commandBytes)) {
                break;
            }
            
            NSString *information = nil;
            
            NSMutableData *receivedData = [NSMutableData data];
            
            while (YES) {
                uint8_t readBuffer[1024 + 8] = {0};
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >=  3.0) {     //  3000mS!!!
                    title   = @"Printer Error";
                    message = @"Can not receive information";
                    break;
                }
                
                [NSThread sleepForTimeInterval:0.01];     // Break time.
                
                @try {
                    uint32_t readLength = [port readPort:readBuffer :0 :1024];
                    
                    if (readLength == 0) {
                        continue;
                    }
                    
                    [receivedData appendBytes:readBuffer length:readLength];
                }
                @catch (NSException *exception) {
                    @throw exception;
                }
                
                if (receivedData.length >= 2) {
                    for (int i = 0; i <= receivedData.length - 2; i++) {
                        if (readBuffer[i + 0] == 0x0a &&
                            readBuffer[i + 1] == 0x00) {
                            for (int j = 0; j <= receivedData.length - 9; j++) {
                                if (readBuffer[j + 0] == 0x1b &&
                                    readBuffer[j + 1] == 0x1d &&
                                    readBuffer[j + 2] == ')'  &&
                                    readBuffer[j + 3] == 'I'  &&
                                    readBuffer[j + 6] == 49) {
                                    information = [NSString stringWithCString:(const char *) &readBuffer[j + 7]
                                                                     encoding:NSASCIIStringEncoding];
                                    
                                    result = YES;
                                    break;
                                }
                            }
                            
                            break;
                        }
                    }
                }
                
                if (result == YES) {
                    break;
                }
            }
            
            if (result == NO) {
                break;
            }
            
            result = NO;
            
            NSRange range = [information rangeOfString:@"PrSrN="];
            
            if (range.location == NSNotFound) {
                title   = @"Printer Error";
                message = @"Can not receive tag";
                break;
            }
            
            NSString *work = [information substringFromIndex:range.location + range.length];
            
            range = [work rangeOfString:@","];
            
            if (range.location != NSNotFound) {
                work = [work substringToIndex:range.location];
            }
            
            title   = @"Product Serial Number";
            message = work;
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exception) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

@end
