//
//  SettingManager.h
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrinterSetting;

@interface SettingManager : NSObject

@property (nonatomic) NSMutableArray<PrinterSetting *> *settings;

- (void)save;

- (void)load;
    
@end
