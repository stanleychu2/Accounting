//
//  PrinterFunctions.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

#import "AppDelegate.h"

#import "ILocalizeReceipts.h"

@interface PrinterFunctions : NSObject

+ (NSData *)createTextReceiptData:(StarIoExtEmulation)emulation
                 localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                             utf8:(BOOL)utf8;

+ (NSData *)createRasterReceiptData:(StarIoExtEmulation)emulation
                   localizeReceipts:(ILocalizeReceipts *)localizeReceipts;

+ (NSData *)createScaleRasterReceiptData:(StarIoExtEmulation)emulation
                        localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                                   width:(NSInteger)width
                               bothScale:(BOOL)bothScale;

+ (NSData *)createCouponData:(StarIoExtEmulation)emulation
            localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                       width:(NSInteger)width
                    rotation:(SCBBitmapConverterRotation)rotation;

+ (NSData *)createTextBlackMarkData:(StarIoExtEmulation)emulation
                   localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                               type:(SCBBlackMarkType)type
                               utf8:(BOOL)utf8;

+ (NSData *)createPasteTextBlackMarkData:(StarIoExtEmulation)emulation
                        localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                               pasteText:(NSString *)pasteText
                            doubleHeight:(BOOL)doubleHeight
                                    type:(SCBBlackMarkType)type
                                    utf8:(BOOL)utf8;

+ (NSData *)createTextPageModeData:(StarIoExtEmulation)emulation
                  localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                              rect:(CGRect)rect
                          rotation:(SCBBitmapConverterRotation)rotation
                              utf8:(BOOL)utf8;

@end
