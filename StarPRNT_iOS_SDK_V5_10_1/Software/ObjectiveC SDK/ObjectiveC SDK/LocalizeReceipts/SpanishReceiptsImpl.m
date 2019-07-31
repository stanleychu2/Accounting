//
//  SpanishReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "SpanishReceiptsImpl.h"

@implementation SpanishReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"Es";
    
    self.characterCode = StarIoExtCharacterCodeStandard;
    
    return self;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSWindowsCP1252StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
    [builder appendInternational:SCBInternationalTypeSpain];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"BAR RESTAURANT\n"
                                      "EL POZO\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"C/.ROCAFORT 187\n"
                          "08029 BARCELONA\n"
                          "\n"
                          "NIF :X-3856907Z\n"
                          "TEL :934199465\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"--------------------------------\n"
                          "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
                          "CAN P/U DESCRIPCION  SUMA\n"
                          "--------------------------------\n"
                          " 4  3,00  JARRA  CERVEZA   12,00\n"
                          " 1  1,60  COPA DE CERVEZA   1,60\n"
                          "--------------------------------\n"
                          "               SUB TOTAL : 13,60\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithMultipleHeight:[@"TOTAL:     13,60 EUROS\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"NO: 000018851     IVA INCLUIDO\n"
                          "--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"**** GRACIAS POR SU VISITA! ****\n"
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
        encoding = NSWindowsCP1252StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
    [builder appendInternational:SCBInternationalTypeSpain];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultiple:[@"BAR RESTAURANT EL POZO\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"C/.ROCAFORT 187 08029 BARCELONA\n"
                          "NIF :X-3856907Z  TEL :934199465\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
                          "CAN P/U DESCRIPCION  SUMA\n"
                          "------------------------------------------------\n"
                          " 4     3,00      JARRA  CERVEZA            12,00\n"
                          " 1     1,60      COPA DE CERVEZA            1,60\n"
                          "------------------------------------------------\n"
                          "                           SUB TOTAL :     13,60\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithMultipleHeight:[@"TOTAL:     13,60 EUROS\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"NO: 000018851  IVA INCLUIDO\n"
                          "------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"**** GRACIAS POR SU VISITA! ****\n"
                          "\n" dataUsingEncoding:encoding]];
    
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
        encoding = NSWindowsCP1252StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
    [builder appendInternational:SCBInternationalTypeSpain];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultiple:[@"BAR RESTAURANT EL POZO\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"C/.ROCAFORT 187 08029 BARCELONA\n"
                          "NIF :X-3856907Z  TEL :934199465\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
                          "CAN P/U DESCRIPCION  SUMA\n"
                          "---------------------------------------------------------------------\n"
                          " 4     3,00          JARRA  CERVEZA                             12,00\n"
                          " 1     1,60          COPA DE CERVEZA                             1,60\n"
                          "---------------------------------------------------------------------\n"
                          "                                         SUB TOTAL :            13,60\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithMultipleHeight:[@"TOTAL:     13,60 EUROS\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"NO: 000018851  IVA INCLUIDO\n"
                          "---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"**** GRACIAS POR SU VISITA! ****\n"
                          "\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"     BAR RESTAURANT\n"
    "                   EL POZO\n"
    "C/.ROCAFORT 187\n"
    "08029 BARCELONA\n"
    "NIF :X-3856907Z\n"
    "TEL :934199465\n"
    "--------------------------\n"
    "MESA: 100 P: -\n"
    "    FECHA: YYYY-MM-DD\n"
    "CAN P/U DESCRIPCION  SUMA\n"
    "--------------------------\n"
    "3,00 JARRA  CERVEZA  12,00\n"
    "1,60 COPA DE CERVEZA  1,60\n"
    "--------------------------\n"
    "         SUB TOTAL : 13,60\n"
    "TOTAL:         13,60 EUROS\n"
    " NO:000018851 IVA INCLUIDO\n"
    "\n"
    "--------------------------\n"
    "**GRACIAS POR SU VISITA!**\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"                        BAR RESTAURANT\n"
    "                               EL POZO\n"
    "C/.ROCAFORT 187\n"
    "08029 BARCELONA\n"
    "NIF :X-3856907Z\n"
    "TEL :934199465\n"
    "--------------------------------------\n"
    "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
    "CAN P/U DESCRIPCION  SUMA\n"
    "--------------------------------------\n"
    "4 3,00 JARRA  CERVEZA   12,00\n"
    "1 1,60 COPA DE CERVEZA  1,60\n"
    "--------------------------------------\n"
    "                     SUB TOTAL : 13,60\n"
    "TOTAL:               13,60 EUROS\n"
    "NO: 000018851 IVA INCLUIDO\n"
    "\n"
    "--------------------------------------\n"
    "            **GRACIAS POR SU VISITA!**\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"                                   BAR RESTAURANT EL POZO\n"
    "                          C/.ROCAFORT 187 08029 BARCELONA\n"
    "                          NIF :X-3856907Z  TEL :934199465\n"
    "---------------------------------------------------------\n"
    "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
    "CAN P/U DESCRIPCION  SUMA\n"
    "---------------------------------------------------------\n"
    "4    3,00    JARRA  CERVEZA                         12,00\n"
    "1    1,60    COPA DE CERVEZA                         1,60\n"
    "---------------------------------------------------------\n"
    "                                  SUB TOTAL :       13,60\n"
    "                                 TOTAL :      13,60 EUROS\n"
    "NO: 000018851 IVA INCLUIDO\n"
    "\n"
    "---------------------------------------------------------\n"
    "                             ***GRACIAS POR SU VISITA!***\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"SpanishCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"                     BAR RESTAURANT\n"
    "                            EL POZO\n"
    "C/.ROCAFORT 187\n"
    "08029 BARCELONA\n"
    "NIF :X-3856907Z\n"
    "TEL :934199465\n"
    "-----------------------------------\n"
    "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
    "CAN P/U DESCRIPCION  SUMA\n"
    "-----------------------------------\n"
    "4 3,00 JARRA  CERVEZA   12,00\n"
    "1 1,60 COPA DE CERVEZA  1,60\n"
    "-----------------------------------\n"
    "                  SUB TOTAL : 13,60\n"
    "TOTAL:               13,60 EUROS\n"
    "NO: 000018851 IVA INCLUIDO\n"
    "\n"
    "-----------------------------------\n"
    "         **GRACIAS POR SU VISITA!**\n";
    
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
        encoding = NSWindowsCP1252StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
    [builder appendInternational:SCBInternationalTypeSpain];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"BAR RESTAURANT EL POZO\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"C/.ROCAFORT 187 08029 BARCELONA\n"
                          "NIF :X-3856907Z  TEL :934199465\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
                          "CAN P/U DESCRIPCION  SUMA\n"
                          "------------------------------------------\n"
                          " 4    3,00    JARRA  CERVEZA         12,00\n"
                          " 1    1,60    COPA DE CERVEZA         1,60\n"
                          "------------------------------------------\n"
                          "                     SUB TOTAL :     13,60\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithMultipleHeight:[@"TOTAL:     13,60 EUROS\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"NO: 000018851  IVA INCLUIDO\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"**** GRACIAS POR SU VISITA! ****\n"
                          "\n" dataUsingEncoding:encoding]];
    
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
        encoding = NSWindowsCP1252StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1252];
    }
    
    [builder appendInternational:SCBInternationalTypeSpain];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"BAR RESTAURANT EL POZO\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"C/.ROCAFORT 187 08029 BARCELONA\n"
                          "NIF :X-3856907Z  TEL :934199465\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "MESA: 100 P: - FECHA: YYYY-MM-DD\n"
                          "CAN P/U DESCRIPCION  SUMA\n"
                          "------------------------------------------\n"
                          " 4 3,00 JARRA  CERVEZA               12,00\n"
                          " 1 1,60 COPA DE CERVEZA               1,60\n"
                          "------------------------------------------\n"
                          " SUB TOTAL :                         13,60\n"
                          "                     TOTAL:    13,60 EUROS\n"
                          "NO: 000018851  IVA INCLUIDO\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"**** GRACIAS POR SU VISITA! ****\n" dataUsingEncoding:encoding]];
}

@end
