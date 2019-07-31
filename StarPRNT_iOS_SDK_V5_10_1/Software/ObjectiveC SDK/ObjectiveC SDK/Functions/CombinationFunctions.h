//
//  CombinationFunctions.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

#import "AppDelegate.h"

#import "ILocalizeReceipts.h"

@interface CombinationFunctions : NSObject

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

@end
