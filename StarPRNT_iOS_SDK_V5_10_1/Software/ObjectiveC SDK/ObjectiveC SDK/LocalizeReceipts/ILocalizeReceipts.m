//
//  ILocalizeReceipts.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "ILocalizeReceipts.h"

#import "EnglishReceiptsImpl.h"
#import "JapaneseReceiptsImpl.h"
#import "FrenchReceiptsImpl.h"
#import "PortugueseReceiptsImpl.h"
#import "SpanishReceiptsImpl.h"
#import "GermanReceiptsImpl.h"
#import "RussianReceiptsImpl.h"
#import "SimplifiedChineseReceiptsImpl.h"
#import "TraditionalChineseReceiptsImpl.h"
#import "Utf8MultiLanguageReceiptsImpl.h"

@interface ILocalizeReceipts ()

@property (nonatomic) LanguageIndex  languageIndex;
@property (nonatomic) PaperSizeIndex paperSizeIndex;

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;
- (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;
- (void)append4inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;

- (UIImage *)create2inchRasterReceiptImage;
- (UIImage *)create3inchRasterReceiptImage;
- (UIImage *)create4inchRasterReceiptImage;

- (UIImage *)createCouponImage;

- (UIImage *)createEscPos3inchRasterReceiptImage;

- (void)appendEscPos3inchTextReceiptData   :(ISCBBuilder *)builder utf8:(BOOL)utf8;
- (void)appendDotImpact3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;

@end

@implementation ILocalizeReceipts

+ (ILocalizeReceipts *)createLocalizeReceipts:(LanguageIndex)languageIndex paperSizeIndex:(PaperSizeIndex)paperSizeIndex {
    ILocalizeReceipts *localizeReceipts;
    
    switch (languageIndex) {
        default                   :
//      case LanguageIndexEnglish :
            localizeReceipts = [[EnglishReceiptsImpl alloc] init];
            break;
        case LanguageIndexJapanese :
            localizeReceipts = [[JapaneseReceiptsImpl alloc] init];
            break;
        case LanguageIndexFrench :
            localizeReceipts = [[FrenchReceiptsImpl alloc] init];
            break;
        case LanguageIndexPortuguese :
            localizeReceipts = [[PortugueseReceiptsImpl alloc] init];
            break;
        case LanguageIndexSpanish :
            localizeReceipts = [[SpanishReceiptsImpl alloc] init];
            break;
        case LanguageIndexGerman :
            localizeReceipts = [[GermanReceiptsImpl alloc] init];
            break;
        case LanguageIndexRussian :
            localizeReceipts = [[RussianReceiptsImpl alloc] init];
            break;
        case LanguageIndexSimplifiedChinese :
            localizeReceipts = [[SimplifiedChineseReceiptsImpl alloc] init];
            break;
        case LanguageIndexTraditionalChinese :
            localizeReceipts = [[TraditionalChineseReceiptsImpl alloc] init];
            break;
        case LanguageIndexCJKUnifiedIdeograph :
            localizeReceipts = [[Utf8MultiLanguageReceiptsImpl alloc] init];
            break;
    }
    
    switch (paperSizeIndex) {
        default                    :
//      case PaperSizeIndexTwoInch :
            localizeReceipts.paperSize      = @"2\"";
            localizeReceipts.scalePaperSize = @"3\"";     // 3inch -> 2inch
            break;
        case PaperSizeIndexThreeInch          :
        case PaperSizeIndexEscPosThreeInch    :
        case PaperSizeIndexDotImpactThreeInch :
            localizeReceipts.paperSize      = @"3\"";
            localizeReceipts.scalePaperSize = @"4\"";     // 4inch -> 3inch
            break;
        case PaperSizeIndexFourInch :
            localizeReceipts.paperSize      = @"4\"";
            localizeReceipts.scalePaperSize = @"3\"";     // 3inch -> 4inch
            break;
    }
    
    localizeReceipts.languageIndex  = languageIndex;
    localizeReceipts.paperSizeIndex = paperSizeIndex;
    
    return localizeReceipts;
}

- (void)appendTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    switch (_paperSizeIndex) {
        default                    :
//      case PaperSizeIndexTwoInch :
            [self append2inchTextReceiptData         :builder utf8:utf8];
            break;
        case PaperSizeIndexThreeInch :
            [self append3inchTextReceiptData         :builder utf8:utf8];
            break;
        case PaperSizeIndexFourInch :
            [self append4inchTextReceiptData         :builder utf8:utf8];
            break;
        case PaperSizeIndexEscPosThreeInch :
            [self appendEscPos3inchTextReceiptData   :builder utf8:utf8];
            break;
        case PaperSizeIndexDotImpactThreeInch :
            [self appendDotImpact3inchTextReceiptData:builder utf8:utf8];
            break;
    }
}

- (UIImage *)createRasterReceiptImage {
    UIImage *image;
    
    switch (_paperSizeIndex) {
        default                    :
//      case PaperSizeIndexTwoInch :
            image = [self create2inchRasterReceiptImage];
            break;
        case PaperSizeIndexThreeInch :
            image = [self create3inchRasterReceiptImage];
            break;
        case PaperSizeIndexFourInch :
            image = [self create4inchRasterReceiptImage];
            break;
        case PaperSizeIndexEscPosThreeInch :
            image = [self createEscPos3inchRasterReceiptImage];
            break;
        case PaperSizeIndexDotImpactThreeInch :
            image = nil;
            break;
    }
    
    return image;
}

- (UIImage *)createScaleRasterReceiptImage {
    UIImage *image;
    
    switch (_paperSizeIndex) {
        default                    :
//      case PaperSizeIndexTwoInch :
            image = [self create3inchRasterReceiptImage];      // 3inch -> 2inch
            break;
        case PaperSizeIndexThreeInch       :
        case PaperSizeIndexEscPosThreeInch :
            image = [self create4inchRasterReceiptImage];      // 4inch -> 3inch
            break;
        case PaperSizeIndexFourInch :
            image = [self create3inchRasterReceiptImage];      // 3inch -> 4inch
            break;
        case PaperSizeIndexDotImpactThreeInch :
            image = nil;
            break;
    }
    
    return image;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (void)append4inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (UIImage *)create2inchRasterReceiptImage {     // abstract!!!
    return nil;
}

- (UIImage *)create3inchRasterReceiptImage {     // abstract!!!
    return nil;
}

- (UIImage *)create4inchRasterReceiptImage {     // abstract!!!
    return nil;
}

- (UIImage *)createCouponImage {     // abstract!!!
    return nil;
}

- (UIImage *)createEscPos3inchRasterReceiptImage {     // abstract!!!
    return nil;
}

- (void)appendEscPos3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (void)appendDotImpact3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (void)appendTextLabelData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {     // abstract!!!
}

- (NSString *)createPasteTextLabelString {     // abstract!!!
    return nil;
}

- (void)appendPasteTextLabelData:(ISCBBuilder *)builder pasteText:(NSString *)pasteText utf8:(BOOL)utf8 {     // abstract!!!
}

+ (UIImage *)imageWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributeDic
                                       context:nil].size;
    
    if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]) {
        if (UIScreen.mainScreen.scale == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    
    CGRect rect = CGRectMake(0, 0, size.width + 1, size.height + 1);
    
    CGContextFillRect(context, rect);
    
    NSDictionary *attributes = @ {
        NSForegroundColorAttributeName:[UIColor blackColor],
                   NSFontAttributeName:font
    };
    
    [string drawInRect:rect withAttributes:attributes];
    
    UIImage *imageToPrint = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageToPrint;
}

@end
