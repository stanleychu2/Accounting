//
//  Utf8MultiLanguageReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by *** on 2018/**/**.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "Utf8MultiLanguageReceiptsImpl.h"

@implementation Utf8MultiLanguageReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"CJK";
    
    self.characterCode = StarIoExtCharacterCodeStandard;
    
    return self;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding = NSUTF8StringEncoding;
    
    // This function is supported by TSP650II(JP2/TW models only) with F/W version 4.0 or later and mC-Print 2/3.
    // Switch Kanji/Hangul font by specifying the font for Unicode CJK Unified Ideographs before each word.
    
    [builder appendCodePage:SCBCodePageTypeUTF8];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"2017 / 5 / 15 AM 10:00\n" dataUsingEncoding:encoding]];
    
    [builder appendMultiple:2 height:2];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontJapanese)]];
    [builder appendData:[@"受付票 " dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontTraditionalChinese)]];
    [builder appendData:[@"排號單\n" dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontSimplifiedChinese)]];
    [builder appendData:[@"排号单 " dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontHangul)]];
    [builder appendData:[@"접수표\n\n" dataUsingEncoding:encoding]];
    
    [builder appendMultiple:1 height:1];
    
    [builder appendCjkUnifiedIdeographFont:@[]];
    [builder appendDataWithMultiple:[@"1\n" dataUsingEncoding:encoding] width:6 height:6];
    [builder appendData:[@"--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontJapanese)]];
    [builder appendData:[@"ご本人がお持ちください。\n"  dataUsingEncoding:encoding]];
    [builder appendData:[@"※紛失しないように\nご注意ください。\n"  dataUsingEncoding:encoding]];
}

- (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding = NSUTF8StringEncoding;
    
    // This function is supported by TSP650II(JP2/TW models only) with F/W version 4.0 or later and mC-Print 2/3.
    // Switch Kanji/Hangul font by specifying the font for Unicode CJK Unified Ideographs before each word.
    
    [builder appendCodePage:SCBCodePageTypeUTF8];

    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"2017 / 5 / 15 AM 10:00\n" dataUsingEncoding:encoding]];
    
    [builder appendMultiple:2 height:2];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontJapanese)]];
    [builder appendData:[@"受付票 " dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontTraditionalChinese)]];
    [builder appendData:[@"排號單\n" dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontSimplifiedChinese)]];
    [builder appendData:[@"排号单 " dataUsingEncoding:encoding]];
    
    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontHangul)]];
    [builder appendData:[@"접수표\n\n" dataUsingEncoding:encoding]];
    
    [builder appendMultiple:1 height:1];
    
    [builder appendCjkUnifiedIdeographFont:@[]];
    [builder appendDataWithMultiple:[@"1\n" dataUsingEncoding:encoding] width:6 height:6];
    [builder appendData:[@"------------------------------------------\n" dataUsingEncoding:encoding]];

    [builder appendCjkUnifiedIdeographFont:@[@(SCBCjkUnifiedIdeographFontJapanese)]];
    [builder appendData:[@"ご本人がお持ちください。\n"  dataUsingEncoding:encoding]];
    [builder appendData:[@"※紛失しないようにご注意ください。\n"  dataUsingEncoding:encoding]];
}

- (void)append4inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    // not implemented
}

- (UIImage *)create2inchRasterReceiptImage {
    return nil;
}

- (UIImage *)create3inchRasterReceiptImage {
    return nil;
}

- (UIImage *)create4inchRasterReceiptImage {
    return nil;
}

- (UIImage *)createCouponImage {
    return nil;
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    return nil;
}

- (void)appendEscPos3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    // not implemented
}

- (void)appendDotImpact3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    // not implemented
}

- (void)appendTextLabelData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    // not implemented
}

- (NSString *)createPasteTextLabelString {
    return nil;
}

- (void)appendPasteTextLabelData:(ISCBBuilder *)builder pasteText:(NSString *)pasteText utf8:(BOOL)utf8 {
    // not implemented
}

@end
