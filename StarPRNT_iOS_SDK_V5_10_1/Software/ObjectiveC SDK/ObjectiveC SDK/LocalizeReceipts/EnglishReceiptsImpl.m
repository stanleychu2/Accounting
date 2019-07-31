//
//  EnglishReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "EnglishReceiptsImpl.h"

@implementation EnglishReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"En";
    
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
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                          "123 Star Road\n"
                          "City, State 12345\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY    Time:HH:MM PM\n"
                          "--------------------------------\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU         Description    Total\n"
                          "300678566   PLAIN T-SHIRT  10.99\n"
                          "300692003   BLACK DENIM    29.99\n"
                          "300651148   BLUE DENIM     29.99\n"
                          "300642980   STRIPED DRESS  49.99\n"
                          "300638471   BLACK BOOTS    35.99\n"
                          "\n"
                          "Subtotal                  156.95\n"
                          "Tax                         0.00\n"
                          "--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total     " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"--------------------------------\n"
                          "\n"
                          "Charge\n"
                          "159.95\n"
                          "Visa XXXX-XXXX-XXXX-0123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
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
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                          "123 Star Road\n"
                          "City, State 12345\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY                    Time:HH:MM PM\n"
                          "------------------------------------------------\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE \n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU               Description              Total\n"
                          "300678566         PLAIN T-SHIRT            10.99\n"
                          "300692003         BLACK DENIM              29.99\n"
                          "300651148         BLUE DENIM               29.99\n"
                          "300642980         STRIPED DRESS            49.99\n"
                          "300638471         BLACK BOOTS              35.99\n"
                          "\n"
                          "Subtotal                                  156.95\n"
                          "Tax                                         0.00\n"
                          "------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total                       " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "\n"
                          "Charge\n"
                          "159.95\n"
                          "Visa XXXX-XXXX-XXXX-0123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
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
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                          "123 Star Road\n"
                          "City, State 12345\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY                                         Time:HH:MM PM\n"
                          "---------------------------------------------------------------------\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE \n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU                        Description                          Total\n"
                          "300678566                  PLAIN T-SHIRT                        10.99\n"
                          "300692003                  BLACK DENIM                          29.99\n"
                          "300651148                  BLUE DENIM                           29.99\n"
                          "300642980                  STRIPED DRESS                        49.99\n"
                          "300638471                  BLACK BOOTS                          35.99\n"
                          "\n"
                          "Subtotal                                                       156.95\n"
                          "Tax                                                              0.00\n"
                          "---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total                                            " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "\n"
                          "Charge\n"
                          "159.95\n"
                          "Visa XXXX-XXXX-XXXX-0123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"   Star Clothing Boutique\n"
    "        123 Star Road\n"
    "      City, State 12345\n"
    "\n"
    "Date:MM/DD/YYYY Time:HH:MM PM\n"
    "-----------------------------\n"
    "SALE\n"
    "SKU       Description   Total\n"
    "300678566 PLAIN T-SHIRT 10.99\n"
    "300692003 BLACK DENIM   29.99\n"
    "300651148 BLUE DENIM    29.99\n"
    "300642980 STRIPED DRESS 49.99\n"
    "30063847  BLACK BOOTS   35.99\n"
    "\n"
    "Subtotal               156.95\n"
    "Tax                      0.00\n"
    "-----------------------------\n"
    "Total                 $156.95\n"
    "-----------------------------\n"
    "\n"
    "Charge\n"
    "159.95\n"
    "Visa XXXX-XXXX-XXXX-0123\n"
    "Refunds and Exchanges\n"
    "Within 30 days with receipt\n"
    "And tags attached\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:10 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:11 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"        Star Clothing Boutique\n"
    "             123 Star Road\n"
    "           City, State 12345\n"
    "\n"
    "Date:MM/DD/YYYY          Time:HH:MM PM\n"
    "--------------------------------------\n"
    "SALE\n"
    "SKU            Description       Total\n"
    "300678566      PLAIN T-SHIRT     10.99\n"
    "300692003      BLACK DENIM       29.99\n"
    "300651148      BLUE DENIM        29.99\n"
    "300642980      STRIPED DRESS     49.99\n"
    "30063847       BLACK BOOTS       35.99\n"
    "\n"
    "Subtotal                        156.95\n"
    "Tax                               0.00\n"
    "--------------------------------------\n"
    "Total                          $156.95\n"
    "--------------------------------------\n"
    "\n"
    "Charge\n"
    "159.95\n"
    "Visa XXXX-XXXX-XXXX-0123\n"
    "Refunds and Exchanges\n"
    "Within 30 days with receipt\n"
    "And tags attached\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"                   Star Clothing Boutique\n"
    "                        123 Star Road\n"
    "                      City, State 12345\n"
    "\n"
    "Date:MM/DD/YYYY                             Time:HH:MM PM\n"
    "---------------------------------------------------------\n"
    "SALE\n"
    "SKU                     Description                 Total\n"
    "300678566               PLAIN T-SHIRT               10.99\n"
    "300692003               BLACK DENIM                 29.99\n"
    "300651148               BLUE DENIM                  29.99\n"
    "300642980               STRIPED DRESS               49.99\n"
    "300638471               BLACK BOOTS                 35.99\n"
    "\n"
    "Subtotal                                           156.95\n"
    "Tax                                                  0.00\n"
    "---------------------------------------------------------\n"
    "Total                                             $156.95\n"
    "---------------------------------------------------------\n"
    "\n"
    "Charge\n"
    "159.95\n"
    "Visa XXXX-XXXX-XXXX-0123\n"
    "Refunds and Exchanges\n"
    "Within 30 days with receipt\n"
    "And tags attached\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"EnglishCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"      Star Clothing Boutique\n"
    "           123 Star Road\n"
    "         City, State 12345\n"
    "\n"
    "Date:MM/DD/YYYY       Time:HH:MM PM\n"
    "-----------------------------------\n"
    "SALE\n"
    "SKU          Description      Total\n"
    "300678566    PLAIN T-SHIRT    10.99\n"
    "300692003    BLACK DENIM      29.99\n"
    "300651148    BLUE DENIM       29.99\n"
    "300642980    STRIPED DRESS    49.99\n"
    "30063847     BLACK BOOTS      35.99\n"
    "\n"
    "Subtotal                     156.95\n"
    "Tax                            0.00\n"
    "-----------------------------------\n"
    "Total                       $156.95\n"
    "-----------------------------------\n"
    "\n"
    "Charge\n"
    "159.95\n"
    "Visa XXXX-XXXX-XXXX-0123\n"
    "Refunds and Exchanges\n"
    "Within 30 days with receipt\n"
    "And tags attached\n";
    
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
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                          "123 Star Road\n"
                          "City, State 12345\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY              Time:HH:MM PM\n"
                          "------------------------------------------\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE \n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU            Description           Total\n"
                          "300678566      PLAIN T-SHIRT         10.99\n"
                          "300692003      BLACK DENIM           29.99\n"
                          "300651148      BLUE DENIM            29.99\n"
                          "300642980      STRIPED DRESS         49.99\n"
                          "300638471      BLACK BOOTS           35.99\n"
                          "\n"
                          "Subtotal                            156.95\n"
                          "Tax                                   0.00\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total                 " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"------------------------------------------\n"
                          "\n"
                          "Charge\n"
                          "159.95\n"
                          "Visa XXXX-XXXX-XXXX-0123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
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
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                          "123 Star Road\n"
                          "City, State 12345\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY              Time:HH:MM PM\n"
                          "------------------------------------------\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE \n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU             Description          Total\n"
                          "300678566       PLAIN T-SHIRT        10.99\n"
                          "300692003       BLACK DENIM          29.99\n"
                          "300651148       BLUE DENIM           29.99\n"
                          "300642980       STRIPED DRESS        49.99\n"
                          "300638471       BLACK BOOTS          35.99\n"
                          "\n"
                          "Subtotal                            156.95\n"
                          "Tax                                   0.00\n"
                          "------------------------------------------\n"
                          "Total                              $156.95\n"
                          "------------------------------------------\n"
                          "\n"
                          "Charge\n"
                          "159.95\n"
                          "Visa XXXX-XXXX-XXXX-0123\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within" dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@" 30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
}

- (void)appendTextLabelData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendUnitFeed:20 * 2];
    
    [builder appendMultipleHeight:2];
    
    [builder appendData:[@"Star Micronics America, Inc." dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendData:[@"65 Clyde Road Suite G" dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendData:[@"Somerset, NJ 08873-3485 U.S.A" dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendMultipleHeight:1];
}

- (NSString *)createPasteTextLabelString {
    return @"Star Micronics America, Inc.\n"
            "65 Clyde Road Suite G\n"
            "Somerset, NJ 08873-3485 U.S.A";
}

- (void)appendPasteTextLabelData:(ISCBBuilder *)builder pasteText:(NSString *)pasteText utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendData:[pasteText dataUsingEncoding:encoding]];
}

@end
