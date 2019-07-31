//
//  ModelCapability.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

#import "ModelCapability.h"
#import "PrinterInfo.h"
#import "PrinterInfo+Builder.h"

typedef NS_ENUM(NSInteger, ModelCapabilityIndex) {
    ModelCapabilityIndexTitle = 0,
    ModelCapabilityIndexEmulation,
    ModelCapabilityIndexCashDrawerOpenActive,
    ModelCapabilityIndexPortSettings,
    ModelCapabilityIndexModelNameArray
};

static const NSArray      *_modelIndexArray;
static const NSDictionary<NSNumber *, PrinterInfo *> *_modelCapabilityDictionary;

@implementation ModelCapability

+ (void)initialize {
    if (self == [ModelCapability class]) {
        _modelIndexArray = @ [
            @(ModelIndexMCPrint2),
            @(ModelIndexMCPrint3),
            @(ModelIndexMPOP),
            @(ModelIndexFVP10),
            @(ModelIndexTSP100),
            @(ModelIndexTSP650II),
            @(ModelIndexTSP700II),
            @(ModelIndexTSP800II),
            @(ModelIndexSP700),
            @(ModelIndexSM_S210I),
            @(ModelIndexSM_S220I),
            @(ModelIndexSM_S230I),
            @(ModelIndexSM_T300I),
            @(ModelIndexSM_T400I),
            @(ModelIndexSM_L200),
            @(ModelIndexSM_L300),
            @(ModelIndexBSC10),
            @(ModelIndexSM_S210I_StarPRNT),
            @(ModelIndexSM_S220I_StarPRNT),
            @(ModelIndexSM_S230I_StarPRNT),
            @(ModelIndexSM_T300I_StarPRNT),
            @(ModelIndexSM_T400I_StarPRNT)
        ];
        
        NSMutableDictionary *modelCapabilityDictionaryBase = [NSMutableDictionary new];
        for (NSNumber *modelIndex in _modelIndexArray) {
            modelCapabilityDictionaryBase[modelIndex] = [PrinterInfo printerInfoWithModelIndex:modelIndex.integerValue];
        }
        
        _modelCapabilityDictionary = [modelCapabilityDictionaryBase copy];
    }
}

+ (NSInteger)modelIndexCount {
    return _modelIndexArray.count;
}

+ (ModelIndex)modelIndexAtIndex:(NSInteger)index {
    return [_modelIndexArray[index] integerValue];
}

+ (NSString *)titleAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)].title;
}

+ (StarIoExtEmulation)emulationAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)].emulation;
}

+ (BOOL)cashDrawerOpenActiveAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)].cashDrawerOpenActive;
}

+ (NSString *)portSettingsAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)].portSettings;
}

+ (ModelIndex)modelIndexAtModelName:(NSString *)modelName {
    for (id modelIndex in _modelCapabilityDictionary) {
        NSArray *modelNameArray = _modelCapabilityDictionary[modelIndex].modelNameArray;
        
        for (int i = 0; i < modelNameArray.count; i++) {
            if ([modelName hasPrefix:modelNameArray[i]] == YES) {
                return [modelIndex integerValue];
            }
        }
    }
    
    return ModelIndexNone;
}

+ (PrinterInfo *)printerInfoAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)];
}

@end
