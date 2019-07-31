//
//  GermanReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "GermanReceiptsImpl.h"

@implementation GermanReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"De";
    
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
    
    [builder appendInternational:SCBInternationalTypeGermany];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"STAR\n"
                                      "Supermarkt\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"\n"
                          "Das Internet von seiner\n"
                          "genussvollsten Seite\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleHeight:[@"www.Star-EMEM.com\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Gebührenfrei Rufnummer:\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"08006646701\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithEmphasis:[@"EUR\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Schmand 24%                 0.42\n"
                          "Kefir                       0.79\n"
                          "Haarspray                   1.79\n"
                          "Gurken ST                   0.59\n"
                          "Mandelknacker               1.59\n"
                          "Mandelknacker               1.59\n"
                          "Nussecken                   1.69\n"
                          "Nussecken                   1.69\n"
                          "Clemen.1kg NZ               1.49\n"
                          "2X\n"
                          "Zitronen ST                 1.18\n"
                          "4X\n"
                          "Grapefruit                  3.16\n"
                          "Party Garnelen              9.79\n"
                          "Apfelsaft                   1.39\n"
                          "Lauchzw./Schl.B             0.49\n"
                          "Butter                      1.19\n"
                          "Profi-Haartrockner         27.99\n"
                          "Mozarella 45%               0.59\n"
                          "Mozarella 45%               0.59\n"
                          "Bruschetta Brot             0.59\n"
                          "Weizenmehl                  0.39\n"
                          "Jodsalz                     0.19\n"
                          "Eier M braun Bod            1.79\n"
                          "Schlagsahne                 1.69\n"
                          "Schlagsahne                 1.69\n"
                          "\n"
                          "Rueckgeld              EUR  0.00\n"
                          "\n"
                          "19.00% MwSt.               13.14\n"
                          "NETTO-UMSATZ               82.33\n"
                          "--------------------------------\n"
                          "KontoNr:  0551716000 / 0 / 0512\n"
                          "BLZ:      58862159\n"
                          "Trace-Nr: 027929\n"
                          "Beleg:    7238\n"
                          "--------------------------------\n"
                          "Kas: 003/006    Bon  0377 PC01 P\n"
                          "Dat: 30.03.2015 Zeit 18:06:01 43\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"USt–ID:    DE125580123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"Vielen dank\n"
                                      "für Ihren Einkauf!\n"
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
    
    [builder appendInternational:SCBInternationalTypeGermany];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"STAR\n"
                                     "Supermarkt\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"\n"
                         "Das Internet von seiner genussvollsten Seite\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleHeight:[@"www.Star-EMEM.com\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Gebührenfrei Rufnummer:\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"08006646701\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithEmphasis:[@"EUR\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Schmand 24%                                 0.42\n"
                         "Kefir                                       0.79\n"
                         "Haarspray                                   1.79\n"
                         "Gurken ST                                   0.59\n"
                         "Mandelknacker                               1.59\n"
                         "Mandelknacker                               1.59\n"
                         "Nussecken                                   1.69\n"
                         "Nussecken                                   1.69\n"
                         "Clemen.1kg NZ                               1.49\n"
                         "2X\n"
                         "Zitronen ST                                 1.18\n"
                         "4X\n"
                         "Grapefruit                                  3.16\n"
                         "Party Garnelen                              9.79\n"
                         "Apfelsaft                                   1.39\n"
                         "Lauchzw./Schl.B                             0.49\n"
                         "Butter                                      1.19\n"
                         "Profi-Haartrockner                         27.99\n"
                         "Mozarella 45%                               0.59\n"
                         "Mozarella 45%                               0.59\n"
                         "Bruschetta Brot                             0.59\n"
                         "Weizenmehl                                  0.39\n"
                         "Jodsalz                                     0.19\n"
                         "Eier M braun Bod                            1.79\n"
                         "Schlagsahne                                 1.69\n"
                         "Schlagsahne                                 1.69\n"
                         "\n"
                         "Rueckgeld                              EUR  0.00\n"
                         "\n"
                         "19.00% MwSt.                               13.14\n"
                         "NETTO-UMSATZ                               82.33\n"
                         "------------------------------------------------\n"
                         "KontoNr:  0551716000 / 0 / 0512\n"
                         "BLZ:      58862159\n"
                         "Trace-Nr: 027929\n"
                         "Beleg:    7238\n"
                         "------------------------------------------------\n"
                         "Kas: 003/006    Bon  0377 PC01 P\n"
                         "Dat: 30.03.2015 Zeit 18:06:01 43\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"USt–ID:    DE125580123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"Vielen dank\n"
                                     "für Ihren Einkauf!\n"
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
    
    [builder appendInternational:SCBInternationalTypeGermany];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"STAR\n"
                                     "Supermarkt\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"\n"
                         "Das Internet von seiner genussvollsten Seite\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleHeight:[@"www.Star-EMEM.com\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Gebührenfrei Rufnummer:\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"08006646701\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithEmphasis:[@"EUR\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Schmand 24%                                                      0.42\n"
                         "Kefir                                                            0.79\n"
                         "Haarspray                                                        1.79\n"
                         "Gurken ST                                                        0.59\n"
                         "Mandelknacker                                                    1.59\n"
                         "Mandelknacker                                                    1.59\n"
                         "Nussecken                                                        1.69\n"
                         "Nussecken                                                        1.69\n"
                         "Clemen.1kg NZ                                                    1.49\n"
                         "2X\n"
                         "Zitronen ST                                                      1.18\n"
                         "4X\n"
                         "Grapefruit                                                       3.16\n"
                         "Party Garnelen                                                   9.79\n"
                         "Apfelsaft                                                        1.39\n"
                         "Lauchzw./Schl.B                                                  0.49\n"
                         "Butter                                                           1.19\n"
                         "Profi-Haartrockner                                              27.99\n"
                         "Mozarella 45%                                                    0.59\n"
                         "Mozarella 45%                                                    0.59\n"
                         "Bruschetta Brot                                                  0.59\n"
                         "Weizenmehl                                                       0.39\n"
                         "Jodsalz                                                          0.19\n"
                         "Eier M braun Bod                                                 1.79\n"
                         "Schlagsahne                                                      1.69\n"
                         "Schlagsahne                                                      1.69\n"
                         "\n"
                         "Rueckgeld                                                   EUR  0.00\n"
                         "\n"
                         "19.00% MwSt.                                                    13.14\n"
                         "NETTO-UMSATZ                                                    82.33\n"
                         "---------------------------------------------------------------------\n"
                         "KontoNr:  0551716000 / 0 / 0512\n"
                         "BLZ:      58862159\n"
                         "Trace-Nr: 027929\n"
                         "Beleg:    7238\n"
                         "---------------------------------------------------------------------\n"
                         "Kas: 003/006    Bon  0377 PC01 P\n"
                         "Dat: 30.03.2015 Zeit 18:06:01 43\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"USt–ID:    DE125580123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"Vielen dank\n"
                                     "für Ihren Einkauf!\n"
                                     "\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"           STAR\n"
    "        Supermarkt\n"
    "\n"
    " Das Internet von seiner\n"
    "   genussvollsten Seite\n"
    "\n"
    "    www.Star-EMEM.com\n"
    " Gebührenfrei Rufnummer:\n"
    "       08006646701\n"
    "--------------------------\n"
    "                       EUR\n"
    "Schmand 24%           0.42\n"
    "Kefir                 0.79\n"
    "Haarspray             1.79\n"
    "Gurken ST             0.59\n"
    "Mandelknacker         1.59\n"
    "Mandelknacker         1.59\n"
    "Nussecken             1.69\n"
    "Nussecken             1.69\n"
    "Clemen.1kg NZ         1.49\n"
    "2X\n"
    "Zitronen ST           1.18\n"
    "4X\n"
    "Grapefruit            3.16\n"
    "Party Garnelen        9.79\n"
    "Apfelsaft             1.39\n"
    "Lauchzw./Schl.B       0.49\n"
    "Butter                1.19\n"
    "Profi-Haartrockner   27.99\n"
    "Mozarella 45%         0.59\n"
    "Mozarella 45%         0.59\n"
    "Bruschetta Brot       0.59\n"
    "Weizenmehl            0.39\n"
    "Jodsalz               0.19\n"
    "Eier M braun Bod      1.79\n"
    "Schlagsahne           1.69\n"
    "Schlagsahne           1.69\n"
    "\n"
    "Rueckgeld        EUR  0.00\n"
    "\n"
    "19.00% MwSt.         13.14\n"
    "NETTO-UMSATZ         82.33\n"
    "--------------------------\n"
    "KontoNr: 0551716000/0/0512\n"
    "BLZ:     58862159\n"
    "Trace-Nr:027929\n"
    "Beleg:   7238\n"
    "--------------------------\n"
    "Kas:003/006 Bon0377 PC01 P\n"
    "Dat:30.03.2015\n"
    "Zeit18:06:01            43\n"
    "\n"
    "  USt–ID:    DE125580123\n"
    "\n"
    "       Vielen dank\n"
    "    für Ihren Einkauf!\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"                 STAR\n"
    "              Supermarkt\n"
    "\n"
    "       Das Internet von seiner\n"
    "         genussvollsten Seite\n"
    "\n"
    "          www.Star-EMEM.com\n"
    "       Gebührenfrei Rufnummer:\n"
    "             08006646701\n"
    "--------------------------------------\n"
    "                                   EUR\n"
    "Schmand 24%                       0.42\n"
    "Kefir                             0.79\n"
    "Haarspray                         1.79\n"
    "Gurken ST                         0.59\n"
    "Mandelknacker                     1.59\n"
    "Mandelknacker                     1.59\n"
    "Nussecken                         1.69\n"
    "Nussecken                         1.69\n"
    "Clemen.1kg NZ                     1.49\n"
    "2X\n"
    "Zitronen ST                       1.18\n"
    "4X\n"
    "Grapefruit                        3.16\n"
    "Party Garnelen                    9.79\n"
    "Apfelsaft                         1.39\n"
    "Lauchzw./Schl.B                   0.49\n"
    "Butter                            1.19\n"
    "Profi-Haartrockner               27.99\n"
    "Mozarella 45%                     0.59\n"
    "Mozarella 45%                     0.59\n"
    "Bruschetta Brot                   0.59\n"
    "Weizenmehl                        0.39\n"
    "Jodsalz                           0.19\n"
    "Eier M braun Bod                  1.79\n"
    "Schlagsahne                       1.69\n"
    "Schlagsahne                       1.69\n"
    "\n"
    "Rueckgeld                    EUR  0.00\n"
    "\n"
    "19.00% MwSt.                     13.14\n"
    "NETTO-UMSATZ                     82.33\n"
    "--------------------------------------\n"
    "KontoNr:  0551716000 / 0 / 0512\n"
    "BLZ:      58862159\n"
    "Trace-Nr: 027929\n"
    "Beleg:    7238\n"
    "--------------------------------------\n"
    "Kas: 003/006    Bon  0377 PC01 P\n"
    "Dat: 30.03.2015 Zeit 18:06:01 43\n"
    "\n"
    "        USt–ID:    DE125580123\n"
    "\n"
    "             Vielen dank\n"
    "          für Ihren Einkauf!\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"                          STAR\n"
    "                       Supermarkt\n"
    "\n"
    "                Das Internet von seiner\n"
    "                  genussvollsten Seite\n"
    "\n"
    "                   www.Star-EMEM.com\n"
    "                Gebührenfrei Rufnummer:\n"
    "                      08006646701\n"
    "---------------------------------------------------------\n"
    "                                                      EUR\n"
    "Schmand 24%                                          0.42\n"
    "Kefir                                                0.79\n"
    "Haarspray                                            1.79\n"
    "Gurken ST                                            0.59\n"
    "Mandelknacker                                        1.59\n"
    "Mandelknacker                                        1.59\n"
    "Nussecken                                            1.69\n"
    "Nussecken                                            1.69\n"
    "Clemen.1kg NZ                                        1.49\n"
    "2X\n"
    "Zitronen ST                                          1.18\n"
    "4X\n"
    "Grapefruit                                           3.16\n"
    "Party Garnelen                                       9.79\n"
    "Apfelsaft                                            1.39\n"
    "Lauchzw./Schl.B                                      0.49\n"
    "Butter                                               1.19\n"
    "Profi-Haartrockner                                  27.99\n"
    "Mozarella 45%                                        0.59\n"
    "Mozarella 45%                                        0.59\n"
    "Bruschetta Brot                                      0.59\n"
    "Weizenmehl                                           0.39\n"
    "Jodsalz                                              0.19\n"
    "Eier M braun Bod                                     1.79\n"
    "Schlagsahne                                          1.69\n"
    "Schlagsahne                                          1.69\n"
    "\n"
    "Rueckgeld                                       EUR  0.00\n"
    "\n"
    "19.00% MwSt.                                        13.14\n"
    "NETTO-UMSATZ                                        82.33\n"
    "---------------------------------------------------------\n"
    "KontoNr:  0551716000 / 0 / 0512\n"
    "BLZ:      58862159\n"
    "Trace-Nr: 027929\n"
    "Beleg:    7238\n"
    "---------------------------------------------------------\n"
    "Kas: 003/006    Bon  0377 PC01 P\n"
    "Dat: 30.03.2015 Zeit 18:06:01 43\n"
    "\n"
    "                 USt–ID:    DE125580123\n"
    "\n"
    "                      Vielen dank\n"
    "                   für Ihren Einkauf!\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"GermanCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"               STAR\n"
    "            Supermarkt\n"
    "\n"
    "      Das Internet von seiner\n"
    "       genussvollsten Seite\n"
    "\n"
    "         www.Star-EMEM.com\n"
    "      Gebührenfrei Rufnummer:\n"
    "            08006646701\n"
    "-----------------------------------\n"
    "                                EUR\n"
    "Schmand 24%                    0.42\n"
    "Kefir                          0.79\n"
    "Haarspray                      1.79\n"
    "Gurken ST                      0.59\n"
    "Mandelknacker                  1.59\n"
    "Mandelknacker                  1.59\n"
    "Nussecken                      1.69\n"
    "Nussecken                      1.69\n"
    "Clemen.1kg NZ                  1.49\n"
    "2X\n"
    "Zitronen ST                    1.18\n"
    "4X\n"
    "Grapefruit                     3.16\n"
    "Party Garnelen                 9.79\n"
    "Apfelsaft                      1.39\n"
    "Lauchzw./Schl.B                0.49\n"
    "Butter                         1.19\n"
    "Profi-Haartrockner            27.99\n"
    "Mozarella 45%                  0.59\n"
    "Mozarella 45%                  0.59\n"
    "Bruschetta Brot                0.59\n"
    "Weizenmehl                     0.39\n"
    "Jodsalz                        0.19\n"
    "Eier M braun Bod               1.79\n"
    "Schlagsahne                    1.69\n"
    "Schlagsahne                    1.69\n"
    "\n"
    "Rueckgeld                 EUR  0.00\n"
    "\n"
    "19.00% MwSt.                  13.14\n"
    "NETTO-UMSATZ                  82.33\n"
    "-----------------------------------\n"
    "KontoNr:  0551716000 / 0 / 0512\n"
    "BLZ:      58862159\n"
    "Trace-Nr: 027929\n"
    "Beleg:    7238\n"
    "-----------------------------------\n"
    "Kas: 003/006    Bon  0377 PC01 P\n"
    "Dat: 30.03.2015 Zeit 18:06:01 43\n"
    "\n"
    "      USt–ID:    DE125580123\n"
    "\n"
    "            Vielen dank\n"
    "        für Ihren Einkauf!\n";
    
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
    
    [builder appendInternational:SCBInternationalTypeGermany];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"STAR\n"
                                     "Supermarkt\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"\n"
                         "Das Internet von seiner\n"
                         "genussvollsten Seite\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleHeight:[@"www.Star-EMEM.com\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Gebührenfrei Rufnummer:\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"08006646701\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"                                       EUR\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Schmand 24%                           0.42\n"
                         "Kefir                                 0.79\n"
                         "Haarspray                             1.79\n"
                         "Gurken ST                             0.59\n"
                         "Mandelknacker                         1.59\n"
                         "Mandelknacker                         1.59\n"
                         "Nussecken                             1.69\n"
                         "Nussecken                             1.69\n"
                         "Clemen.1kg NZ                         1.49\n"
                         "2X\n"
                         "Zitronen ST                           1.18\n"
                         "4X\n"
                         "Grapefruit                            3.16\n"
                         "Party Garnelen                        9.79\n"
                         "Apfelsaft                             1.39\n"
                         "Lauchzw./Schl.B                       0.49\n"
                         "Butter                                1.19\n"
                         "Profi-Haartrockner                   27.99\n"
                         "Mozarella 45%                         0.59\n"
                         "Mozarella 45%                         0.59\n"
                         "Bruschetta Brot                       0.59\n"
                         "Weizenmehl                            0.39\n"
                         "Jodsalz                               0.19\n"
                         "Eier M braun Bod                      1.79\n"
                         "Schlagsahne                           1.69\n"
                         "Schlagsahne                           1.69\n"
                         "\n"
                         "Rueckgeld                        EUR  0.00\n"
                         "\n"
                         "19.00% MwSt.                         13.14\n"
                         "NETTO-UMSATZ                         82.33\n"
                         "------------------------------------------\n"
                         "KontoNr:  0551716000 / 0 / 0512\n"
                         "BLZ:      58862159\n"
                         "Trace-Nr: 027929\n"
                         "Beleg:    7238\n"
                         "------------------------------------------\n"
                         "Kas: 003/006    Bon  0377 PC01 P\n"
                         "Dat: 30.03.2015 Zeit 18:06:01 43\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"USt–ID:    DE125580123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"Vielen dank\n"
                                     "für Ihren Einkauf!\n"
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
    
    [builder appendInternational:SCBInternationalTypeGermany];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"STAR\n"
                                     "Supermarkt\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"\n"
                         "Das Internet von seiner\n"
                         "genussvollsten Seite\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultipleHeight:[@"www.Star-EMEM.com\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendData:[@"Gebührenfrei Rufnummer:\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"08006646701\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendDataWithEmphasis:[@"EUR\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Schmand 24%                           0.42\n"
                         "Kefir                                 0.79\n"
                         "Haarspray                             1.79\n"
                         "Gurken ST                             0.59\n"
                         "Mandelknacker                         1.59\n"
                         "Mandelknacker                         1.59\n"
                         "Nussecken                             1.69\n"
                         "Nussecken                             1.69\n"
                         "Clemen.1kg NZ                         1.49\n"
                         "2X\n"
                         "Zitronen ST                           1.18\n"
                         "4X\n"
                         "Grapefruit                            3.16\n"
                         "Party Garnelen                        9.79\n"
                         "Apfelsaft                             1.39\n"
                         "Lauchzw./Schl.B                       0.49\n"
                         "Butter                                1.19\n"
                         "Profi-Haartrockner                   27.99\n"
                         "Mozarella 45%                         0.59\n"
                         "Mozarella 45%                         0.59\n"
                         "Bruschetta Brot                       0.59\n"
                         "Weizenmehl                            0.39\n"
                         "Jodsalz                               0.19\n"
                         "Eier M braun Bod                      1.79\n"
                         "Schlagsahne                           1.69\n"
                         "Schlagsahne                           1.69\n"
                         "\n"
                         "Rueckgeld                        EUR  0.00\n"
                         "\n"
                         "19.00% MwSt.                         13.14\n"
                         "NETTO-UMSATZ                         82.33\n"
                         "------------------------------------------\n"
                         "KontoNr:  0551716000 / 0 / 0512\n"
                         "BLZ:      58862159\n"
                         "Trace-Nr: 027929\n"
                         "Beleg:    7238\n"
                         "------------------------------------------\n"
                         "Kas: 003/006    Bon  0377 PC01 P\n"
                         "Dat: 30.03.2015 Zeit 18:06:01 43\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"USt–ID:    DE125580123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"Vielen dank\n"
                                     "für Ihren Einkauf!\n" dataUsingEncoding:encoding]];
}

@end
