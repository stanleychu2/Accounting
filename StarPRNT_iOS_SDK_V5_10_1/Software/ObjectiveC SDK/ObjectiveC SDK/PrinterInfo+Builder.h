//
//  PrinterInfo+Builder.h
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrinterInfo.h"

#import "ModelCapability.h"

@interface PrinterInfo(Builder)

+ (instancetype)printerInfoWithModelIndex:(ModelIndex)modelIndex;

@end
