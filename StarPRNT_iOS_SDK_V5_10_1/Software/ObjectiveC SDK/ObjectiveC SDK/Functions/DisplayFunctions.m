//
//  DisplayFunctions.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "DisplayFunctions.h"

@implementation DisplayFunctions

+ (void)appendClearScreen:(ISDCBBuilder *)builder {
    [builder appendClearScreen];
}

+ (void)appendTextPattern:(ISDCBBuilder *)builder number:(int)number {
//  [builder appendClearScreen];
    [builder appendCursorMode:SDCBCursorModeOff];
    [builder appendSpecifiedPosition:1 y:1];
    
    unsigned char pattern1[] = "\x020\x021\x022\x023\x024\x025\x026\x027\x028\x029\x02a\x02b\x02c\x02d\x02e\x02f\x030\x031\x032\x033"
                               "\x034\x035\x036\x037\x038\x039\x03a\x03b\x03c\x03d\x03e\x03f\x040\x041\x042\x043\x044\x045\x046\x047";
    
    unsigned char pattern2[] = "\x048\x049\x04a\x04b\x04c\x04d\x04e\x04f\x050\x051\x052\x053\x054\x055\x056\x057\x058\x059\x05a\x05b"
                               "\x05c\x05d\x05e\x05f\x060\x061\x062\x063\x064\x065\x066\x067\x068\x069\x06a\x06b\x06c\x06d\x06e\x06f";
    
    unsigned char pattern3[] = "\x070\x071\x072\x073\x074\x075\x076\x077\x078\x079\x07a\x07b\x07c\x07d\x07e\x07f\x080\x081\x082\x083"
                               "\x084\x085\x086\x087\x088\x089\x08a\x08b\x08c\x08d\x08e\x08f\x090\x091\x092\x093\x094\x095\x096\x097";
    
    unsigned char pattern4[] = "\x098\x099\x09a\x09b\x09c\x09d\x09e\x09f\x0a0\x0a1\x0a2\x0a3\x0a4\x0a5\x0a6\x0a7\x0a8\x0a9\x0aa\x0ab"
                               "\x0ac\x0ad\x0ae\x0af\x0b0\x0b1\x0b2\x0b3\x0b4\x0b5\x0b6\x0b7\x0b8\x0b9\x0ba\x0bb\x0bc\x0bd\x0be\x0bf";
    
    unsigned char pattern5[] = "\x0c0\x0c1\x0c2\x0c3\x0c4\x0c5\x0c6\x0c7\x0c8\x0c9\x0ca\x0cb\x0cc\x0cd\x0ce\x0cf\x0d0\x0d1\x0d2\x0d3"
                               "\x0d4\x0d5\x0d6\x0d7\x0d8\x0d9\x0da\x0db\x0dc\x0dd\x0de\x0df\x0e0\x0e1\x0e2\x0e3\x0e4\x0e5\x0e6\x0e7";
    
    unsigned char pattern6[] = "\x0e8\x0e9\x0ea\x0eb\x0ec\x0ed\x0ee\x0ef\x0f0\x0f1\x0f2\x0f3\x0f4\x0f5\x0f6\x0f7\x0f8\x0f9\x0fa\x0fb"
                               "\x0fc\x0fd\x0fe\x0ff\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020\x020";
    
    switch (number) {
        default : [builder appendBytes:pattern1 length:sizeof(pattern1)]; break;     // 0
        case 1  : [builder appendBytes:pattern2 length:sizeof(pattern2)]; break;
        case 2  : [builder appendBytes:pattern3 length:sizeof(pattern3)]; break;
        case 3  : [builder appendBytes:pattern4 length:sizeof(pattern4)]; break;
        case 4  : [builder appendBytes:pattern5 length:sizeof(pattern5)]; break;
        case 5  : [builder appendBytes:pattern6 length:sizeof(pattern6)]; break;
    }
}

+ (void)appendGraphicPattern:(ISDCBBuilder *)builder number:(int)number {
    [builder appendCursorMode:SDCBCursorModeOff];
    
    UIImage *image = nil;
    
    switch (number) {
        case 0:
            image = [UIImage imageNamed:@"DisplayImage1.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"DisplayImage2.png"];
            break;
    }
    
    if (image != nil) {
        [builder appendBitmap:image diffusion:YES];
    }
}

+ (void)appendCharacterSet:(ISDCBBuilder *)builder internationalType:(SDCBInternationalType)internationalType codePageType:(SDCBCodePageType)codePageType {
//  [builder appendClearScreen];
    [builder appendCursorMode:SDCBCursorModeOff];
    [builder appendSpecifiedPosition:1 y:1];
    
    [builder appendInternational:internationalType];
    [builder appendCodePage     :codePageType];
    
    unsigned char pattern1[] = "\x02d\x020\x020\x020\x023\x024\x040\x05b\x05c\x05d\x05e\x060\x07b\x07c\x07d\x07e\x020\x020\x020\x02d"
                               "\x0a0\x0a1\x0a2\x0a3\x0a4\x0a5\x0a6\x0a7\x0a8\x0a9\x0aa\x0ab\x0ac\x0ad\x0ae\x0af\x0b0\x0b1\x0b2\x0b3";
    
    unsigned char pattern2[] = "\x02d\x020\x020\x020\x023\x024\x040\x05b\x05c\x05d\x05e\x060\x07b\x07c\x07d\x07e\x020\x020\x020\x02d"
                               "\x088\x0a0\x088\x0a1\x088\x0a2\x088\x0a3\x088\x0a4\x088\x0a5\x088\x0a6\x088\x0a7\x088\x0a8\x088\x0a9";
    
    unsigned char pattern3[] = "\x02d\x020\x020\x020\x023\x024\x040\x05b\x05c\x05d\x05e\x060\x07b\x07c\x07d\x07e\x020\x020\x020\x02d"
                               "\x0b0\x0a1\x0b0\x0a2\x0b0\x0a3\x0b0\x0a4\x0b0\x0a5\x0b0\x0a6\x0b0\x0a7\x0b0\x0a8\x0b0\x0a9\x0b0\x0aa";
    
    unsigned char pattern4[] = "\x02d\x020\x020\x020\x023\x024\x040\x05b\x05c\x05d\x05e\x060\x07b\x07c\x07d\x07e\x020\x020\x020\x02d"
                               "\x0a4\x040\x0a4\x041\x0a4\x042\x0a4\x043\x0a4\x044\x0a4\x045\x0a4\x046\x0a4\x047\x0a4\x048\x0a4\x049";
    
    unsigned char pattern5[] = "\x02d\x020\x020\x020\x023\x024\x040\x05b\x05c\x05d\x05e\x060\x07b\x07c\x07d\x07e\x020\x020\x020\x02d"
                               "\x0b0\x0a1\x0b0\x0a2\x0b0\x0a3\x0b0\x0a4\x0b0\x0a5\x0b0\x0a6\x0b0\x0a7\x0b0\x0a8\x0b0\x0a9\x0b0\x0aa";
    
    switch (codePageType) {
        default                                 : [builder appendBytes:pattern1 length:sizeof(pattern1)]; break;     // CP437,Katakana,CP850,CP860,CP863,CP865,CP1252,CP866,CP852,CP858
        case SDCBCodePageTypeJapanese           : [builder appendBytes:pattern2 length:sizeof(pattern2)]; break;
        case SDCBCodePageTypeSimplifiedChinese  : [builder appendBytes:pattern3 length:sizeof(pattern3)]; break;
        case SDCBCodePageTypeTraditionalChinese : [builder appendBytes:pattern4 length:sizeof(pattern4)]; break;
        case SDCBCodePageTypeHangul             : [builder appendBytes:pattern5 length:sizeof(pattern5)]; break;
    }
}

+ (void)appendTurnOn:(ISDCBBuilder *)builder turnOn:(BOOL)turnOn {
////[builder appendClearScreen];
//  [builder appendCursorMode:SDCBCursorModeOff];
//  [builder appendSpecifiedPosition:1 y:1];
//
//  unsigned char pattern[] = "Star Micronics      "
//                            "      Star Micronics";
//
//  [builder appendBytes:pattern length:sizeof(pattern)]];
    
    [builder appendTurnOn:turnOn];
}

+ (void)appendCursorMode:(ISDCBBuilder *)builder cursorMode:(SDCBCursorMode)cursorMode {
//  [builder appendClearScreen];
    [builder appendCursorMode:SDCBCursorModeOff];
    [builder appendSpecifiedPosition:1 y:1];
    
    unsigned char pattern[] = "Star Micronics      "
                              "Total :        12345";
    
    [builder appendBytes:pattern length:sizeof(pattern)];
    
    [builder appendSpecifiedPosition:20 y:2];
    
    [builder appendCursorMode:cursorMode];
}

+ (void)appendContrastMode:(ISDCBBuilder *)builder contrastMode:(SDCBContrastMode)contrastMode {
////[builder appendClearScreen];
//  [builder appendCursorMode:SDCBCursorModeOff];
//  [builder appendSpecifiedPosition:1 y:1];
//
//  unsigned char pattern[] = "Star Micronics      "
//                            "      Star Micronics";
//
//  [builder appendBytes:pattern length:sizeof(pattern)];
    
    [builder appendContrastMode:contrastMode];
}

+ (void)appendUserDefinedCharacter:(ISDCBBuilder *)builder set:(BOOL)set {
//  [builder appendClearScreen];
    [builder appendCursorMode:SDCBCursorModeOff];
    [builder appendSpecifiedPosition:1 y:1];
    
    [builder appendInternational:SDCBInternationalTypeUSA];
    [builder appendCodePage     :SDCBCodePageTypeJapanese];
    
    if (set) {
        [builder appendUserDefinedCharacter:0 code:0x20 font:(unsigned char *) "\x000\x000\x032\x000\x049\x000\x049\x07f\x026\x048\x000\x048\x000\x030\x000\x000"];
        
        [builder appendUserDefinedDbcsCharacter:0 code:0x8140 font:(unsigned char *) "\x000\x000\x000\x000\x000\x000\x000\x000\x003\x020\x004\x090\x004\x090\x002\x060"
                                                                                     "\x000\x000\x007\x0f0\x004\x080\x004\x080\x003\x000\x000\x000\x000\x000\x000\x000"];
    }
    else {
        [builder appendUserDefinedCharacter:0 code:0x00 font:nil];
        
        [builder appendUserDefinedDbcsCharacter:0 code:0x0000 font:nil];
    }
    
    unsigned char pattern[] = "\x05b\x020\x020\x053\x074\x061\x072\x020\x04d\x069\x063\x072\x06f\x06e\x069\x063\x073\x020\x020\x05d"
                              "\x05b\x081\x040\x081\x040\x083\x058\x083\x05e\x081\x05b\x090\x0b8\x096\x0a7\x081\x040\x081\x040\x05d";
    
    [builder appendBytes:pattern length:sizeof(pattern)];
}

@end
