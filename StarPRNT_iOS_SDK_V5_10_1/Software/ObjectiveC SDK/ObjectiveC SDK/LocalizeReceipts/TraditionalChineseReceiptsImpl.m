//
//  TraditionalChineseReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "TraditionalChineseReceiptsImpl.h"

@implementation TraditionalChineseReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"zh-TW";
    
    self.characterCode = StarIoExtCharacterCodeTraditionalChinese;
    
    return self;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"電子發票證明聯\n"
                                      "103年01-02月\n"
                                      "EV-99999999\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"2014/01/15 13:00\n"
                          "隨機碼 : 9999    總計 : 999\n"
                          "賣方 : 99999999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:encoding]              model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:NSASCIIStringEncoding] model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換請持本聯及銷貨明細表。\n"
                          "9999999-9999999 999999-999999 9999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"銷貨明細表 　(銷售)\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendDataWithAlignment:[@"2014-01-15 13:00:02\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionRight];
    
    [builder appendData:[@"\n"
                          "烏龍袋茶2g20入       55 x2 110TX\n"
                          "茉莉烏龍茶2g20入     55 x2 110TX\n"
                          "天仁觀音茶2g*20      55 x2 110TX\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"      小　 計 :              330\n"
                                      "      總   計 :              330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"--------------------------------\n"
                          "現 金                        400\n"
                          "      找　 零 :               70\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@" 101 發票金額 :              330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"2014-01-15 13:00\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換、贈品及停車兌換請持本聯。\n"
                          "9999999-9999999 999999-999999 9999\n" dataUsingEncoding:encoding]];
}

- (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"電子發票證明聯\n"
                                      "103年01-02月\n"
                                      "EV-99999999\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"2014/01/15 13:00\n"
                          "隨機碼 : 9999    總計 : 999\n"
                          "賣方 : 99999999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:encoding]              model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:NSASCIIStringEncoding] model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換請持本聯及銷貨明細表。\n"
                          "9999999-9999999 999999-999999 9999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"銷貨明細表 　(銷售)\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendDataWithAlignment:[@"2014-01-15 13:00:02\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionRight];
    
    [builder appendData:[@"\n"
                          "烏龍袋茶2g20入                55 x2 110TX\n"
                          "茉莉烏龍茶2g20入              55 x2 110TX\n"
                          "天仁觀音茶2g*20               55 x2 110TX\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"      小　 計 :                330\n"
                                      "      總   計 :                330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "現 金                          400\n"
                          "      找　 零 :                 70\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@" 101 發票金額 :                330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"2014-01-15 13:00\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換、贈品及停車兌換請持本聯。\n"
                          "9999999-9999999 999999-999999 9999\n" dataUsingEncoding:encoding]];
}

- (void)append4inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"電子發票證明聯\n"
                                      "103年01-02月\n"
                                      "EV-99999999\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"2014/01/15 13:00\n"
                          "隨機碼 : 9999    總計 : 999\n"
                          "賣方 : 99999999\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:encoding]              model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:NSASCIIStringEncoding] model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換請持本聯及銷貨明細表。\n"
                         "9999999-9999999 999999-999999 9999\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"銷貨明細表 　(銷售)\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendDataWithAlignment:[@"2014-01-15 13:00:02\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionRight];
    
    [builder appendData:[@"\n"
                          "烏龍袋茶2g20入                                    55 x2 110TX\n"
                          "茉莉烏龍茶2g20入                                  55 x2 110TX\n"
                          "天仁觀音茶2g*20                                   55 x2 110TX\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"      小　 計 :                                    330\n"
                                      "      總   計 :                                    330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "現 金                                              400\n"
                          "      找　 零 :                                     70\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@" 101 發票金額 :                                    330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"2014-01-15 13:00\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換、贈品及停車兌換請持本聯。\n"
                          "9999999-9999999 999999-999999 9999\n" dataUsingEncoding:encoding]];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　Star Micronics\n"
    "-----------------------------\n"
    "        電子發票證明聯\n"
    "        103年01-02月\n"
    "        EV-99999999\n"
    "2014/01/15 13:00\n"
    "隨機碼 : 9999      總計 : 999\n"
    "賣　方 : 99999999\n"
    "\n"
    "商品退換請持本聯及銷貨明細表。\n"
    "9999999-9999999 999999-999999 9999\n"
    "\n"
    "\n"
    "        銷貨明細表 　(銷售)\n"
    "     2014-01-15 13:00:02\n"
    "\n"
    "烏龍袋茶2g20入　   55 x2  110TX\n"
    "茉莉烏龍茶2g20入   55 x2  110TX\n"
    "天仁觀音茶2g*20　  55 x2  110TX\n"
    "     小　　計 :　　         330\n"
    "     總　　計 :　　         330\n"
    "-----------------------------\n"
    "現　金　　　                400\n"
    "     找　　零 :　　          70\n"
    " 101 發票金額 :　　         330\n"
    "2014-01-15 13:00\n"
    "\n"
    "商品退換、贈品及停車兌換請持本聯。\n"
    "9999999-9999999 999999-999999 9999\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:11 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　 　　　  　　Star Micronics\n"
    "---------------------------------------\n"
    "              電子發票證明聯\n"
    "              103年01-02月\n"
    "              EV-99999999\n"
    "2014/01/15 13:00\n"
    "隨機碼 : 9999      總計 : 999\n"
    "賣　方 : 99999999\n"
    "\n"
    "商品退換請持本聯及銷貨明細表。\n"
    "9999999-9999999 999999-999999 9999\n"
    "\n"
    "\n"
    "         銷貨明細表 　(銷售)\n"
    "                    2014-01-15 13:00:02\n"
    "\n"
    "烏龍袋茶2g20入　         55 x2    110TX\n"
    "茉莉烏龍茶2g20入         55 x2    110TX\n"
    "天仁觀音茶2g*20　        55 x2    110TX\n"
    "     小　　計 :　　        330\n"
    "     總　　計 :　　        330\n"
    "---------------------------------------\n"
    "現　金　　　               400\n"
    "     找　　零 :　　         70\n"
    " 101 發票金額 :　　        330\n"
    "2014-01-15 13:00\n"
    "\n"
    "商品退換、贈品及停車兌換請持本聯。\n"
    "9999999-9999999 999999-999999 9999\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"　 　　　  　  　       Star Micronics\n"
    "---------------------------------------------------------\n"
    "                       電子發票證明聯\n"
    "                       103年01-02月\n"
    "                       EV-99999999\n"
    "2014/01/15 13:00\n"
    "隨機碼 : 9999      總計 : 999\n"
    "賣　方 : 99999999\n"
    "\n"
    "商品退換請持本聯及銷貨明細表。\n"
    "9999999-9999999 999999-999999 9999\n"
    "\n"
    "\n"
    "                      銷貨明細表 　(銷售)\n"
    "                                      2014-01-15 13:00:02\n"
    "\n"
    "烏龍袋茶2g20入　                   55 x2        110TX\n"
    "茉莉烏龍茶2g20入                   55 x2        110TX\n"
    "天仁觀音茶2g*20　                  55 x2        110TX\n"
    "     小　　計 :　　                  330\n"
    "     總　　計 :　　                  330\n"
    "---------------------------------------------------------\n"
    "現　金　　　                         400\n"
    "     找　　零 :　　                   70\n"
    " 101 發票金額 :　　                  330\n"
    "2014-01-15 13:00\n"
    "\n"
    "商品退換、贈品及停車兌換請持本聯。\n"
    "9999999-9999999 999999-999999 9999\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"TraditionalChineseCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　 　  　　Star Micronics\n"
    "-----------------------------------\n"
    "           電子發票證明聯\n"
    "           103年01-02月\n"
    "           EV-99999999\n"
    "2014/01/15 13:00\n"
    "隨機碼 : 9999      總計 : 999\n"
    "賣　方 : 99999999\n"
    "\n"
    "商品退換請持本聯及銷貨明細表。\n"
    "9999999-9999999 999999-999999 9999\n"
    "\n"
    "\n"
    "         銷貨明細表 　(銷售)\n"
    "            2014-01-15 13:00:02\n"
    "\n"
    "烏龍袋茶2g20入　     55 x2    110TX\n"
    "茉莉烏龍茶2g20入     55 x2    110TX\n"
    "天仁觀音茶2g*20　    55 x2    110TX\n"
    "     小　　計 :　　        330\n"
    "     總　　計 :　　        330\n"
    "-----------------------------------\n"
    "現　金　　　               400\n"
    "     找　　零 :　　         70\n"
    " 101 發票金額 :　　        330\n"
    "2014-01-15 13:00\n"
    "\n"
    "商品退換、贈品及停車兌換請持本聯。\n"
    "9999999-9999999 999999-999999 9999\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:512];     // EscPos3inch(512dots)
}

- (void)appendEscPos3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"電子發票證明聯\n"
                                      "103年01-02月\n"
                                      "EV-99999999\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"2014/01/15 13:00\n"
                          "隨機碼 : 9999    總計 : 999\n"
                          "賣方 : 99999999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:encoding]              model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    [builder appendQrCodeData:[@"http://www.star-m.jp/eng/index.html" dataUsingEncoding:NSASCIIStringEncoding] model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:5];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換請持本聯及銷貨明細表。\n"
                          "9999999-9999999 999999-999999 9999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"銷貨明細表 　(銷售)\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendDataWithAlignment:[@"2014-01-15 13:00:02\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionRight];
    
    [builder appendData:[@"\n"
                          "烏龍袋茶2g20入                55 x2 110TX\n"
                          "茉莉烏龍茶2g20入              55 x2 110TX\n"
                          "天仁觀音茶2g*20               55 x2 110TX\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"      小　 計 :                330\n"
                                      "      總   計 :                330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"------------------------------------------\n"
                          "現 金                          400\n"
                          "      找　 零 :                 70\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@" 101 發票金額 :                330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"2014-01-15 13:00\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"\n"
                          "商品退換、贈品及停車兌換請持本聯。\n"
                          "9999999-9999999 999999-999999 9999\n" dataUsingEncoding:encoding]];
}

- (void)appendDotImpact3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"電子發票證明聯\n"
                                           "103年01-02月\n"
                                           "EV-99999999\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"2014/01/15 13:00\n"
                          "隨機碼 : 9999    總計 : 999\n"
                          "賣方 : 99999999\n"
                          "\n"
                          "商品退換請持本聯及銷貨明細表。\n"
                          "9999999-9999999 999999-999999 9999\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"銷貨明細表 　(銷售)\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendDataWithAlignment:[@"2014-01-15 13:00:02\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionRight];
    
    [builder appendData:[@"\n"
                          "烏龍袋茶2g20入             55 x2 110TX\n"
                          "茉莉烏龍茶2g20入           55 x2 110TX\n"
                          "天仁觀音茶2g*20            55 x2 110TX\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"      小　 計 :             330\n"
                                      "      總   計 :             330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"------------------------------------------\n"
                          "現 金                       400\n"
                          "      找　 零 :              70\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@" 101 發票金額 :             330\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"2014-01-15 13:00\n"
                          "\n"
                          "商品退換、贈品及停車兌換請持本聯。\n"
                          "9999999-9999999 999999-999999 9999\n" dataUsingEncoding:encoding]];
}

@end
