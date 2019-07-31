//
//  PrinterInfo.h
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StarIO_Extension/StarIoExt.h>

@interface PrinterInfo : NSObject

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
            supportDisconnectBluetooth:(BOOL)supportDisconnectBluetooth;

@property(nonatomic, readonly, nonnull) NSString *title;

@property(nonatomic, readonly) StarIoExtEmulation emulation;

@property(nonatomic, readonly) BOOL cashDrawerOpenActive;

@property(nonatomic, readonly, nonnull) NSString *portSettings;

@property(nonatomic, readonly, nonnull) NSArray<NSString *> *modelNameArray;

@property(nonatomic, readonly) BOOL supportTextReceipt;

@property(nonatomic, readonly) BOOL supportUTF8;

@property(nonatomic, readonly) BOOL supportRasterReceipt;

@property(nonatomic, readonly) BOOL supportCJK;

@property(nonatomic, readonly) BOOL supportBlackMark;

@property(nonatomic, readonly) BOOL supportBlackMarkDetection;

@property(nonatomic, readonly) BOOL supportPageMode;

@property(nonatomic, readonly) BOOL supportCashDrawer;

@property(nonatomic, readonly) BOOL supportBarcodeReader;

@property(nonatomic, readonly) BOOL supportCustomerDisplay;

@property(nonatomic, readonly) BOOL supportMelodySpeaker;

@property(nonatomic, readonly) BOOL supportAllReceipts;

@property(nonatomic, readonly) BOOL supportProductSerialNumber;

@property(nonatomic, readonly) BOOL supportDisconnectBluetooth;

@end
