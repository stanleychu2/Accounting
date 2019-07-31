//
//  CashDrawerFunctions.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

#import "AppDelegate.h"

@interface CashDrawerFunctions : NSObject

+ (NSData *)createData:(StarIoExtEmulation)emulation
               channel:(SCBPeripheralChannel)channel;

@end
