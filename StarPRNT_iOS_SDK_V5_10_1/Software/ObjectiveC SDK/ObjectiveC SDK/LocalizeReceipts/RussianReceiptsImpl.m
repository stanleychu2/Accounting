//
//  RussianReceiptsImpl.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "RussianReceiptsImpl.h"

@implementation RussianReceiptsImpl

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    self.languageCode = @"Ru";
    
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
        encoding = NSWindowsCP1251StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1251];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"Р Е Л А К С\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"ООО “РЕЛАКС”\n"
                          "СПб., Малая Балканская, д. 38, лит. А\n"
                          "тел. 307-07-12\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"РЕГ №322736     ИНН:123321\n"
                          "01 Белякова И.А.КАССА: 0020 ОТД.01\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЧЕК НА ПРОДАЖУ  No 84373\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"--------------------------------\n"
                          " 1. Яблоки Айдаред, кг    144.50\n"
                          " 2. Соус соевый Sen So     36.40\n"
                          " 3. Соус томатный Клас     19.90\n"
                          " 4. Ребра свиные в.к м     78.20\n"
                          " 5. Масло подсол раф д    114.00\n"
                          " 6. Блокнот 10х14см сп    164.00\n"
                          " 7. Морс Северная Ягод     99.90\n"
                          " 8. Активия Биойогурт      43.40\n"
                          " 9. Бублики Украинские     26.90\n"
                          "10. Активия Биойогурт      43.40\n"
                          "11. Сахар-песок 1кг        58.40\n"
                          "12. Хлопья овсяные Ясн     38.40\n"
                          "13. Кинза 50г              39.90\n"
                          "14. Пемза “Сердечко” .Т    37.90\n"
                          "15. Приправа Santa Mar     47.90\n"
                          "16. Томаты слива Выбор    162.00\n"
                          "17. Бонд Стрит Ред Сел     56.90\n"
                          "--------------------------------\n"
                          "--------------------------------\n"
                          "ДИСКОНТНАЯ КАРТА\n"
                          "                No:2440012489765\n"
                          "--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendData:[@"ИТОГО К ОПЛАТЕ = 1212.00\n"
                          "НАЛИЧНЫЕ = 1212.00\n"
                          "ВАША СКИДКА : 0.41\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
                                       "\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"08-02-2015 09:49  0254.0130604\n"
                          "00083213 #060127\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"СПАСИБО ЗА ПОКУПКУ !\n"
                          "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
                          "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
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
        encoding = NSWindowsCP1251StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1251];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"Р Е Л А К С\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"ООО “РЕЛАКС”\n"
                          "СПб., Малая Балканская, д. 38, лит. А\n"
                          "тел. 307-07-12\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"РЕГ №322736 ИНН : 123321\n"
                          "01  Белякова И.А.  КАССА: 0020 ОТД.01\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЧЕК НА ПРОДАЖУ  No 84373\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"------------------------------------------------\n"
                          "1.     Яблоки Айдаред, кг                 144.50\n"
                          "2.     Соус соевый Sen So                  36.40\n"
                          "3.     Соус томатный Клас                  19.90\n"
                          "4.     Ребра свиные в.к м                  78.20\n"
                          "5.     Масло подсол раф д                 114.00\n"
                          "6.     Блокнот 10х14см сп                 164.00\n"
                          "7.     Морс Северная Ягод                  99.90\n"
                          "8.     Активия Биойогурт                   43.40\n"
                          "9.     Бублики Украинские                  26.90\n"
                          "10.    Активия Биойогурт                   43.40\n"
                          "11.    Сахар-песок 1кг                     58.40\n"
                          "12.    Хлопья овсяные Ясн                  38.40\n"
                          "13.    Кинза 50г                           39.90\n"
                          "14.    Пемза “Сердечко” .Т                 37.90\n"
                          "15.    Приправа Santa Mar                  47.90\n"
                          "16.    Томаты слива Выбор                 162.00\n"
                          "17.    Бонд Стрит Ред Сел                  56.90\n"
                          "------------------------------------------------\n"
                          "------------------------------------------------\n"
                          "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n"
                          "------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendData:[@"ИТОГО  К  ОПЛАТЕ     = 1212.00\n"
                          "НАЛИЧНЫЕ             = 1212.00\n"
                          "ВАША СКИДКА : 0.41\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
                                      "\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"08-02-2015 09:49  0254.0130604\n"
                          "00083213 #060127\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"СПАСИБО ЗА ПОКУПКУ !\n"
                          "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
                          "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
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
        encoding = NSWindowsCP1251StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1251];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"Р Е Л А К С\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"ООО “РЕЛАКС”\n"
                          "СПб., Малая Балканская, д. 38, лит. А\n"
                          "тел. 307-07-12\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"РЕГ №322736 ИНН : 123321\n"
                          "01  Белякова И.А.  КАССА: 0020 ОТД.01\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЧЕК НА ПРОДАЖУ  No 84373\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"---------------------------------------------------------------------\n"
                          "1.     Яблоки Айдаред, кг                                      144.50\n"
                          "2.     Соус соевый Sen So                                       36.40\n"
                          "3.     Соус томатный Клас                                       19.90\n"
                          "4.     Ребра свиные в.к м                                       78.20\n"
                          "5.     Масло подсол раф д                                      114.00\n"
                          "6.     Блокнот 10х14см сп                                      164.00\n"
                          "7.     Морс Северная Ягод                                       99.90\n"
                          "8.     Активия Биойогурт                                        43.40\n"
                          "9.     Бублики Украинские                                       26.90\n"
                          "10.    Активия Биойогурт                                        43.40\n"
                          "11.    Сахар-песок 1кг                                          58.40\n"
                          "12.    Хлопья овсяные Ясн                                       38.40\n"
                          "13.    Кинза 50г                                                39.90\n"
                          "14.    Пемза “Сердечко” .Т                                      37.90\n"
                          "15.    Приправа Santa Mar                                       47.90\n"
                          "16.    Томаты слива Выбор                                      162.00\n"
                          "17.    Бонд Стрит Ред Сел                                       56.90\n"
                          "---------------------------------------------------------------------\n"
                          "---------------------------------------------------------------------\n"
                          "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n"
                          "---------------------------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendData:[@"ИТОГО  К  ОПЛАТЕ           = 1212.00\n"
                          "НАЛИЧНЫЕ                   = 1212.00\n"
                          "ВАША СКИДКА : 0.41\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
                                      "\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"08-02-2015 09:49  0254.0130604\n"
                          "00083213 #060127\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"СПАСИБО ЗА ПОКУПКУ !\n"
                          "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
                          "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
                          "\n" dataUsingEncoding:encoding]];
    
//  [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:encoding]              symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}

- (UIImage *)create2inchRasterReceiptImage {
    NSString *textToPrint =
    @"          Р Е Л А К С\n"
    "          ООО “РЕЛАКС”\n"
    "СПб., Малая Балканская, д.\n"
    "38, лит. А\n"
    "\n"
    "тел. 307-07-12\n"
    "РЕГ №322736     ИНН:123321\n"
    "01 Белякова И.А. КАССА:0020\n"
    "ОТД.01\n"
    "ЧЕК НА ПРОДАЖУ  No 84373\n"
    "----------------------------\n"
    " 1.Яблоки Айдаред, кг 144.50\n"
    " 2.Соус соевый Sen So  36.40\n"
    " 3.Соус томатный Клас  19.90\n"
    " 4.Ребра свиные в.к м  78.20\n"
    " 5.Масло подсол раф д 114.00\n"
    " 6.Блокнот 10х14см сп 164.00\n"
    " 7.Морс Северная Ягод  99.90\n"
    " 8.Активия Биойогурт   43.40\n"
    " 9.Бублики Украинские  26.90\n"
    "10.Активия Биойогурт   43.40\n"
    "11.Сахар-песок 1кг     58.40\n"
    "12.Хлопья овсяные Ясн  38.40\n"
    "13.Кинза 50г           39.90\n"
    "14.Пемза “Сердечко” .Т 37.90\n"
    "15.Приправа Santa Mar  47.90\n"
    "16.Томаты слива Выбор 162.00\n"
    "17.Бонд Стрит Ред Сел  56.90\n"
    "----------------------------\n"
    "----------------------------\n"
    "ДИСКОНТНАЯ КАРТА\n"
    "            No:2440012489765\n"
    "----------------------------\n"
    "ИТОГО К ОПЛАТЕ = 1212.00\n"
    "НАЛИЧНЫЕ = 1212.00\n"
    "ВАША СКИДКА : 0.41\n"
    "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
    "\n"
    "08-02-2015 09:49\n"
    "0254.013060400083213 #060127\n"
    "СПАСИБО ЗА ПОКУПКУ !\n"
    "\n"
    "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО\n"
    "23 СОХРАНЯЙТЕ, ПОЖАЛУЙСТА ,\n"
    "ЧЕК\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:11 * 2];
//  UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:384];     // 2inch(384dots)
}

- (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"      Р Е Л А К С   ООО “РЕЛАКС”\n"
    " СПб., Малая Балканская, д. 38, лит. А\n"
    "\n"
    "тел. 307-07-12\n"
    "РЕГ №322736     ИНН:123321\n"
    "01 Белякова И.А. КАССА: 0020 ОТД.01\n"
    "ЧЕК НА ПРОДАЖУ  No 84373\n"
    "--------------------------------------\n"
    " 1. Яблоки Айдаред, кг          144.50\n"
    " 2. Соус соевый Sen So           36.40\n"
    " 3. Соус томатный Клас           19.90\n"
    " 4. Ребра свиные в.к м           78.20\n"
    " 5. Масло подсол раф д          114.00\n"
    " 6. Блокнот 10х14см сп          164.00\n"
    " 7. Морс Северная Ягод           99.90\n"
    " 8. Активия Биойогурт            43.40\n"
    " 9. Бублики Украинские           26.90\n"
    "10. Активия Биойогурт            43.40\n"
    "11. Сахар-песок 1кг              58.40\n"
    "12. Хлопья овсяные Ясн           38.40\n"
    "13. Кинза 50г                    39.90\n"
    "14. Пемза “Сердечко” .Т          37.90\n"
    "15. Приправа Santa Mar           47.90\n"
    "16. Томаты слива Выбор          162.00\n"
    "17. Бонд Стрит Ред Сел           56.90\n"
    "--------------------------------------\n"
    "--------------------------------------\n"
    "ДИСКОНТНАЯ КАРТА      No:2440012489765\n"
    "--------------------------------------\n"
    "ИТОГО К ОПЛАТЕ = 1212.00\n"
    "НАЛИЧНЫЕ = 1212.00\n"
    "ВАША СКИДКА : 0.41\n"
    "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
    "\n"
    "08-02-2015 09:49  0254.0130604\n"
    "00083213 #060127\n"
    "               СПАСИБО ЗА ПОКУПКУ !\n"
    "\n"
    "    МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
    "        СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:576];     // 3inch(576dots)
}

- (UIImage *)create4inchRasterReceiptImage {
    NSString *textToPrint =
    @"               Р Е Л А К С   ООО “РЕЛАКС”\n"
    "                СПб., Малая Балканская, д. 38, лит. А\n"
    "\n"
    "тел. 307-07-12\n"
    "РЕГ №322736     ИНН:123321\n"
    "01 Белякова И.А. КАССА: 0020 ОТД.01\n"
    "ЧЕК НА ПРОДАЖУ  No 84373\n"
    "-----------------------------------------------------\n"
    " 1.      Яблоки Айдаред, кг                    144.50\n"
    " 2.      Соус соевый Sen So                     36.40\n"
    " 3.      Соус томатный Клас                     19.90\n"
    " 4.      Ребра свиные в.к м                     78.20\n"
    " 5.      Масло подсол раф д                    114.00\n"
    " 6.      Блокнот 10х14см сп                    164.00\n"
    " 7.      Морс Северная Ягод                     99.90\n"
    " 8.      Активия Биойогурт                      43.40\n"
    " 9.      Бублики Украинские                     26.90\n"
    "10.      Активия Биойогурт                      43.40\n"
    "11.      Сахар-песок 1кг                        58.40\n"
    "12.      Хлопья овсяные Ясн                     38.40\n"
    "13.      Кинза 50г                              39.90\n"
    "14.      Пемза “Сердечко” .Т                    37.90\n"
    "15.      Приправа Santa Mar                     47.90\n"
    "16.      Томаты слива Выбор                    162.00\n"
    "17.      Бонд Стрит Ред Сел                     56.90\n"
    "-----------------------------------------------------\n"
    "-----------------------------------------------------\n"
    "ДИСКОНТНАЯ КАРТА                     No:2440012489765\n"
    "-----------------------------------------------------\n"
    "ИТОГО К ОПЛАТЕ = 1212.00\n"
    "НАЛИЧНЫЕ = 1212.00\n"
    "ВАША СКИДКА : 0.41\n"
    "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
    "\n"
    "08-02-2015 09:49  0254.0130604\n"
    "00083213 #060127\n"
    "                                 СПАСИБО ЗА ПОКУПКУ !\n"
    "\n"
    "                      МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
    "                         СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [ILocalizeReceipts imageWithString:textToPrint font:font width:832];     // 4inch(832dots)
}

- (UIImage *)createCouponImage {
    return [UIImage imageNamed:@"RussianCouponImage.png"];
}

- (UIImage *)createEscPos3inchRasterReceiptImage {
    NSString *textToPrint =
    @"   Р Е Л А К С    ООО “РЕЛАКС”\n"
    "    СПб., Малая Балканская, д.\n"
    "           38, лит. А\n"
    "\n"
    "тел. 307-07-12\n"
    "РЕГ №322736     ИНН:123321\n"
    "01 Белякова И.А. КАССА: 0020 ОТД.01\n"
    "ЧЕК НА ПРОДАЖУ  No 84373\n"
    "-----------------------------------\n"
    " 1. Яблоки Айдаред, кг       144.50\n"
    " 2. Соус соевый Sen So        36.40\n"
    " 3. Соус томатный Клас        19.90\n"
    " 4. Ребра свиные в.к м        78.20\n"
    " 5. Масло подсол раф д       114.00\n"
    " 6. Блокнот 10х14см сп       164.00\n"
    " 7. Морс Северная Ягод        99.90\n"
    " 8. Активия Биойогурт         43.40\n"
    " 9. Бублики Украинские        26.90\n"
    "10. Активия Биойогурт         43.40\n"
    "11. Сахар-песок 1кг           58.40\n"
    "12. Хлопья овсяные Ясн        38.40\n"
    "13. Кинза 50г                 39.90\n"
    "14. Пемза “Сердечко” .Т       37.90\n"
    "15. Приправа Santa Mar        47.90\n"
    "16. Томаты слива Выбор       162.00\n"
    "17. Бонд Стрит Ред Сел        56.90\n"
    "-----------------------------------\n"
    "-----------------------------------\n"
    "ДИСКОНТНАЯ КАРТА   No:2440012489765\n"
    "-----------------------------------\n"
    "ИТОГО К ОПЛАТЕ = 1212.00\n"
    "НАЛИЧНЫЕ = 1212.00\n"
    "ВАША СКИДКА : 0.41\n"
    "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
    "\n"
    "08-02-2015 09:49  0254.0130604\n"
    "00083213 #060127\n"
    "               СПАСИБО ЗА ПОКУПКУ !\n"
    "\n"
    "    МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
    "       СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n";
    
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
        encoding = NSWindowsCP1251StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1251];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"Р Е Л А К С\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"ООО “РЕЛАКС”\n"
                          "СПб., Малая Балканская, д. 38, лит. А\n"
                          "тел. 307-07-12\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"РЕГ №322736 ИНН : 123321\n"
                          "01  Белякова И.А.  КАССА: 0020 ОТД.01\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЧЕК НА ПРОДАЖУ  No 84373\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"------------------------------------------\n"
                          "1.     Яблоки Айдаред, кг           144.50\n"
                          "2.     Соус соевый Sen So            36.40\n"
                          "3.     Соус томатный Клас            19.90\n"
                          "4.     Ребра свиные в.к м            78.20\n"
                          "5.     Масло подсол раф д           114.00\n"
                          "6.     Блокнот 10х14см сп           164.00\n"
                          "7.     Морс Северная Ягод            99.90\n"
                          "8.     Активия Биойогурт             43.40\n"
                          "9.     Бублики Украинские            26.90\n"
                          "10.    Активия Биойогурт             43.40\n"
                          "11.    Сахар-песок 1кг               58.40\n"
                          "12.    Хлопья овсяные Ясн            38.40\n"
                          "13.    Кинза 50г                     39.90\n"
                          "14.    Пемза “Сердечко” .Т           37.90\n"
                          "15.    Приправа Santa Mar            47.90\n"
                          "16.    Томаты слива Выбор           162.00\n"
                          "17.    Бонд Стрит Ред Сел            56.90\n"
                          "------------------------------------------\n"
                          "------------------------------------------\n"
                          "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendData:[@"ИТОГО  К  ОПЛАТЕ     = 1212.00\n"
                          "НАЛИЧНЫЕ             = 1212.00\n"
                          "ВАША СКИДКА : 0.41\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
                                       "\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"08-02-2015 09:49  0254.0130604\n"
                          "00083213 #060127\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"СПАСИБО ЗА ПОКУПКУ !\n"
                          "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
                          "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
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
        encoding = NSWindowsCP1251StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP1251];
    }
    
//  [builder appendInternational:SCBInternationalTypeUK];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendDataWithMultiple:[@"Р  Е  Л  А  К  С\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"ООО “РЕЛАКС”\n"
                          "СПб., Малая Балканская, д. 38, лит. А\n"
                          "тел. 307-07-12\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"РЕГ №322736 ИНН : 123321\n"
                          "01  Белякова И.А.  КАССА: 0020 ОТД.01\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЧЕК НА ПРОДАЖУ  No 84373\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"------------------------------------------\n"
                          "1.     Яблоки Айдаред, кг           144.50\n"
                          "2.     Соус соевый Sen So            36.40\n"
                          "3.     Соус томатный Клас            19.90\n"
                          "4.     Ребра свиные в.к м            78.20\n"
                          "5.     Масло подсол раф д           114.00\n"
                          "6.     Блокнот 10х14см сп           164.00\n"
                          "7.     Морс Северная Ягод            99.90\n"
                          "8.     Активия Биойогурт             43.40\n"
                          "9.     Бублики Украинские            26.90\n"
                          "10.    Активия Биойогурт             43.40\n"
                          "11.    Сахар-песок 1кг               58.40\n"
                          "12.    Хлопья овсяные Ясн            38.40\n"
                          "13.    Кинза 50г                     39.90\n"
                          "14.    Пемза “Сердечко” .Т           37.90\n"
                          "15.    Приправа Santa Mar            47.90\n"
                          "16.    Томаты слива Выбор           162.00\n"
                          "17.    Бонд Стрит Ред Сел            56.90\n"
                          "------------------------------------------\n"
                          "------------------------------------------\n"
                          "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n"
                          "------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionRight];
    
    [builder appendData:[@"ИТОГО  К  ОПЛАТЕ  = 1212.00\n"
                          "НАЛИЧНЫЕ          = 1212.00\n"
                          "ВАША СКИДКА : 0.41\n"
                          "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithAlignment:[@"ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n"
                                      "\n" dataUsingEncoding:encoding] position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"08-02-2015 09:49  0254.0130604\n"
                          "00083213 #060127\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"СПАСИБО ЗА ПОКУПКУ !\n"
                          "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n"
                          "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n" dataUsingEncoding:encoding]];
}

@end
