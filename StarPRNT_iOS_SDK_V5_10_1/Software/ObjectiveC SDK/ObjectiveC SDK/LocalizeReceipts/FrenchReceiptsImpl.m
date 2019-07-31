//
//  FrenchReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "FrenchReceiptsImpl.h"

@implementation FrenchReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"Fr";
    
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
    
    [builder appendInternational:SCBInternationalTypeFrance];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics Communications\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"AVENUE LA MOTTE PICQUET\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"--------------------------------\n"
                          "Date   : MM/DD/YYYY\n"
                          "Heure  : HH:MM\n"
                          "Boutique: OLUA23    Caisse: 0001\n"
                          "Conseiller: 002970  Ticket: 3881\n"
                          "--------------------------------\n"
                          "\n"
                          "Vous avez été servi par : Souad\n"
                          "\n"
                          "CAC IPHONE\n"
                          "3700615033581 1 X 19.99€  19.99€\n"
                          "\n"
                          "dont contribution\n"
                          " environnementale :\n"
                          "CAC IPHONE                 0.01€\n"
                          "--------------------------------\n"
                          "1 Piéce(s) Total :        19.99€\n"
                          "Mastercard Visa  :        19.99€\n"
                          "\n"
                          "Taux TVA    Montant H.T.   T.V.A\n"
                          "  20%          16.66€      3.33€\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Merci de votre visite et.\n"
                          "à bientôt.\n"
                          "Conservez votre ticket il\n"
                          "vous sera demandé pour\n"
                          "tout échange.\n"
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
    
    [builder appendInternational:SCBInternationalTypeFrance];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics Communications\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"AVENUE LA MOTTE PICQUET\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "Date: MM/DD/YYYY    Heure: HH:MM\n"
                          "Boutique: OLUA23    Caisse: 0001\n"
                          "Conseiller: 002970  Ticket: 3881\n"
                          "------------------------------------------------\n"
                          "\n"
                          "Vous avez été servi par : Souad\n"
                          "\n"
                          "CAC IPHONE\n"
                          "3700615033581   1    X     19.99€         19.99€\n"
                          "\n"
                          "dont contribution environnementale :\n"
                          "CAC IPHONE                                 0.01€\n"
                          "------------------------------------------------\n"
                          "1 Piéce(s) Total :                        19.99€\n"
                          "Mastercard Visa  :                        19.99€\n"
                          "\n"
                          "Taux TVA    Montant H.T.   T.V.A\n"
                          "  20%          16.66€      3.33€\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Merci de votre visite et. à bientôt.\n"
                          "Conservez votre ticket il\n"
                          "vous sera demandé pour tout échange.\n" dataUsingEncoding:encoding]];
    
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
    
    [builder appendInternational:SCBInternationalTypeFrance];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultiple:[@"Star Micronics Communications\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"AVENUE LA MOTTE PICQUET\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "Date: MM/DD/YYYY    Heure: HH:MM\n"
                          "Boutique: OLUA23    Caisse: 0001\n"
                          "Conseiller: 002970  Ticket: 3881\n"
                          "---------------------------------------------------------------------\n"
                          "\n"
                          "Vous avez été servi par : Souad\n"
                          "\n"
                          "CAC IPHONE\n"
                          "3700615033581   1    X     19.99€                              19.99€\n"
                          "\n"
                          "dont contribution environnementale :\n"
                          "CAC IPHONE                                                      0.01€\n"
                          "---------------------------------------------------------------------\n"
                          "1 Piéce(s) Total :                                             19.99€\n"
                          "Mastercard Visa  :                                             19.99€\n"
                          "\n"
                          "Taux TVA    Montant H.T.   T.V.A\n"
                          "  20%          16.66€      3.33€\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Merci de votre visite et. à bientôt.\n"
                          "Conservez votre ticket il\n"
                          "vous sera demandé pour tout échange.\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"      Star Micronics\n"
    "      Communications\n"
    "      AVENUE LA MOTTE\n"
    " PICQUET City, State 12345\n"
    "\n"
    "--------------------------\n"
    "Date: MM/DD/YYYY\n"
    "Time:HH:MM PM\n"
    "Boutique: OLUA23\n"
    "Caisse: 0001\n"
    "Conseiller: 002970\n"
    "Ticket: 3881\n"
    "--------------------------\n"
    "Vous avez été servi par :\n"
    "                     Souad\n"
    "CAC IPHONE\n"
    "3700615033581 1 X   19.99€\n"
    "                    19.99€\n"
    "dont contribution\n"
    " environnementale :\n"
    "CAC IPHONE           0.01€\n"
    "--------------------------\n"
    " 1 Piéce(s) Total : 19.99€\n"
    "\n"
    "  Mastercard Visa : 19.99€\n"
    "Taux TVA Montant H.T.\n"
    "     20%       16.66€\n"
    "T.V.A\n"
    "3.33€\n"
    "Merci de votre visite et.\n"
    "à bientôt.\n"
    "Conservez votre ticket il\n"
    "vous sera demandé pour\n"
    "tout échange.\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"      Star Micronics Communications\n"
    "             AVENUE LA MOTTE\n"
    "        PICQUET City, State 12345\n"
    "\n"
    "--------------------------------------\n"
    "     Date: MM/DD/YYYY    Time:HH:MM PM\n"
    "        Boutique: OLUA23  Caisse: 0001\n"
    "      Conseiller: 002970  Ticket: 3881\n"
    "--------------------------------------\n"
    "Vous avez été servi par : Souad\n"
    "CAC IPHONE\n"
    "3700615033581   1 X 19.99€      19.99€\n"
    "dont contribution environnementale :\n"
    "CAC IPHONE                       0.01€\n"
    "--------------------------------------\n"
    "  1 Piéce(s)    Total :         19.99€\n"
    "\n"
    "        Mastercard Visa  :      19.99€\n"
    "          Taux TVA  Montant H.T. T.V.A\n"
    "               20%       16.66€  3.33€\n"
    "  Merci de votre visite et. à bientôt.\n"
    "   Conservez votre ticket il vous sera\n"
    "            demandé pour tout échange.\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"             Star Micronics Communications\n"
    "       AVENUE LA MOTTE PICQUET City, State 12345\n"
    "\n"
    "-------------------------------------------------------\n"
    "                      Date: MM/DD/YYYY    Time:HH:MM PM\n"
    "                  Boutique: OLUA23         Caisse: 0001\n"
    "                Conseiller: 002970         Ticket: 3881\n"
    "-------------------------------------------------------\n"
    "Vous avez été servi par : Souad\n"
    "CAC IPHONE\n"
    "3700615033581      1  X  19.99€                  19.99€\n"
    "dont contribution environnementale :\n"
    "CAC IPHONE                                        0.01€\n"
    "-------------------------------------------------------\n"
    "        1 Piéce(s)    Total :                    19.99€\n"
    "\n"
    "        Mastercard Visa  :                       19.99€\n"
    "                           Taux TVA  Montant H.T. T.V.A\n"
    "                              20%         16.66€  3.33€\n"
    "                   Merci de votre visite et. à bientôt.\n"
    " Conservez votre ticket il vous sera demandé pour\n"
    " tout échange.\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"FrenchCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"   Star Micronics Communications\n"
    "           AVENUE LA MOTTE\n"
    "      PICQUET City, State 12345\n"
    "\n"
    "-----------------------------------\n"
    "  Date: MM/DD/YYYY    Time:HH:MM PM\n"
    "     Boutique: OLUA23  Caisse: 0001\n"
    "   Conseiller: 002970  Ticket: 3881\n"
    "-----------------------------------\n"
    "Vous avez été servi par : Souad\n"
    "CAC IPHONE\n"
    "3700615033581  1 X 19.99€    19.99€\n"
    "dont contribution environnementale:\n"
    "CAC IPHONE                    0.01€\n"
    "-----------------------------------\n"
    "  1 Piéce(s)    Total :      19.99€\n"
    "\n"
    "     Mastercard Visa  :      19.99€\n"
    "       Taux TVA  Montant H.T. T.V.A\n"
    "            20%       16.66€  3.33€\n"
    "Merci de votre visite et.\n"
    "à bientôt.\n"
    "Conservez votre ticket il vous sera\n"
    "demandé pour tout échange.\n";
    
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
    
    [builder appendInternational:SCBInternationalTypeFrance];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics Communications\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"AVENUE LA MOTTE PICQUET\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "Date: MM/DD/YYYY    Heure: HH:MM\n"
                          "Boutique: OLUA23    Caisse: 0001\n"
                          "Conseiller: 002970  Ticket: 3881\n"
                          "------------------------------------------\n"
                          "\n"
                          "Vous avez été servi par : Souad\n"
                          "\n"
                          "CAC IPHONE\n"
                          "3700615033581   1    X   19.99€     19.99€\n"
                          "\n"
                          "dont contribution environnementale :\n"
                          "CAC IPHONE                           0.01€\n"
                          "------------------------------------------\n"
                          "1 Piéce(s) Total :                  19.99€\n"
                          "Mastercard Visa  :                  19.99€\n"
                          "\n"
                          "Taux TVA    Montant H.T.   T.V.A\n"
                          "  20%          16.66€      3.33€\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Merci de votre visite et. à bientôt.\n"
                          "Conservez votre ticket il\n"
                          "vous sera demandé pour tout échange.\n" dataUsingEncoding:encoding]];
    
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
    
    [builder appendInternational:SCBInternationalTypeFrance];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendData:[@"[If loaded.. Logo1 goes here]\n" dataUsingEncoding:encoding]];
//
//  [builder appendLogo:SCBLogoSizeNormal number:1];
    
    [builder appendDataWithMultipleHeight:[@"Star Micronics Communications\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"AVENUE LA MOTTE PICQUET\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "Date: MM/DD/YYYY    Heure: HH:MM\n"
                          "Boutique: OLUA23    Caisse: 0001\n"
                          "Conseiller: 002970  Ticket: 3881\n"
                          "------------------------------------------\n"
                          "\n"
                          "Vous avez été servi par : Souad\n"
                          "\n"
                          "CAC IPHONE\n"
                          "3700615033581 1 X 19.99€            19.99€\n"
                          "\n"
                          "dont contribution environnementale :\n"
                          "CAC IPHONE                           0.01€\n"
                          "------------------------------------------\n"
                          "1 Piéce(s) Total :                  19.99€\n"
                          "Mastercard Visa  :                  19.99€\n"
                          "\n"
                          "Taux TVA    Montant H.T.   T.V.A\n"
                          "  20%          16.66€      3.33€\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Merci de votre visite et. à bientôt.\n"
                          "Conservez votre ticket il\n"
                          "vous sera demandé pour tout échange.\n" dataUsingEncoding:encoding]];
}

@end
