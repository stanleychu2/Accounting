//
//  AllReceiptsFunctions.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

#import "AppDelegate.h"

#import "ILocalizeReceipts.h"

@interface AllReceiptsFunctions : NSObject

+ (NSData *)createRasterReceiptData:(StarIoExtEmulation)emulation
                   localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                            receipt:(BOOL)receipt
                               info:(BOOL)info
                             qrCode:(BOOL)qrCode
                         completion:(void (^)(NSInteger statusCode, NSError *error))completion;

+ (NSData *)createScaleRasterReceiptData:(StarIoExtEmulation)emulation
                        localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                                   width:(NSInteger)width
                               bothScale:(BOOL)bothScale
                                 receipt:(BOOL)receipt
                                    info:(BOOL)info
                                  qrCode:(BOOL)qrCode
                              completion:(void (^)(NSInteger statusCode, NSError *error))completion;

+ (NSData *)createTextReceiptData:(StarIoExtEmulation)emulation
                 localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                             utf8:(BOOL)utf8
                            width:(NSInteger)width
                          receipt:(BOOL)receipt
                             info:(BOOL)info
                           qrCode:(BOOL)qrCode
                       completion:(void (^)(NSInteger statusCode, NSError *error))completion;

@end
