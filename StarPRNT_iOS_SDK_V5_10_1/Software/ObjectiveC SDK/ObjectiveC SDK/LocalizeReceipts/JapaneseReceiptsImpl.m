//
//  JapaneseReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "JapaneseReceiptsImpl.h"

@implementation JapaneseReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"Ja";
    
    self.characterCode = StarIoExtCharacterCodeJapanese;
    
    return self;
}

- (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"スター電機\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"修理報告書　兼領収書\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"--------------------------------\n"
                          "発行日時：YYYY年MM月DD日HH時MM分\n"
                          "TEL：054-347-XXXX\n"
                          "\n"
                          "         ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n"
                          "お名前：池西　静子　様\n"
                          "御住所：静岡市清水区七ツ新屋\n"
                          "　　　　５３６番地\n"
                          "伝票番号：No.12345-67890\n"
                          "\n"
                          "　この度は修理をご用命頂き有難うございます。\n"
                          " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
                          "\n"
                          "品名／型名　数量　金額　備考\n"
                          "--------------------------------\n"
                          "制御基板　　   1 10,000  配達\n"
                          "操作スイッチ   1  3,800  配達\n"
                          "パネル　　　   1  2,000  配達\n"
                          "技術料　　　   1 15,000\n"
                          "出張費用　　   1  5,000\n"
                          "--------------------------------\n"
                          "\n"
                          "             小計      \\ 35,800\n"
                          "             内税      \\  1,790\n"
                          "             合計      \\ 37,590\n"
                          "\n"
                          "　お問合わせ番号　12345-67890\n"
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
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"スター電機\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"修理報告書　兼領収書\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "発行日時：YYYY年MM月DD日HH時MM分\n"
                          "TEL：054-347-XXXX\n"
                          "\n"
                          "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n"
                          "　お名前：池西　静子　様\n"
                          "　御住所：静岡市清水区七ツ新屋\n"
                          "　　　　　５３６番地\n"
                          "　伝票番号：No.12345-67890\n"
                          "\n"
                          "　この度は修理をご用命頂き有難うございます。\n"
                          " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
                          "\n"
                          "品名／型名　          数量      金額　   備考\n"
                          "------------------------------------------------\n"
                          "制御基板　          　  1      10,000     配達\n"
                          "操作スイッチ            1       3,800     配達\n"
                          "パネル　　          　  1       2,000     配達\n"
                          "技術料　          　　  1      15,000\n"
                          "出張費用　　            1       5,000\n"
                          "------------------------------------------------\n"
                          "\n"
                          "                            小計       \\ 35,800\n"
                          "                            内税       \\  1,790\n"
                          "                            合計       \\ 37,590\n"
                          "\n"
                          "　お問合わせ番号　　12345-67890\n"
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
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"スター電機\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"修理報告書　兼領収書\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "発行日時：YYYY年MM月DD日HH時MM分\n"
                          "TEL：054-347-XXXX\n"
                          "\n"
                          "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n"
                          "　お名前：池西　静子　様\n"
                          "　御住所：静岡市清水区七ツ新屋\n"
                          "　　　　　５３６番地\n"
                          "　伝票番号：No.12345-67890\n"
                          "\n"
                          "この度は修理をご用命頂き有難うございます。\n"
                          " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
                          "\n"
                          "品名／型名　                 数量             金額　          備考\n"
                          "---------------------------------------------------------------------\n"
                          "制御基板　　                   1             10,000            配達\n"
                          "操作スイッチ                   1              3,800            配達\n"
                          "パネル　　　                   1              2,000            配達\n"
                          "技術料　　　                   1             15,000\n"
                          "出張費用　　                   1              5,000\n"
                          "---------------------------------------------------------------------\n"
                          "\n"
                          "                                                 小計       \\ 35,800\n"
                          "                                                 内税       \\  1,790\n"
                          "                                                 合計       \\ 37,590\n"
                          "\n"
                          "　お問合わせ番号　　12345-67890\n"
                          "\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　スター電機\n"
    "　　　　修理報告書　兼領収書\n"
    "----------------------------\n"
    "発行日時：YYYY年MM月DD日HH時MM分\n"
    "TEL：054-347-XXXX\n"
    "\n"
    "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n"
    "　お名前：池西　静子　様\n"
    "　御住所：静岡市清水区七ツ新屋\n"
    "　　　　　５３６番地\n"
    "　伝票番号：No.12345-67890\n"
    "\n"
    "　この度は修理をご用命頂き有難うございます。\n"
    " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
    "\n"
    "品名／型名　 数量　　金額\n"
    "----------------------------\n"
    "制御基板　　　１　　１０，０００\n"
    "操作スイッチ　１　　　３，０００\n"
    "パネル　　　　１　　　２，０００\n"
    "技術料　　　　１　　１５，０００\n"
    "出張費用　　　１　　　５，０００\n"
    "----------------------------\n"
    "\n"
    "　　　　　　小計　¥ ３５，８００\n"
    "　　　　　　内税　¥ 　１，７９０\n"
    "　　　　　　合計　¥ ３７，５９０\n"
    "\n"
    "　お問合わせ番号　　12345-67890\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:11 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　　　　　スター電機\n"
    "　　　　　　　　修理報告書　兼領収書\n"
    "---------------------------------------\n"
    "発行日時：YYYY年MM月DD日HH時MM分\n"
    "TEL：054-347-XXXX\n"
    "\n"
    "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n"
    "　お名前：池西　静子　様\n"
    "　御住所：静岡市清水区七ツ新屋\n"
    "　　　　　５３６番地\n"
    "　伝票番号：No.12345-67890\n"
    "\n"
    "　この度は修理をご用命頂き有難うございます。\n"
    " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
    "\n"
    "品名／型名　　　　数量　　　金額　　　　備考\n"
    "---------------------------------------\n"
    "制御基板　　　　　　１　１０，０００　　配達\n"
    "操作スイッチ　　　　１　　３，８００　　配達\n"
    "パネル　　　　　　　１　　２，０００　　配達\n"
    "技術料　　　　　　　１　１５，０００\n"
    "出張費用　　　　　　１　　５，０００\n"
    "---------------------------------------\n"
    "\n"
    "　　　　　　　　　　　　小計　¥ ３５，８００\n"
    "　　　　　　　　　　　　内税　¥ 　１，７９０\n"
    "　　　　　　　　　　　　合計　¥ ３７，５９０\n"
    "\n"
    "　お問合わせ番号　　12345-67890\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　　　　　　　　　　スター電機\n"
    "　　　　　　　　　　　　　修理報告書　兼領収書\n"
    "---------------------------------------------------------\n"
    "発行日時：YYYY年MM月DD日HH時MM分\n"
    "TEL：054-347-XXXX\n"
    "\n"
    "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n"
    "　お名前：池西　静子　様\n"
    "　御住所：静岡市清水区七ツ新屋\n"
    "　　　　　５３６番地\n"
    "　伝票番号：No.12345-67890\n"
    "\n"
    "　この度は修理をご用命頂き有難うございます。\n"
    " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
    "\n"
    "品名／型名　　　　　　　　　数量　　　　　　金額　　　　　　備考\n"
    "---------------------------------------------------------\n"
    "制御基板　　　　　　　　　　　１　　　　１０，０００　　　　配達\n"
    "操作スイッチ　　　　　　　　　１　　　　　３，８００　　　　配達\n"
    "パネル　　　　　　　　　　　　１　　　　　２，０００　　　　配達\n"
    "技術料　　　　　　　　　　　　１　　　　１５，０００\n"
    "出張費用　　　　　　　　　　　１　　　　　５，０００\n"
    "---------------------------------------------------------\n"
    "\n"
    "　　　　　　　　　　　　　　　　　　　　　　小計　¥ ３５，８００\n"
    "　　　　　　　　　　　　　　　　　　　　　　内税　¥ 　１，７９０\n"
    "　　　　　　　　　　　　　　　　　　　　　　合計　¥ ３７，５９０\n"
    "\n"
    "　お問合わせ番号　　12345-67890\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"JapaneseCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"　　　　　　　 スター電機\n"
    "　　　　　 修理報告書　兼領収書\n"
    "-----------------------------------\n"
    "発行日時：YYYY年MM月DD日HH時MM分\n"
    "TEL：054-347-XXXX\n"
    "\n"
    "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n"
    "　お名前：池西　静子　様\n"
    "　御住所：静岡市清水区七ツ新屋\n"
    "　　　　　５３６番地\n"
    "　伝票番号：No.12345-67890\n"
    "\n"
    "　この度は修理をご用命頂き有難うございます。\n"
    " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
    "\n"
    "品名／型名　　　数量　　　金額　　　　備考\n"
    "-----------------------------------\n"
    "制御基板　　     １　１０，０００　　配達\n"
    "操作スイッチ     １　　３，８００　　配達\n"
    "パネル　　　     １　　２，０００　　配達\n"
    "技術料　　　     １　１５，０００\n"
    "出張費用　　     １　　５，０００\n"
    "-----------------------------------\n"
    "\n"
    "　　　　　　　　　　　小計　¥ ３５，８００\n"
    "　　　　　　　　　　　内税　¥ 　１，７９０\n"
    "　　　　　　　　　　　合計　¥ ３７，５９０\n"
    "\n"
    "　お問合わせ番号　　12345-67890\n";
    
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
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"スター電機\n" dataUsingEncoding:encoding] height:3];
    
    [builder appendDataWithMultipleHeight:[@"修理報告書　兼領収書\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "発行日時：YYYY年MM月DD日HH時MM分\n"
                          "TEL：054-347-XXXX\n"
                          "\n"
                          "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n"
                          "　お名前：池西　静子　様\n"
                          "　御住所：静岡市清水区七ツ新屋\n"
                          "　　　　　５３６番地\n"
                          "　伝票番号：No.12345-67890\n"
                          "\n"
                          "　この度は修理をご用命頂き有難うございます。\n"
                          " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
                          "\n"
                          "品名／型名        数量      金額　   備考\n"
                          "------------------------------------------\n"
                          "制御基板　          1     10,000     配達\n"
                          "操作スイッチ        1      3,800     配達\n"
                          "パネル　　          1      2,000     配達\n"
                          "技術料　            1     15,000\n"
                          "出張費用　　        1      5,000\n"
                          "------------------------------------------\n"
                          "\n"
                          "                      小計       \\ 35,800\n"
                          "                      内税       \\  1,790\n"
                          "                      合計       \\ 37,590\n"
                          "\n"
                          "　お問合わせ番号　　12345-67890\n"
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
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendEmphasis:YES];
    
    [builder appendDataWithMultipleHeight:[@"スター電機\n"
                                            "修理報告書　兼領収書\n" dataUsingEncoding:encoding] height:2];
    
    [builder appendEmphasis:NO];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"------------------------------------------\n"
                          "発行日時：YYYY年MM月DD日HH時MM分\n"
                          "TEL：054-347-XXXX\n"
                          "\n"
                          "        ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n"
                          "　お名前：池西  静子　様\n"
                          "　御住所：静岡市清水区七ツ新屋\n"
                          "　　　　　５３６番地\n"
                          "　伝票番号：No.12345-67890\n"
                          "\n"
                          "　この度は修理をご用命頂き有難うございます。\n"
                          " 今後も故障など発生した場合はお気軽にご連絡ください。\n"
                          "\n"
                          "品名／型名　     数量      金額　     備考\n"
                          "------------------------------------------\n"
                          "制御基板　　       1      10,000     配達\n"
                          "操作スイッチ       1       3,800     配達\n"
                          "パネル　　　       1       2,000     配達\n"
                          "技術料　　　       1      15,000\n"
                          "出張費用　　       1       5,000\n"
                          "------------------------------------------\n"
                          "\n"
                          "                       小計       \\ 35,800\n"
                          "                       内税       \\  1,790\n"
                          "                       合計       \\ 37,590\n"
                          "\n"
                          "　お問合わせ番号　　12345-67890\n" dataUsingEncoding:encoding]];
}

- (void)appendTextLabelData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendUnitFeed:20 * 2];
    
    [builder appendMultipleHeight:2];
    
    [builder appendData:[@"〒422-8654" dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendData:[@"静岡県静岡市駿河区中吉田20番10号" dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendData:[@"スター精密株式会社" dataUsingEncoding:encoding]];
    
    [builder appendUnitFeed:64];
    
    [builder appendMultipleHeight:1];
}

- (NSString *)createPasteTextLabelString {
    return @"〒422-8654\n"
            "静岡県静岡市駿河区中吉田20番10号\n"
            "スター精密株式会社";
}

- (void)appendPasteTextLabelData:(ISCBBuilder *)builder pasteText:(NSString *)pasteText utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSShiftJISStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP932];
    }
    
    [builder appendInternational:SCBInternationalTypeJapan];
    
    [builder appendCharacterSpace:0];
    
    [builder appendData:[pasteText dataUsingEncoding:encoding]];
}

@end
