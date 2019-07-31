//
//  ApiFunctions.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"

@interface ApiFunctions : NSObject

+ (NSData *)createGenericData:(StarIoExtEmulation)emulation;

+ (NSData *)createFontStyleData:(StarIoExtEmulation)emulation;

+ (NSData *)createInitializationData:(StarIoExtEmulation)emulation;

+ (NSData *)createCodePageData:(StarIoExtEmulation)emulation;

+ (NSData *)createInternationalData:(StarIoExtEmulation)emulation;

+ (NSData *)createFeedData:(StarIoExtEmulation)emulation;

+ (NSData *)createCharacterSpaceData:(StarIoExtEmulation)emulation;

+ (NSData *)createLineSpaceData:(StarIoExtEmulation)emulation;

+ (NSData *)createTopMarginData:(StarIoExtEmulation)emulation;

+ (NSData *)createEmphasisData:(StarIoExtEmulation)emulation;

+ (NSData *)createInvertData:(StarIoExtEmulation)emulation;

+ (NSData *)createUnderLineData:(StarIoExtEmulation)emulation;

+ (NSData *)createMultipleData:(StarIoExtEmulation)emulation;

+ (NSData *)createAbsolutePositionData:(StarIoExtEmulation)emulation;

+ (NSData *)createAlignmentData:(StarIoExtEmulation)emulation;

+ (NSData *)createHorizontalTabPositionData:(StarIoExtEmulation)emulation;

+ (NSData *)createLogoData:(StarIoExtEmulation)emulation;

+ (NSData *)createCutPaperData:(StarIoExtEmulation)emulation;

+ (NSData *)createPeripheralData:(StarIoExtEmulation)emulation;

+ (NSData *)createSoundData:(StarIoExtEmulation)emulation;

+ (NSData *)createBitmapData:(StarIoExtEmulation)emulation width:(NSInteger)width;

+ (NSData *)createBarcodeData:(StarIoExtEmulation)emulation;

+ (NSData *)createPdf417Data:(StarIoExtEmulation)emulation;

+ (NSData *)createQrCodeData:(StarIoExtEmulation)emulation;

+ (NSData *)createBlackMarkData:(StarIoExtEmulation)emulation type:(SCBBlackMarkType)type;

+ (NSData *)createPageModeData:(StarIoExtEmulation)emulation width:(NSInteger)width;

+ (NSData *)createPrintableAreaDataWithEmulation:(StarIoExtEmulation)emulation
                                            type:(SCBPrintableAreaType)type;
@end
