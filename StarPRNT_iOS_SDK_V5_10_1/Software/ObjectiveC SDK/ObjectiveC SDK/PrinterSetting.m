//
//  PrinterSetting.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "PrinterSetting.h"


@implementation PrinterSetting

- (instancetype)initWithPortName:(NSString *)portName
                    portSettings:(NSString *)portSettings
                       modelName:(NSString *)modelName
                      macAddress:(NSString *)macAddress
                       emulation:(StarIoExtEmulation)emulation
        cashDrawerOpenActiveHigh:(BOOL)cashDrawerOpenActiveHigh
             allReceiptsSettings:(NSInteger)allReceiptsSettings
               selectedPaperSize:(NSInteger)selectedPaperSize
              selectedModelIndex:(NSInteger)selectedModelIndex {
    self = [super init];
    if (self) {
        _portName = portName;
        _portSettings = portSettings;
        _modelName = modelName;
        _macAddress = macAddress;
        _emulation = emulation;
        _cashDrawerOpenActiveHigh = cashDrawerOpenActiveHigh;
        _allReceiptsSettings = allReceiptsSettings;
        _selectedPaperSize = selectedPaperSize;
        _selectedModelIndex = selectedModelIndex;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _portName = [aDecoder decodeObjectForKey:@"portName"];
        _portSettings = [aDecoder decodeObjectForKey:@"portSettings"];
        _modelName = [aDecoder decodeObjectForKey:@"modelName"];
        _macAddress = [aDecoder decodeObjectForKey:@"macAddress"];
        _emulation = [aDecoder decodeIntegerForKey:@"emulation"];
        _cashDrawerOpenActiveHigh = [aDecoder decodeBoolForKey:@"cashDrawerOpenActiveHigh"];
        _allReceiptsSettings = [aDecoder decodeIntegerForKey:@"allReceiptsSettings"];
        _selectedPaperSize = [aDecoder decodeIntegerForKey:@"selectedPaperSize"];
        _selectedModelIndex = [aDecoder decodeIntegerForKey:@"selectedModelIndex"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_portName forKey:@"portName"];
    [aCoder encodeObject:_portSettings forKey:@"portSettings"];
    [aCoder encodeObject:_modelName forKey:@"modelName"];
    [aCoder encodeObject:_macAddress forKey:@"macAddress"];
    [aCoder encodeInteger:_emulation forKey:@"emulation"];
    [aCoder encodeBool:_cashDrawerOpenActiveHigh forKey:@"cashDrawerOpenActiveHigh"];
    [aCoder encodeInteger:_allReceiptsSettings forKey:@"allReceiptsSettings"];
    [aCoder encodeInteger:_selectedPaperSize forKey:@"selectedPaperSize"];
    [aCoder encodeInteger:_selectedModelIndex forKey:@"selectedModelIndex"];
}

- (BOOL)isNull {
    return NO;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"{%@, %@, %@, %@, %@, %@, %@, %@, %@}",
                             [NSString stringWithFormat:@"portName: %@", _portName],
                             [NSString stringWithFormat:@"portSettings: %@", _portSettings],
                             [NSString stringWithFormat:@"modelName: %@", _modelName],
                             [NSString stringWithFormat:@"macAddress: %@", _macAddress],
                             [NSString stringWithFormat:@"emulation: %ld", (long)_emulation],
                             [NSString stringWithFormat:@"cashDrawerOpenActiveHigh: %d", _cashDrawerOpenActiveHigh],
                             [NSString stringWithFormat:@"allReceiptsSettings: %ld", (long)_allReceiptsSettings],
                             [NSString stringWithFormat:@"selectedPaperSize: %ld", (long)_selectedPaperSize],
                             [NSString stringWithFormat:@"selectedModelIndex: %ld", (long)_selectedModelIndex]];
    
    return description;
}

@end


@implementation NullPrinterSetting

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    
    return self;
}

- (BOOL)isNull {
    return YES;
}

- (NSInteger)allReceiptsSettings {
    return 0x07;
}

- (NSString *)description {
    return @"(null data)";
}

@end
