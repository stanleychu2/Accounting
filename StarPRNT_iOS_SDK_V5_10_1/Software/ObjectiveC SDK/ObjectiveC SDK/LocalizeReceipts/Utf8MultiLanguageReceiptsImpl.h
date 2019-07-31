//
//  Utf8MultiLanguageReceiptsImpl.h
//  ObjectiveC SDK
//
//  Created by *** on 2018/**/**.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "ILocalizeReceipts.h"

@interface Utf8MultiLanguageReceiptsImpl : ILocalizeReceipts

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

- (void)appendTextLabelData:(ISCBBuilder *)builder utf8:(BOOL)utf8;

- (NSString *)createPasteTextLabelString;

- (void)appendPasteTextLabelData:(ISCBBuilder *)builder pasteText:(NSString *)pasteText utf8:(BOOL)utf8;

@end
