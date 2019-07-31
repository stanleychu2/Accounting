//
//  PortInfo.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "PrinterInfo.h"

@implementation PrinterInfo

- (nullable instancetype)initWithTitle:(nonnull NSString *)title
                             emulation:(StarIoExtEmulation)emulation
                  cashDrawerOpenActive:(BOOL)cashDrawerOpenActive
                          portSettings:(nonnull NSString *)portSettings
                        modelNameArray:(NSArray<NSString *> * _Nonnull)modelNameArray
                    supportTextReceipt:(BOOL)supportTextReceipt
                           supportUTF8:(BOOL)supportUTF8
                  supportRasterReceipt:(BOOL)supportRasterReceipt
                            supportCJK:(BOOL)supportCJK
                      supportBlackMark:(BOOL)supportBlackMark
             supportBlackMarkDetection:(BOOL)supportBlackMarkDetection
                       supportPageMode:(BOOL)supportPageMode
                     supportCashDrawer:(BOOL)supportCashDrawer
                  supportBarcodeReader:(BOOL)supportBarcodeReader
                supportCustomerDisplay:(BOOL)supportCustomerDisplay
                  supportMelodySpeaker:(BOOL)supportMelodySpeaker
                    supportAllReceipts:(BOOL)supportAllReceipts
            supportProductSerialNumber:(BOOL)supportProductSerialNumber
            supportDisconnectBluetooth:(BOOL)supportDisconnectBluetooth {
    self = [super init];
    if (self) {
        _title = title;
        _emulation = emulation;
        _cashDrawerOpenActive = cashDrawerOpenActive;
        _portSettings = portSettings;
        _modelNameArray = modelNameArray;
        
        _supportTextReceipt = supportTextReceipt;
        _supportUTF8 = supportUTF8;
        _supportRasterReceipt = supportRasterReceipt;
        _supportCJK = supportCJK;
        _supportBlackMark = supportBlackMark;
        _supportBlackMarkDetection = supportBlackMarkDetection;
        _supportPageMode = supportPageMode;
        _supportCashDrawer = supportCashDrawer;
        _supportBarcodeReader = supportBarcodeReader;
        _supportCustomerDisplay = supportCustomerDisplay;
        _supportMelodySpeaker = supportMelodySpeaker;
        _supportAllReceipts = supportAllReceipts;
        _supportProductSerialNumber = supportProductSerialNumber;
        _supportDisconnectBluetooth = supportDisconnectBluetooth;
    }
    
    return self;
}


@end
