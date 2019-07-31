//
//  PortugueseReceiptsImpl.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "ILocalizeReceipts.h"

@interface PortugueseReceiptsImpl : ILocalizeReceipts

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
