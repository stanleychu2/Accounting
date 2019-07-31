//
//  SimplifiedChineseReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "SimplifiedChineseReceiptsImpl.h"

@implementation SimplifiedChineseReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"zh-CN";
    
    self.characterCode = StarIoExtCharacterCodeSimplifiedChinese;
    
    return self;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"STAR便利店\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"欢迎光临\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"Unit 1906-08, 19/F,\n"
                          "Enterprise Square 2,\n"
                          "3 Sheung Yuet Road,\n"
                          "Kowloon Bay, KLN\n"
                          "\n"
                          "Tel : (852) 2795 2335\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"货品名称           数量     价格\n"
                          "--------------------------------\n"
                          "\n"
                          "罐装可乐\n"
                          "* Coke                 1    7.00\n"
                          "纸包柠檬茶\n"
                          "* Lemon Tea            2   10.00\n"
                          "热狗\n"
                          "* Hot Dog              1   10.00\n"
                          "薯片(50克装)\n"
                          "* Potato Chips(50g)    1   11.00\n"
                          "--------------------------------\n"
                          "\n"
                          "              总数 :       38.00\n"
                          "              现金 :       38.00\n"
                          "              找赎 :        0.00\n"
                          "\n"
                          "卡号码 Card No.       : 88888888\n"
                          "卡余额 Remaining Val.    : 88.00\n"
                          "机号   Device No.       : 1234F1\n"
                          "\n"
                          "\n"
                          "DD/MM/YYYY  HH:MM:SS\n"
                          "交易编号 : 88888\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"收银机 : 001  收银员 : 180\n"
                          "\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"STAR便利店\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"欢迎光临\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"Unit 1906-08, 19/F, Enterprise Square 2,\n"
                          "　3 Sheung Yuet Road, Kowloon Bay, KLN\n"
                          "\n"
                          "Tel : (852) 2795 2335\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"货品名称   　            数量   　   价格\n"
                          "------------------------------------------------\n"
                          "\n"
                          "罐装可乐\n"
                          "* Coke                      1        7.00\n"
                          "纸包柠檬茶\n"
                          "* Lemon Tea                 2       10.00\n"
                          "热狗\n"
                          "* Hot Dog                   1       10.00\n"
                          "薯片(50克装)\n"
                          "* Potato Chips(50g)         1       11.00\n"
                          "------------------------------------------------\n"
                          "\n"
                          "                         总数 :     38.00\n"
                          "                         现金 :     38.00\n"
                          "                         找赎 :      0.00\n"
                          "\n"
                          "卡号码 Card No.       : 88888888\n"
                          "卡余额 Remaining Val. : 88.00\n"
                          "机号   Device No.     : 1234F1\n"
                          "\n"
                          "\n"
                          "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"收银机 : 001  收银员 : 180\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (void)append4inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"STAR便利店\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"欢迎光临\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"Unit 1906-08, 19/F, Enterprise Square 2,\n"
                          "　3 Sheung Yuet Road, Kowloon Bay, KLN\n"
                          "\n"
                          "Tel : (852) 2795 2335\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"货品名称   　                      数量        　         价格\n"
                          "----------------------------------------------------------------\n"
                          "\n"
                          "罐装可乐\n"
                          "* Coke                               1                    7.00\n"
                          "纸包柠檬茶\n"
                          "* Lemon Tea                          2                   10.00\n"
                          "热狗\n"
                          "* Hot Dog                            1                   10.00\n"
                          "薯片(50克装)\n"
                          "* Potato Chips(50g)                  1                   11.00\n"
                          "----------------------------------------------------------------\n"
                          "\n"
                          "                                   总数 :                38.00\n"
                          "                                   现金 :                38.00\n"
                          "                                   找赎 :                 0.00\n"
                          "\n"
                          "卡号码 Card No.                   : 88888888\n"
                          "卡余额 Remaining Val.             : 88.00\n"
                          "机号   Device No.                 : 1234F1\n"
                          "\n"
                          "\n"
                          "DD/MM/YYYY  HH:MM:SS        交易编号 : 88888\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"收银机 : 001  收银员 : 180\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"　  　　STAR便利店\n"
    "           欢迎光临\n"
    "\n"
    "Unit 1906-08,19/F,\n"
    "  Enterprise Square 2,\n"
    "  3 Sheung Yuet Road,\n"
    "  Kowloon Bay, KLN\n"
    "\n"
    "Tel: (852) 2795 2335\n"
    "\n"
    "货品名称            数量   价格\n"
    "-----------------------------\n"
    "罐装可乐\n"
    "* Coke              1    7.00\n"
    "纸包柠檬茶\n"
    "* Lemon Tea         2   10.00\n"
    "热狗\n"
    "* Hot Dog           1   10.00\n"
    "薯片(50克装)\n"
    "* Potato Chips(50g) 1   11.00\n"
    "-----------------------------\n"
    "\n"
    "               总　数 :  38.00\n"
    "               现　金 :  38.00\n"
    "               找　赎 :   0.00\n"
    "\n"
    "卡号码 Card No. :    88888888\n"
    "卡余额 Remaining Val. : 88.00\n"
    "机号　 Device No. :    1234F1\n"
    "\n"
    "DD/MM/YYYY HH:MM:SS\n"
    "交易编号: 88888\n"
    "\n"
    "         收银机:001  收银员:180\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:11 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　  　　STAR便利店\n"
    "                欢迎光临\n"
    "\n"
    "Unit 1906-08,19/F,Enterprise Square 2,\n"
    "  3 Sheung Yuet Road, Kowloon Bay, KLN\n"
    "\n"
    "Tel: (852) 2795 2335\n"
    "\n"
    "货品名称                 数量   　  价格\n"
    "---------------------------------------\n"
    "罐装可乐\n"
    "* Coke                   1        7.00\n"
    "纸包柠檬茶\n"
    "* Lemon Tea              2       10.00\n"
    "热狗\n"
    "* Hot Dog                1       10.00\n"
    "薯片(50克装)\n"
    "* Potato Chips(50g)      1       11.00\n"
    "---------------------------------------\n"
    "\n"
    "                        总　数 :  38.00\n"
    "                        现　金 :  38.00\n"
    "                        找　赎 :   0.00\n"
    "\n"
    "卡号码 Card No.        :       88888888\n"
    "卡余额 Remaining Val.  :       88.00\n"
    "机号　 Device No.      :       1234F1\n"
    "\n"
    "DD/MM/YYYY   HH:MM:SS   交易编号: 88888\n"
    "\n"
    "          收银机:001  收银员:180\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　  　　         STAR便利店\n"
    "                          欢迎光临\n"
    "\n"
    "     Unit 1906-08,19/F,Enterprise Square 2,\n"
    "                3 Sheung Yuet Road, Kowloon Bay, KLN\n"
    "\n"
    "Tel: (852) 2795 2335\n"
    "\n"
    "货品名称                               数量          价格\n"
    "---------------------------------------------------------\n"
    "罐装可乐\n"
    "* Coke                                 1            7.00\n"
    "纸包柠檬茶\n"
    "* Lemon Tea                            2           10.00\n"
    "热狗\n"
    "* Hot Dog                              1           10.00\n"
    "薯片(50克装)\n"
    "* Potato Chips(50g)                    1           11.00\n"
    "---------------------------------------------------------\n"
    "\n"
    "                                          总　数 :  38.00\n"
    "                                          现　金 :  38.00\n"
    "                                          找　赎 :   0.00\n"
    "\n"
    "卡号码 Card No.        :       88888888\n"
    "卡余额 Remaining Val.  :       88.00\n"
    "机号　 Device No.      :       1234F1\n"
    "\n"
    "DD/MM/YYYY              HH:MM:SS          交易编号: 88888\n"
    "\n"
    "                   收银机:001  收银员:180\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"SimplifiedChineseCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　　STAR便利店\n"
    "              欢迎光临\n"
    "\n"
    "Unit 1906-08,19/F,\n"
    "  Enterprise Square 2,\n"
    "  3 Sheung Yuet Road,\n"
    "  Kowloon Bay, KLN\n"
    "\n"
    "Tel: (852) 2795 2335\n"
    "\n"
    "货品名称              数量   　  价格\n"
    "-----------------------------------\n"
    "罐装可乐\n"
    "* Coke                1        7.00\n"
    "纸包柠檬茶\n"
    "* Lemon Tea           2       10.00\n"
    "热狗\n"
    "* Hot Dog             1       10.00\n"
    "薯片(50克装)\n"
    "* Potato Chips(50g)   1       11.00\n"
    "-----------------------------------\n"
    "\n"
    "                     总　数 :  38.00\n"
    "                     现　金 :  38.00\n"
    "                     找　赎 :   0.00\n"
    "\n"
    "卡号码 Card No.        :    88888888\n"
    "卡余额 Remaining Val.  :    88.00\n"
    "机号　 Device No.      :    1234F1\n"
    "\n"
    "DD/MM/YYYY HH:MM:SS  交易编号: 88888\n"
    "\n"
    "          收银机:001  收银员:180\n";
    
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
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"STAR便利店\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"欢迎光临\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"Unit 1906-08, 19/F, Enterprise Square 2,\n"
                          "　3 Sheung Yuet Road, Kowloon Bay, KLN\n"
                          "\n"
                          "Tel : (852) 2795 2335\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"货品名称   　        数量   　 价格\n"
                          "------------------------------------------\n"
                          "\n"
                          "罐装可乐\n"
                          "* Coke                  1      7.00\n"
                          "纸包柠檬茶\n"
                          "* Lemon Tea             2     10.00\n"
                          "热狗\n"
                          "* Hot Dog               1     10.00\n"
                          "薯片(50克装)\n"
                          "* Potato Chips(50g)     1     11.00\n"
                          "------------------------------------------\n"
                          "\n"
                          "                   总数 :     38.00\n"
                          "                   现金 :     38.00\n"
                          "                   找赎 :      0.00\n"
                          "\n"
                          "卡号码 Card No.       : 88888888\n"
                          "卡余额 Remaining Val. : 88.00\n"
                          "机号   Device No.     : 1234F1\n"
                          "\n"
                          "\n"
                          "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"收银机 : 001  收银员 : 180\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (void)appendDotImpact3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
//      [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"STAR便利店\n"
                                            "欢迎光临\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendData:[@"Unit 1906-08, 19/F, Enterprise Square 2,\n"
                          "　3 Sheung Yuet Road, Kowloon Bay, KLN\n"
                          "\n"
                          "Tel : (852) 2795 2335\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"货品名称   　          数量  　   价格\n"
                          "------------------------------------------\n"
                          "\n"
                          "罐装可乐\n"
                          "* Coke                   1        7.00\n"
                          "纸包柠檬茶\n"
                          "* Lemon Tea              2       10.00\n"
                          "热狗\n"
                          "* Hot Dog                1       10.00\n"
                          "薯片(50克装)\n"
                          "* Potato Chips(50g)      1       11.00\n"
                          "------------------------------------------\n"
                          "\n"
                          "                      总数 :     38.00\n"
                          "                      现金 :     38.00\n"
                          "                      找赎 :      0.00\n"
                          "\n"
                          "卡号码 Card No.       : 88888888\n"
                          "卡余额 Remaining Val. : 88.00\n"
                          "机号   Device No.     : 1234F1\n"
                          "\n"
                          "\n"
                          "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"收银机 : 001  收银员 : 180\n" dataUsingEncoding:encoding]];
}

@end
