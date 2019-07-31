//
//  PortugueseReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "PortugueseReceiptsImpl.h"

@implementation PortugueseReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"Pt";
    
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
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultipleHeight:[@"COMERCIAL DE ALIMENTOS\n"
                                            "STAR LTDA.\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Avenida Moyses Roysen,\n"
                          "S/N Vila Guilherme\n"
                          "Cep: 02049-010 – Sao Paulo – SP\n"
                          "CNPJ: 62.545.579/0013-69\n"
                          "IE:110.819.138.118\n"
                          "IM: 9.041.041-5\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"--------------------------------\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "CCF:133939 COO:227808\n"
                          "--------------------------------\n"
                          "CUPOM FISCAL\n"
                          "--------------------------------\n"
                          "001 2505 CAFÉ DO PONTO TRAD A\n"
                          "                    1un F1 8,15)\n"
                          "002 2505 CAFÉ DO PONTO TRAD A\n"
                          "                    1un F1 8,15)\n"
                          "003 2505 CAFÉ DO PONTO TRAD A\n"
                          "                    1un F1 8,15)\n"
                          "004 6129 AGU MIN NESTLE 510ML\n"
                          "                    1un F1 1,39)\n"
                          "005 6129 AGU MIN NESTLE 510ML\n"
                          "                    1un F1 1,39)\n"
                          "--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"TOTAL  R$  27,23\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendData:[@"DINHEIROv                  29,00\n"
                          "TROCO R$                    1,77\n"
                          "Valor dos Tributos R$2,15(7,90%)\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"ITEM(S) CINORADIS 5\n"
                          "OP.:15326  PDV:9  BR,BF:93466\n"
                          "OBRIGADO PERA PREFERENCIA.\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"VOLTE SEMPRE!\n"
                                           "\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"SAC 0800 724 2822\n"
                          "--------------------------------\n"
                          "MD5:\n"
                          "fe028828a532a7dbaf4271155aa4e2db\n"
                          "Calypso_CA CA.20.c13\n"
                          " – Unisys Brasil\n"
                          "--------------------------------\n"
                          "DARUMA AUTOMAÇÃO   MACH 2\n"
                          "ECF-IF VERSÃO:01,00,00 ECF:093\n"
                          "Lj:0204 OPR:ANGELA JORGE\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"DDDDDDDDDAEHFGBFCC\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "FAB:DR0911BR000000275026\n"
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
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"COMERCIAL DE ALIMENTOS STAR LTDA.\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Avenida Moyses Roysen, S/N  Vila Guilherme\n"
                          "Cep: 02049-010 – Sao Paulo – SP\n"
                          "CNPJ: 62.545.579/0013-69\n"
                          "IE:110.819.138.118  IM: 9.041.041-5\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n"
                          "------------------------------------------------\n"
                          "CUPOM FISCAL\n"
                          "------------------------------------------------\n"
                          "001  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
                          "002  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
                          "003  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
                          "004  6129  AGU MIN NESTLE 510ML  1un F1  1,39)\n"
                          "005  6129  AGU MIN NESTLE 510ML  1un F1  1,39)\n"
                          "------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"TOTAL  R$         27,23\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendData:[@"DINHEIROv                                29,00\n"
                          "TROCO R$                                  1,77\n"
                          "Valor dos Tributos R$2,15 (7,90%)\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"ITEM(S) CINORADIS 5\n"
                          "OP.:15326  PDV:9  BR,BF:93466\n"
                          "OBRIGADO PERA PREFERENCIA.\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"VOLTE SEMPRE!\n"
                                           "\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"SAC 0800 724 2822\n"
                          "------------------------------------------------\n"
                          "MD5:fe028828a532a7dbaf4271155aa4e2db\n"
                          "Calypso_CA CA.20.c13 – Unisys Brasil\n"
                          "------------------------------------------------\n"
                          "DARUMA AUTOMAÇÃO   MACH 2\n"
                          "ECF-IF VERSÃO:01,00,00 ECF:093\n"
                          "Lj:0204 OPR:ANGELA JORGE\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"DDDDDDDDDAEHFGBFCC\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "FAB:DR0911BR000000275026\n"
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
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"COMERCIAL DE ALIMENTOS STAR LTDA.\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Avenida Moyses Roysen, S/N  Vila Guilherme\n"
                          "Cep: 02049-010 – Sao Paulo – SP\n"
                          "CNPJ: 62.545.579/0013-69\n"
                          "IE:110.819.138.118  IM: 9.041.041-5\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n"
                          "---------------------------------------------------------------------\n"
                          "CUPOM FISCAL\n"
                          "---------------------------------------------------------------------\n"
                          "001  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n"
                          "002  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n"
                          "003  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n"
                          "004  6129        AGU MIN NESTLE 510ML    1un F1            1,39)\n"
                          "005  6129        AGU MIN NESTLE 510ML    1un F1            1,39)\n"
                          "---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"TOTAL  R$                  27,23\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendData:[@"DINHEIROv                                                  29,00\n"
                          "TROCO R$                                                    1,77\n"
                          "Valor dos Tributos R$2,15 (7,90%)\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"ITEM(S) CINORADIS 5\n"
                          "OP.:15326  PDV:9  BR,BF:93466\n"
                          "OBRIGADO PERA PREFERENCIA.\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"VOLTE SEMPRE!\n"
                                           "\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"SAC 0800 724 2822\n"
                          "---------------------------------------------------------------------\n"
                          "MD5:fe028828a532a7dbaf4271155aa4e2db\n"
                          "Calypso_CA CA.20.c13 – Unisys Brasil\n"
                          "---------------------------------------------------------------------\n"
                          "DARUMA AUTOMAÇÃO   MACH 2\n"
                          "ECF-IF VERSÃO:01,00,00 ECF:093\n"
                          "Lj:0204 OPR:ANGELA JORGE\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"DDDDDDDDDAEHFGBFCC\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "FAB:DR0911BR000000275026\n"
                          "\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"COMERCIAL DE ALIMENTOS\n"
    "         STAR LTDA.\n"
    "Avenida Moyses Roysen,\n"
    "S/N Vila Guilherme\n"
    "Cep: 02049-010 – Sao Paulo\n"
    "     – SP\n"
    "CNPJ: 62.545.579/0013-69\n"
    "IE:110.819.138.118\n"
    "IM: 9.041.041-5\n"
    "--------------------------\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "CCF:133939 COO:227808\n"
    "--------------------------\n"
    "CUPOM FISCAL\n"
    "--------------------------\n"
    "01 CAFÉ DO PONTO TRAD A\n"
    "              1un F1 8,15)\n"
    "02 CAFÉ DO PONTO TRAD A\n"
    "              1un F1 8,15)\n"
    "03 CAFÉ DO PONTO TRAD A\n"
    "              1un F1 8,15)\n"
    "04 AGU MIN NESTLE 510ML\n"
    "              1un F1 1,39)\n"
    "05 AGU MIN NESTLE 510ML\n"
    "              1un F1 1,39)\n"
    "--------------------------\n"
    "TOTAL  R$            27,23\n"
    "DINHEIROv            29,00\n"
    "\n"
    "TROCO R$              1,77\n"
    "Valor dos Tributos\n"
    "R$2,15(7,90%)\n"
    "ITEM(S) CINORADIS 5\n"
    "OP.:15326  PDV:9\n"
    "            BR,BF:93466\n"
    "OBRIGADO PERA PREFERENCIA.\n"
    "VOLTE SEMPRE!\n"
    "SAC 0800 724 2822\n"
    "--------------------------\n"
    "MD5:\n"
    "fe028828a532a7dbaf4271155a\n"
    "a4e2db\n"
    "Calypso_CA CA.20.c13\n"
    " – Unisys Brasil\n"
    "--------------------------\n"
    "DARUMA AUTOMAÇÃO   MACH 2\n"
    "ECF-IF VERSÃO:01,00,00\n"
    "ECF:093\n"
    "Lj:0204 OPR:ANGELA JORGE\n"
    "DDDDDDDDDAEHFGBFCC\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "FAB:DR0911BR000000275026\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"         COMERCIAL DE ALIMENTOS\n"
    "              STAR LTDA.\n"
    "        Avenida Moyses Roysen,\n"
    "          S/N Vila Guilherme\n"
    "     Cep: 02049-010 – Sao Paulo – SP\n"
    "        CNPJ: 62.545.579/0013-69\n"
    "  IE:110.819.138.118    IM: 9.041.041-5\n"
    "---------------------------------------\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "CCF:133939   COO:227808\n"
    "---------------------------------------\n"
    "CUPOM FISCAL\n"
    "---------------------------------------\n"
    "01  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
    "02  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
    "03  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n"
    "04  AGU MIN NESTLE 510ML  1un F1  1,39)\n"
    "05  AGU MIN NESTLE 510ML  1un F1  1,39)\n"
    "---------------------------------------\n"
    "TOTAL  R$                         27,23\n"
    "DINHEIROv                         29,00\n"
    "\n"
    "TROCO R$                           1,77\n"
    "Valor dos Tributos R$2,15(7,90%)\n"
    "ITEM(S) CINORADIS 5\n"
    "OP.:15326  PDV:9  BR,BF:93466\n"
    "OBRIGADO PERA PREFERENCIA.\n"
    "VOLTE SEMPRE!    SAC 0800 724 2822\n"
    "---------------------------------------\n"
    "MD5:  fe028828a532a7dbaf4271155aa4e2db\n"
    "Calypso_CA CA.20.c13 – Unisys Brasil\n"
    "---------------------------------------\n"
    "DARUMA AUTOMAÇÃO   MACH 2\n"
    "ECF-IF VERSÃO:01,00,00 ECF:093\n"
    "Lj:0204 OPR:ANGELA JORGE\n"
    "DDDDDDDDDAEHFGBFCC\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "FAB:DR0911BR000000275026\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"            COMERCIAL DE ALIMENTOS STAR LTDA.\n"
    "         Avenida Moyses Roysen, S/N Vila Guilherme\n"
    "              Cep: 02049-010 – Sao Paulo – SP\n"
    "                  CNPJ: 62.545.579/0013-69\n"
    "                    IE:110.819.138.118    IM: 9.041.041-5\n"
    "---------------------------------------------------------\n"
    "              MM/DD/YYYY HH:MM:SS CCF:133939   COO:227808\n"
    "---------------------------------------------------------\n"
    "CUPOM FISCAL\n"
    "---------------------------------------------------------\n"
    "01   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n"
    "02   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n"
    "03   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n"
    "04   AGU MIN NESTLE 510ML    1un F1                 1,39)\n"
    "05   AGU MIN NESTLE 510ML    1un F1                 1,39)\n"
    "---------------------------------------------------------\n"
    "TOTAL  R$                                           27,23\n"
    "DINHEIROv                                           29,00\n"
    "\n"
    "TROCO R$                                             1,77\n"
    "Valor dos Tributos R$2,15(7,90%)\n"
    "ITEM(S) CINORADIS 5\n"
    "OP.:15326  PDV:9  BR,BF:93466\n"
    "OBRIGADO PERA PREFERENCIA.\n"
    "                       VOLTE SEMPRE!    SAC 0800 724 2822\n"
    "---------------------------------------------------------\n"
    "                   MD5:  fe028828a532a7dbaf4271155aa4e2db\n"
    "                     Calypso_CA CA.20.c13 – Unisys Brasil\n"
    "---------------------------------------------------------\n"
    "DARUMA AUTOMAÇÃO   MACH 2\n"
    "ECF-IF VERSÃO:01,00,00 ECF:093\n"
    "Lj:0204 OPR:ANGELA JORGE\n"
    "DDDDDDDDDAEHFGBFCC\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "FAB:DR0911BR000000275026\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"PortugueseCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"     COMERCIAL DE ALIMENTOS\n"
    "            STAR LTDA.\n"
    "      Avenida Moyses Roysen,\n"
    "        S/N Vila Guilherme\n"
    "  Cep: 02049-010 – Sao Paulo – SP\n"
    "      CNPJ: 62.545.579/0013-69\n"
    "IE:110.819.138.118  IM: 9.041.041-5\n"
    "-----------------------------------\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "CCF:133939   COO:227808\n"
    "-----------------------------------\n"
    "CUPOM FISCAL\n"
    "-----------------------------------\n"
    "01  CAFÉ DO PONTO TRAD A\n"
    "                      1un F1  8,15)\n"
    "02  CAFÉ DO PONTO TRAD A\n"
    "                      1un F1  8,15)\n"
    "03  CAFÉ DO PONTO TRAD A\n"
    "                      1un F1  8,15)\n"
    "04  AGU MIN NESTLE 510ML\n"
    "                      1un F1  1,39)\n"
    "05  AGU MIN NESTLE 510ML\n"
    "                      1un F1  1,39)\n"
    "-----------------------------------\n"
    "TOTAL  R$                     27,23\n"
    "DINHEIROv                     29,00\n"
    "\n"
    "TROCO R$                       1,77\n"
    "Valor dos Tributos R$2,15(7,90%)\n"
    "ITEM(S) CINORADIS 5\n"
    "OP.:15326  PDV:9  BR,BF:93466\n"
    "OBRIGADO PERA PREFERENCIA.\n"
    "VOLTE SEMPRE!     SAC 0800 724 2822\n"
    "-----------------------------------\n"
    "MD5:\n"
    "fe028828a532a7dbaf4271155aa4e2db\n"
    "Calypso_CA CA.20.c13\n"
    " – Unisys Brasil\n"
    "-----------------------------------\n"
    "DARUMA AUTOMAÇÃO   MACH 2\n"
    "ECF-IF VERSÃO:01,00,00 ECF:093\n"
    "Lj:0204 OPR:ANGELA JORGE\n"
    "DDDDDDDDDAEHFGBFCC\n"
    "MM/DD/YYYY HH:MM:SS\n"
    "FAB:DR0911BR000000275026\n";
    
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
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"COMERCIAL DE ALIMENTOS STAR LTDA.\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Avenida Moyses Roysen, S/N  Vila Guilherme\n"
                          "Cep: 02049-010 – Sao Paulo – SP\n"
                          "CNPJ: 62.545.579/0013-69\n"
                          "IE:110.819.138.118  IM: 9.041.041-5\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n"
                          "------------------------------------------\n"
                          "CUPOM FISCAL\n"
                          "------------------------------------------\n"
                          "001   2505    CAFÉ DO PONTO TRAD A\n"
                         "                            1un F1  8,15)\n"
                          "002   2505    CAFÉ DO PONTO TRAD A\n"
                         "                            1un F1  8,15)\n"
                          "003   2505    CAFÉ DO PONTO TRAD A\n"
                         "                            1un F1  8,15)\n"
                          "004   6129    AGU MIN NESTLE 510ML\n"
                         "                            1un F1  1,39)\n"
                          "005   6129    AGU MIN NESTLE 510ML\n"
                         "                            1un F1  1,39)\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"TOTAL  R$      27,23\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendData:[@"DINHEIROv                          29,00\n"
                          "TROCO R$                            1,77\n"
                          "Valor dos Tributos R$2,15 (7,90%)\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"ITEM(S) CINORADIS 5\n"
                          "OP.:15326  PDV:9  BR,BF:93466\n"
                          "OBRIGADO PERA PREFERENCIA.\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"VOLTE SEMPRE!\n"
                                           "\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"SAC 0800 724 2822\n"
                          "------------------------------------------\n"
                          "MD5:fe028828a532a7dbaf4271155aa4e2db\n"
                          "Calypso_CA CA.20.c13 – Unisys Brasil\n"
                          "------------------------------------------\n"
                          "DARUMA AUTOMAÇÃO   MACH 2\n"
                          "ECF-IF VERSÃO:01,00,00 ECF:093\n"
                          "Lj:0204 OPR:ANGELA JORGE\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"DDDDDDDDDAEHFGBFCC\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "FAB:DR0911BR000000275026\n"
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
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"\nCOMERCIAL DE ALIMENTOS STAR LTDA.\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Avenida Moyses Roysen, S/N  Vila Guilherme\n"
                          "Cep: 02049-010 – Sao Paulo - SP\n"
                          "CNPJ: 62.545.579/0013-69\n"
                          "IE:110.819.138.118  IM: 9.041.041-5\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n"
                          "------------------------------------------\n"
                          "CUPOM FISCAL\n"
                          "------------------------------------------\n"
                          "01 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n"
                          "02 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n"
                          "03 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n"
                          "04 6129 AGU MIN NESTLE 510ML  1un F1 1,39)\n"
                          "05 6129 AGU MIN NESTLE 510ML  1un F1 1,39)\n"
                          "------------------------------------------\n"
                          "TOTAL  R$                            27,23\n"
                          "DINHEIROv                            29,00\n"
                          "TROCO R$                              1,77\n"
                          "Valor dos Tributos R$2,15 (7,90%)\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"ITEM(S) CINORADIS 5\n"
                          "OP.:15326  PDV:9  BR,BF:93466\n"
                          "OBRIGADO PERA PREFERENCIA.\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleWidth:[@"VOLTE SEMPRE!\n"
                                           "\n" dataUsingEncoding:encoding] width:2];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"SAC 0800 724 2822\n"
                          "------------------------------------------\n"
                          "MD5:  fe028828a532a7dbaf4271155aa4e2db\n"
                          "Calypso_CA CA.20.c13 – Unisys Brasil\n"
                          "------------------------------------------\n"
                          "DARUMA AUTOMAÇÃO   MACH 2\n"
                          "ECF-IF VERSÃO:01,00,00 ECF:093\n"
                          "Lj:0204 OPR:ANGELA JORGE\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"DDDDDDDDDAEHFGBFCC\n"
                          "MM/DD/YYYY HH:MM:SS\n"
                          "FAB:DR0911BR000000275026\n" dataUsingEncoding:encoding]];
}

@end
