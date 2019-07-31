//
//  CashDrawerFunctions.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "CashDrawerFunctions.h"

@implementation CashDrawerFunctions

+ (NSData *)createData:(StarIoExtEmulation)emulation
               channel:(SCBPeripheralChannel)channel {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendPeripheral:channel];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

@end
