//
//  SettingManager.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "SettingManager.h"

#import "PrinterSetting.h"

@implementation SettingManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _settings = [@[[NullPrinterSetting new], [NullPrinterSetting new]] mutableCopy];
    }
    return self;
}

- (void)save {
    NSLog(@"saved: %@", _settings);
    
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:_settings];
    [NSUserDefaults.standardUserDefaults setObject:encodedData forKey:@"settings"];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)load {
    NSData *encodedData = [NSUserDefaults.standardUserDefaults dataForKey:@"settings"];
    if (encodedData != nil) {
        _settings = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    }
    
    NSLog(@"_settings = %@", _settings);
}

@end
