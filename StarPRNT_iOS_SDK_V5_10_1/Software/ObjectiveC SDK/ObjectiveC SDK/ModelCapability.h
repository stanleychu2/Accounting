//
//  ModelCapability.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

#import "PrinterInfo.h"

typedef NS_ENUM(NSInteger, ModelIndex) {     // Don't insert(Only addition)
    ModelIndexNone = 0,
    ModelIndexMCPrint2,
    ModelIndexMCPrint3,
    ModelIndexMPOP,
    ModelIndexFVP10,
    ModelIndexTSP100,
    ModelIndexTSP650II,
    ModelIndexTSP700II,
    ModelIndexTSP800II,
    ModelIndexSM_S210I,
    ModelIndexSM_S220I,
    ModelIndexSM_S230I,
    ModelIndexSM_T300I,
    ModelIndexSM_T400I,
    ModelIndexBSC10,
    ModelIndexSM_S210I_StarPRNT,
    ModelIndexSM_S220I_StarPRNT,
    ModelIndexSM_S230I_StarPRNT,
    ModelIndexSM_T300I_StarPRNT,
    ModelIndexSM_T400I_StarPRNT,
    ModelIndexSM_L200,
    ModelIndexSP700,
    
    // V5.3.0
    ModelIndexSM_L300
};

@interface ModelCapability : NSObject

+ (NSInteger)modelIndexCount;

+ (ModelIndex)modelIndexAtIndex:(NSInteger)index;

+ (NSString *)titleAtModelIndex:(ModelIndex)modelIndex;

+ (StarIoExtEmulation)emulationAtModelIndex:(ModelIndex)modelIndex;

+ (BOOL)cashDrawerOpenActiveAtModelIndex:(ModelIndex)modelIndex;

+ (NSString *)portSettingsAtModelIndex:(ModelIndex)modelIndex;

+ (ModelIndex)modelIndexAtModelName:(NSString *)modelName;

+ (PrinterInfo *)printerInfoAtModelIndex:(ModelIndex)modelIndex;

@end
