//
//  ApiFunctions.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "ApiFunctions.h"

@implementation ApiFunctions

+ (NSData *)createGenericData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World." dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e};
    
    NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    [builder appendByte:'\n'];
    
    [builder appendBytes:bytes length:length];
    [builder appendByte:'\n'];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createFontStyleData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    [builder appendFontStyle:SCBFontStyleTypeB];
    [builder appendData:otherData];
    [builder appendFontStyle:SCBFontStyleTypeA];
    [builder appendData:otherData];
    [builder appendFontStyle:SCBFontStyleTypeB];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createInitializationData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    [builder appendMultiple:2 height:2];
    [builder appendData:otherData];
    [builder appendFontStyle:SCBFontStyleTypeB];
    [builder appendData:otherData];
    [builder appendInitialization:SCBInitializationTypeCommand];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createCodePageData:(StarIoExtEmulation)emulation {
    unsigned char bytes2[] = {0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x0a};
    unsigned char bytes3[] = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x0a};
    unsigned char bytes4[] = {0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x0a};
    unsigned char bytes5[] = {0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x0a};
    unsigned char bytes6[] = {0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x0a};
    unsigned char bytes7[] = {0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x0a};
    unsigned char bytes8[] = {0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x0a};
    unsigned char bytes9[] = {0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 0x0a};
    unsigned char bytesA[] = {0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0x0a};
    unsigned char bytesB[] = {0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, 0x0a};
    unsigned char bytesC[] = {0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0x0a};
    unsigned char bytesD[] = {0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0x0a};
    unsigned char bytesE[] = {0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, 0x0a};
    unsigned char bytesF[] = {0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff, 0x0a};
    
    NSUInteger length = sizeof(bytes2);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendCodePage:SCBCodePageTypeCP998];  [builder appendData:[@"*CP998*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    
    [builder appendBytes:bytes2 length:length];
    [builder appendBytes:bytes3 length:length];
    [builder appendBytes:bytes4 length:length];
    [builder appendBytes:bytes5 length:length];
    [builder appendBytes:bytes6 length:length];
    [builder appendBytes:bytes7 length:length];
    [builder appendBytes:bytes8 length:length];
    [builder appendBytes:bytes9 length:length];
    [builder appendBytes:bytesA length:length];
    [builder appendBytes:bytesB length:length];
    [builder appendBytes:bytesC length:length];
    [builder appendBytes:bytesD length:length];
    [builder appendBytes:bytesE length:length];
    [builder appendBytes:bytesF length:length];
    
    [builder appendData:[@"\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
//  [builder appendCodePage:SCBCodePageTypeCP437];  [builder appendData:[@"*CP437*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP737];  [builder appendData:[@"*CP737*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP772];  [builder appendData:[@"*CP772*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP774];  [builder appendData:[@"*CP774*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP851];  [builder appendData:[@"*CP851*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP852];  [builder appendData:[@"*CP852*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP855];  [builder appendData:[@"*CP855*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP857];  [builder appendData:[@"*CP857*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP858];  [builder appendData:[@"*CP858*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP860];  [builder appendData:[@"*CP860*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP861];  [builder appendData:[@"*CP861*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP862];  [builder appendData:[@"*CP862*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP863];  [builder appendData:[@"*CP863*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP864];  [builder appendData:[@"*CP864*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP865];  [builder appendData:[@"*CP865*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP866];  [builder appendData:[@"*CP866*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP869];  [builder appendData:[@"*CP869*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP874];  [builder appendData:[@"*CP874*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP928];  [builder appendData:[@"*CP928*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendCodePage:SCBCodePageTypeCP932];  [builder appendData:[@"*CP932*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP998];  [builder appendData:[@"*CP998*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP999];  [builder appendData:[@"*CP999*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP1001]; [builder appendData:[@"*CP1001*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP1250]; [builder appendData:[@"*CP1250*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP1251]; [builder appendData:[@"*CP1251*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP1252]; [builder appendData:[@"*CP1252*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP2001]; [builder appendData:[@"*CP2001*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3001]; [builder appendData:[@"*CP3001*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3002]; [builder appendData:[@"*CP3002*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3011]; [builder appendData:[@"*CP3011*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3012]; [builder appendData:[@"*CP3012*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3021]; [builder appendData:[@"*CP3021*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3041]; [builder appendData:[@"*CP3041*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3840]; [builder appendData:[@"*CP3840*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3841]; [builder appendData:[@"*CP3841*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3843]; [builder appendData:[@"*CP3843*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3844]; [builder appendData:[@"*CP3844*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3845]; [builder appendData:[@"*CP3845*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3846]; [builder appendData:[@"*CP3846*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3847]; [builder appendData:[@"*CP3847*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeCP3848]; [builder appendData:[@"*CP3848*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendCodePage:SCBCodePageTypeBlank];  [builder appendData:[@"*Blank*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    
    [builder appendBytes:bytes2 length:length];
    [builder appendBytes:bytes3 length:length];
    [builder appendBytes:bytes4 length:length];
    [builder appendBytes:bytes5 length:length];
    [builder appendBytes:bytes6 length:length];
    [builder appendBytes:bytes7 length:length];
    [builder appendBytes:bytes8 length:length];
    [builder appendBytes:bytes9 length:length];
    [builder appendBytes:bytesA length:length];
    [builder appendBytes:bytesB length:length];
    [builder appendBytes:bytesC length:length];
    [builder appendBytes:bytesD length:length];
    [builder appendBytes:bytesE length:length];
    [builder appendBytes:bytesF length:length];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createInternationalData:(StarIoExtEmulation)emulation {
    unsigned char bytes[] = {0x23, 0x24, 0x40, 0x58, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x0a};
    
    NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"*USA*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeUSA];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*France*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeFrance];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Germany*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeGermany];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*UK*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeUK];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Denmark*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeDenmark];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Sweden*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeSweden];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Italy*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeItaly];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Spain*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeSpain];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Japan*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeJapan];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Norway*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeNorway];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Denmark2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeDenmark2];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Spain2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeSpain2];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*LatinAmerica*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeLatinAmerica];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Korea*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeKorea];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Ireland*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeIreland];
    [builder appendBytes:bytes length:length];
    
    [builder appendData:[@"*Legal*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendInternational:SCBInternationalTypeLegal];
    [builder appendBytes:bytes length:length];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createFeedData:(StarIoExtEmulation)emulation {
    NSData *otherData       = [@"Hello World."   dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataWithLf = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e};
    
    NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    [builder appendLineFeed];
    
    [builder appendDataWithLineFeed:otherData];
    
    [builder appendBytesWithLineFeed:bytes length:length];
    
    [builder appendData:otherData];
    [builder appendLineFeed:2];
    
    [builder appendDataWithLineFeed:otherData line:2];
    
    [builder appendBytesWithLineFeed:bytes length:length line:2];
    
    [builder appendData:otherData];
    [builder appendUnitFeed:64];
    
    [builder appendDataWithUnitFeed:otherData unit:64];
    
    [builder appendBytesWithUnitFeed:bytes length:length unit:64];
    
    [builder appendData:otherDataWithLf];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createCharacterSpaceData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World." dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendCharacterSpace:0];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:1];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:2];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:3];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:4];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:5];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:6];
    [builder appendDataWithLineFeed:otherData];
    [builder appendCharacterSpace:7];
    [builder appendDataWithLineFeed:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createLineSpaceData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World." dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendLineSpace:32];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendLineSpace:24];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendLineSpace:32];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendLineSpace:24];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    [builder appendDataWithLineFeed:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createTopMarginData:(StarIoExtEmulation)emulation {
    NSData *data = [@"Hello, World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:StarIoExtEmulationStarPRNT];
    
    [builder beginDocument];
    
    [builder appendTopMargin:2];
    [builder appendData:[@"*Top margin:2mm*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendData:data];
    [builder appendData:data];
    [builder appendData:data];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder appendTopMargin:6];
    [builder appendData:[@"*Top margin:6mm*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendData:data];
    [builder appendData:data];
    [builder appendData:data];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder appendTopMargin:11];
    [builder appendData:[@"*Top margin:11mm*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendData:data];
    [builder appendData:data];
    [builder appendData:data];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return builder.commands;
}

+ (NSData *)createEmphasisData:(StarIoExtEmulation)emulation {
    NSData *otherData      = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf0 = [@"Hello "         dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf1 =       [@"World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[]      = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    unsigned char bytesHalf0[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20};
    unsigned char bytesHalf1[] =                                     {0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length      = sizeof(bytes);
    NSUInteger lengthHalf0 = sizeof(bytesHalf0);
    NSUInteger lengthHalf1 = sizeof(bytesHalf1);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendEmphasis:YES];
    [builder appendData:otherData];
    [builder appendEmphasis:NO];
    [builder appendData:otherData];
    
    [builder appendDataWithEmphasis:otherData];
    [builder appendData:            otherData];
    
    [builder appendBytesWithEmphasis:bytes length:length];
    [builder appendBytes:            bytes length:length];
    
    [builder appendDataWithEmphasis:otherDataHalf0];
    [builder appendData:            otherDataHalf1];
    
    [builder appendBytes:            bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithEmphasis:bytesHalf1 length:lengthHalf1];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createInvertData:(StarIoExtEmulation)emulation {
    NSData *otherData      = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf0 = [@"Hello "         dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf1 =       [@"World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[]      = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    unsigned char bytesHalf0[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20};
    unsigned char bytesHalf1[] =                                     {0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length      = sizeof(bytes);
    NSUInteger lengthHalf0 = sizeof(bytesHalf0);
    NSUInteger lengthHalf1 = sizeof(bytesHalf1);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendInvert:YES];
    [builder appendData:otherData];
    [builder appendInvert:NO];
    [builder appendData:otherData];
    
    [builder appendDataWithInvert:otherData];
    [builder appendData:          otherData];
    
    [builder appendBytesWithInvert:bytes length:length];
    [builder appendBytes:          bytes length:length];
    
    [builder appendDataWithInvert:otherDataHalf0];
    [builder appendData:          otherDataHalf1];
    
    [builder appendBytes:          bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithInvert:bytesHalf1 length:lengthHalf1];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createUnderLineData:(StarIoExtEmulation)emulation {
    NSData *otherData      = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf0 = [@"Hello "         dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf1 =       [@"World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[]      = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    unsigned char bytesHalf0[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20};
    unsigned char bytesHalf1[] =                                     {0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length      = sizeof(bytes);
    NSUInteger lengthHalf0 = sizeof(bytesHalf0);
    NSUInteger lengthHalf1 = sizeof(bytesHalf1);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendUnderLine:YES];
    [builder appendData:otherData];
    [builder appendUnderLine:NO];
    [builder appendData:otherData];
    
    [builder appendDataWithUnderLine:otherData];
    [builder appendData:             otherData];
    
    [builder appendBytesWithUnderLine:bytes length:length];
    [builder appendBytes:             bytes length:length];
    
    [builder appendDataWithUnderLine:otherDataHalf0];
    [builder appendData:             otherDataHalf1];
    
    [builder appendBytes:             bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithUnderLine:bytesHalf1 length:lengthHalf1];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createMultipleData:(StarIoExtEmulation)emulation {
    NSData *otherData      = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf0 = [@"Hello "         dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataHalf1 =       [@"World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[]      = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    unsigned char bytesHalf0[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20};
    unsigned char bytesHalf1[] =                                     {0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length      = sizeof(bytes);
    NSUInteger lengthHalf0 = sizeof(bytesHalf0);
    NSUInteger lengthHalf1 = sizeof(bytesHalf1);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendMultiple:2 height:2];
    [builder appendData:otherData];
    [builder appendMultiple:1 height:1];
    [builder appendData:otherData];
    
    [builder appendDataWithMultiple:otherData width:2 height:2];
    [builder appendData:            otherData];
    
    [builder appendBytesWithMultiple:bytes length:length width:2 height:2];
    [builder appendBytes:            bytes length:length];
    
    [builder appendDataWithMultiple:otherDataHalf0 width:2 height:2];
    [builder appendData:            otherDataHalf1];
    
    [builder appendBytes:            bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithMultiple:bytesHalf1 length:lengthHalf1 width:2 height:2];
    
    [builder appendMultipleHeight:2];
    [builder appendData:otherData];
    [builder appendMultipleHeight:1];
    [builder appendData:otherData];
    
    [builder appendDataWithMultipleHeight:otherDataHalf0 height:2];
    [builder appendData:                  otherDataHalf1];
    
    [builder appendBytes:                  bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithMultipleHeight:bytesHalf1 length:lengthHalf1 height:2];
    
    [builder appendMultipleWidth:2];
    [builder appendData:otherData];
    [builder appendMultipleWidth:1];
    [builder appendData:otherData];
    
    [builder appendDataWithMultipleWidth:otherDataHalf0 width:2];
    [builder appendData:                 otherDataHalf1];
    
    [builder appendBytes:                 bytesHalf0 length:lengthHalf0];
    [builder appendBytesWithMultipleWidth:bytesHalf1 length:lengthHalf1 width:2];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createAbsolutePositionData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendAbsolutePosition:40];
    [builder appendData:otherData];
    [builder appendData:otherData];
    
    [builder appendDataWithAbsolutePosition:otherData position:40];
    [builder appendData:                    otherData];
    
    [builder appendBytesWithAbsolutePosition:bytes length:length position:40];
    [builder appendBytes:                    bytes length:length];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createAlignmentData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
    
    NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    [builder appendData:otherData];
    [builder appendAlignment:SCBAlignmentPositionRight];
    [builder appendData:otherData];
    [builder appendAlignment:SCBAlignmentPositionLeft];
    [builder appendData:otherData];
    
    [builder appendDataWithAlignment:otherData position:SCBAlignmentPositionCenter];
    [builder appendDataWithAlignment:otherData position:SCBAlignmentPositionRight];
    [builder appendData:             otherData];
    
    [builder appendBytesWithAlignment:bytes length:length position:SCBAlignmentPositionCenter];
    [builder appendBytesWithAlignment:bytes length:length position:SCBAlignmentPositionRight];
    [builder appendBytes:             bytes length:length];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createHorizontalTabPositionData:(StarIoExtEmulation)emulation {
    NSData *otherData1 = [@"QTY\tITEM\tTOTAL\n" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherData2 = [@"1\tApple\t1.50\n"   dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherData3 = [@"2\tOrange\t2.00\n"  dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherData4 = [@"5\tBanana\t3.00\n"  dataUsingEncoding:NSASCIIStringEncoding];
    
    NSArray<NSNumber *> *positions = @[@5, @24];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendHorizontalTabPosition:positions];
    
    [builder appendData:[@"*Tab Position:5, 24*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
    [builder appendData:otherData1];
    [builder appendData:otherData2];
    [builder appendData:otherData3];
    [builder appendData:otherData4];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createLogoData:(StarIoExtEmulation)emulation {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"*Normal*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendLogo:SCBLogoSizeNormal                  number:1];
    
    [builder appendData:[@"\n*Double Width*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendLogo:SCBLogoSizeDoubleWidth             number:1];
    
    [builder appendData:[@"\n*Double Height*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendLogo:SCBLogoSizeDoubleHeight            number:1];
    
    [builder appendData:[@"\n*Double Width and Double Height*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendLogo:SCBLogoSizeDoubleWidthDoubleHeight number:1];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createCutPaperData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionFullCut];
    
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCut];
    
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionFullCutWithFeed];
    
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createPeripheralData:(StarIoExtEmulation)emulation {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendPeripheral:SCBPeripheralChannelNo1];
    [builder appendPeripheral:SCBPeripheralChannelNo2];
    [builder appendPeripheral:SCBPeripheralChannelNo1 time:2000];
    [builder appendPeripheral:SCBPeripheralChannelNo2 time:2000];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createSoundData:(StarIoExtEmulation)emulation {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendSound:SCBSoundChannelNo1];
    [builder appendSound:SCBSoundChannelNo2];
    [builder appendSound:SCBSoundChannelNo1 repeat:3];
    [builder appendSound:SCBSoundChannelNo2 repeat:3];
    [builder appendSound:SCBSoundChannelNo1 repeat:1 driveTime:1000 delayTime:1000];
    [builder appendSound:SCBSoundChannelNo2 repeat:1 driveTime:1000 delayTime:1000];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createBitmapData:(StarIoExtEmulation)emulation width:(NSInteger)width {
    UIImage *sphereImage   = [UIImage imageNamed:@"SphereImage"];
    UIImage *starLogoImage = [UIImage imageNamed:@"StarLogoImage"];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"*diffusion:YES*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:sphereImage diffusion:YES];
    [builder appendData:[@"\n*diffusion:NO*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:sphereImage diffusion:NO];
    
    [builder appendData:[@"\n*Normal*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:starLogoImage diffusion:YES];
    
    [builder appendData:[@"\n*width:Full, bothScale:YES*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:starLogoImage diffusion:YES width:width bothScale:YES];
    [builder appendData:[@"\n*width:Full, bothScale:NO*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:starLogoImage diffusion:YES width:width bothScale:NO];
    
    [builder appendData:[@"\n*Right90*\n"   dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRight90];
    [builder appendData:[@"\n*Rotate180*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmap:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRotate180];
//  [builder appendData:[@"\n*Left90*\n"    dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmap:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationLeft90];
    
    [builder appendData:[@"\n*Normal,    AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES position:40];
//  [builder appendData:[@"\n*Right90,   AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRight90   position:40];
//  [builder appendData:[@"\n*Rotate180, AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRotate180 position:40];
//  [builder appendData:[@"\n*Left90,    AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationLeft90    position:40];
    
    [builder appendData:[@"\n*Normal,    Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmapWithAlignment:starLogoImage diffusion:YES position:SCBAlignmentPositionCenter];
//  [builder appendData:[@"\n*Right90,   Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRight90   position:SCBAlignmentPositionCenter];
//  [builder appendData:[@"\n*Rotate180, Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRotate180 position:SCBAlignmentPositionCenter];
//  [builder appendData:[@"\n*Left90,    Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationLeft90    position:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"\n*Normal,    Alignment:Right*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBitmapWithAlignment:starLogoImage diffusion:YES position:SCBAlignmentPositionRight];
//  [builder appendData:[@"\n*Right90,   Alignment:Right*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRight90   position:SCBAlignmentPositionRight];
//  [builder appendData:[@"\n*Rotate180, Alignment:Right*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationRotate180 position:SCBAlignmentPositionRight];
//  [builder appendData:[@"\n*Left90,    Alignment:Right*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBitmapWithAlignment:starLogoImage diffusion:YES rotation:SCBBitmapConverterRotationLeft90    position:SCBAlignmentPositionRight];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createBarcodeData:(StarIoExtEmulation)emulation {
    NSData *otherDataUpcE    = [@"01234500006"  dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataUpcA    = [@"01234567890"  dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataJan8    = [@"0123456"      dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataJan13   = [@"012345678901" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataCode39  = [@"0123456789"   dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataItf     = [@"0123456789"   dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataCode128 = [@"{B0123456789" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataCode93  = [@"0123456789"   dataUsingEncoding:NSASCIIStringEncoding];
    NSData *otherDataNw7     = [@"A0123456789B" dataUsingEncoding:NSASCIIStringEncoding];
    
//  unsigned char bytesUpcE[]    = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x30, 0x30, 0x30, 0\x30, 0x36};
//  unsigned char bytesUpcA[]    = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0\x39, 0x30};
//  unsigned char bytesJan8[]    = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36};
//  unsigned char bytesJan13[]   = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0\x39, 0x30, 0x31};
//  unsigned char bytesCode39[]  = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0\x39};
//  unsigned char bytesItf[]     = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0\x39};
//  unsigned char bytesCode128[] = {0x7b, 0x42, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0\x37, 0x38, 0x39};
//  unsigned char bytesCode93[]  = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0\x39};
//  unsigned char bytesNw7[]     = {0x41, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0\x38, 0x39, 0x42};
//
//  NSUInteger lengthUpcE    = sizeof(bytesUpcE);
//  NSUInteger lengthUpcA    = sizeof(bytesUpcA);
//  NSUInteger lengthJan8    = sizeof(bytesJan8);
//  NSUInteger lengthJan13   = sizeof(bytesJan13);
//  NSUInteger lengthCode39  = sizeof(bytesCode39);
//  NSUInteger lengthItf     = sizeof(bytesItf);
//  NSUInteger lengthCode128 = sizeof(bytesCode128);
//  NSUInteger lengthCode93  = sizeof(bytesCode93);
//  NSUInteger lengthNw7     = sizeof(bytesNw7);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"*UPCE*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcE    symbology:SCBBarcodeSymbologyUPCE    width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*UPCA*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcA    symbology:SCBBarcodeSymbologyUPCA    width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*JAN8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataJan8    symbology:SCBBarcodeSymbologyJAN8    width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*JAN13*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataJan13   symbology:SCBBarcodeSymbologyJAN13   width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Code39*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataCode39  symbology:SCBBarcodeSymbologyCode39  width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*ITF*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataItf     symbology:SCBBarcodeSymbologyITF     width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Code128*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataCode128 symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Code93*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataCode93  symbology:SCBBarcodeSymbologyCode93  width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*NW7*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataNw7     symbology:SCBBarcodeSymbologyNW7     width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"*UPCE*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE    width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*UPCA*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcA    length:lengthUpcA    symbology:SCBBarcodeSymbologyUPCA    width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*JAN8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesJan8    length:lengthJan8    symbology:SCBBarcodeSymbologyJAN8    width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*JAN13*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesJan13   length:lengthJan13   symbology:SCBBarcodeSymbologyJAN13   width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Code39*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesCode39  length:lengthCode39  symbology:SCBBarcodeSymbologyCode39  width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*ITF*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesItf     length:lengthItf     symbology:SCBBarcodeSymbologyITF     width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Code128*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesCode128 length:lengthCode128 symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Code93*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesCode93  length:lengthCode93  symbology:SCBBarcodeSymbologyCode93  width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*NW7*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesNw7     length:lengthNw7     symbology:SCBBarcodeSymbologyNW7     width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"*HRI:NO*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:NO];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Mode:1*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Mode:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode2 height:40 hri:YES];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Mode:3*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeData:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode3 height:40 hri:YES];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"*HRI:NO*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:NO];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Mode:1*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Mode:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode2 height:40 hri:YES];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Mode:3*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytes:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode3 height:40 hri:YES];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeDataWithAbsolutePosition:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:40];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytesWithAbsolutePosition:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:40];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeDataWithAlignment:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:SCBAlignmentPositionCenter];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendBarcodeDataWithAlignment:otherDataUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:SCBAlignmentPositionRight];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytesWithAlignment:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:SCBAlignmentPositionCenter];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendBarcodeBytesWithAlignment:bytesUpcE length:lengthUpcE symbology:SCBBarcodeSymbologyUPCE width:SCBBarcodeWidthMode1 height:40 hri:YES position:SCBAlignmentPositionRight];
//  [builder appendUnitFeed:32];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createPdf417Data:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World." dataUsingEncoding:NSASCIIStringEncoding];
    
//  unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
//
//  NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"\n*Module:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Module:4*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:1 level:SCBPdf417LevelECC0 module:4 aspect:2];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Module:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Module:4*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:1 level:SCBPdf417LevelECC0 module:4 aspect:2];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Column:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:2 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Column:4*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:4 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Column:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:2 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Column:4*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:4 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Line:10*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:10 column:0 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Line:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:40 column:0 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Line:10*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:10 column:0 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Line:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:40 column:0 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Level:ECC0*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:7 level:SCBPdf417LevelECC0 module:2 aspect:2];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Level:ECC8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417Data:otherData line:0 column:7 level:SCBPdf417LevelECC8 module:2 aspect:2];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Level:ECC0*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:7 level:SCBPdf417LevelECC0 module:2 aspect:2];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Level:ECC8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417Bytes:bytes length:length line:0 column:7 level:SCBPdf417LevelECC8 module:2 aspect:2];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417DataWithAbsolutePosition:otherData line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:40];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417BytesWithAbsolutePosition:bytes length:length line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:40];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417DataWithAlignment:otherData line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:SCBAlignmentPositionCenter];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendPdf417DataWithAlignment:otherData line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:SCBAlignmentPositionRight];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417BytesWithAlignment:bytes length:length line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:SCBAlignmentPositionCenter];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendPdf417BytesWithAlignment:bytes length:length line:0 column:1 level:SCBPdf417LevelECC0 module:2 aspect:2 position:SCBAlignmentPositionRight];
//  [builder appendUnitFeed:32];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createQrCodeData:(StarIoExtEmulation)emulation {
    NSData *otherData = [@"Hello World." dataUsingEncoding:NSASCIIStringEncoding];
    
//  unsigned char bytes[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a};
//
//  NSUInteger length = sizeof(bytes);
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"*Cell:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:2];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Cell:8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:8];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"*Cell:2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes" length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:2];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Cell:8*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes" length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:8];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"*Level:L*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Level:M*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelM cell:4];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Level:Q*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:4];
    [builder appendUnitFeed:32];
    [builder appendData:[@"*Level:H*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeData:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelH cell:4];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"*Level:L*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Level:M*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelM cell:4];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Level:Q*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelQ cell:4];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"*Level:H*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytes:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelH cell:4];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeDataWithAbsolutePosition:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:40];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*AbsolutePosition:40*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytesWithAbsolutePosition:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:40];
//  [builder appendUnitFeed:32];
    
    [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeDataWithAlignment:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:SCBAlignmentPositionCenter];
    [builder appendUnitFeed:32];
    [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
    [builder appendQrCodeDataWithAlignment:otherData model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:SCBAlignmentPositionRight];
    [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Center*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytesWithAlignment:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:SCBAlignmentPositionCenter];
//  [builder appendUnitFeed:32];
//  [builder appendData:[@"\n*Alignment:Right*\n"  dataUsingEncoding:NSASCIIStringEncoding]];
//  [builder appendQrCodeBytesWithAlignment:bytes length:length model:SCBQrCodeModelNo2 level:SCBQrCodeLevelL cell:4 position:SCBAlignmentPositionRight];
//  [builder appendUnitFeed:32];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createBlackMarkData:(StarIoExtEmulation)emulation type:(SCBBlackMarkType)type {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendBlackMark:type];
    
    [builder appendData:otherData];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
//  [builder appendBlackMark:SCBBlackMarkTypeInvalid];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createPageModeData:(StarIoExtEmulation)emulation width:(NSInteger)width {
    NSData *otherData = [@"Hello World.\n" dataUsingEncoding:NSASCIIStringEncoding];
    
    UIImage *starLogoImage = [UIImage imageNamed:@"StarLogoImage"];
    
    int height = 30 * 8;     // 30mm!!!
    
    CGRect rect;
    
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendData:[@"\n*Normal*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
    rect = CGRectMake(0, 0, width, height);
    
    [builder beginPageMode:rect rotation:SCBBitmapConverterRotationNormal];
    
    [builder appendData:otherData];
    
    [builder appendPageModeVerticalAbsolutePosition:160];
    
    [builder appendData:otherData];
    
    [builder appendPageModeVerticalAbsolutePosition:80];
    
    [builder appendDataWithAbsolutePosition:otherData position:40];
    
    [builder endPageMode];
    
    [builder appendData:[@"\n*Right90*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
////rect = CGRectMake(0, 0, width,  height);
//  rect = CGRectMake(0, 0, height, width);
    rect = CGRectMake(0, 0, width,  width);
    
    [builder beginPageMode:rect rotation:SCBBitmapConverterRotationRight90];
    
    [builder appendData:otherData];
    
    [builder appendPageModeVerticalAbsolutePosition:160];
    
    [builder appendData:otherData];
    
    [builder appendPageModeVerticalAbsolutePosition:80];
    
    [builder appendDataWithAbsolutePosition:otherData position:40];
    
    [builder endPageMode];
    
//  [builder appendData:[@"\n*Rotate180*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//
//  rect = CGRectMake(0, 0, width, height);
//
//  [builder beginPageMode:rect rotation:SCBBitmapConverterRotationRotate180];
//
//  [builder appendData:otherData];
//
//  [builder appendPageModeVerticalAbsolutePosition:160];
//
//  [builder appendData:otherData];
//
//  [builder appendPageModeVerticalAbsolutePosition:80];
//
//  [builder appendDataWithAbsolutePosition:otherData position:40];
//
//  [builder endPageMode];
//
//  [builder appendData:[@"\n*Left90*\n" dataUsingEncoding:NSASCIIStringEncoding]];
//
////rect = CGRectMake(0, 0, width,  height);
//  rect = CGRectMake(0, 0, height, width);
//
//  [builder beginPageMode:rect rotation:SCBBitmapConverterRotationLeft90];
//
//  [builder appendData:otherData];
//
//  [builder appendPageModeVerticalAbsolutePosition:160];
//
//  [builder appendData:otherData];
//
//  [builder appendPageModeVerticalAbsolutePosition:80];
//
//  [builder appendDataWithAbsolutePosition:otherData position:40];
//
//  [builder endPageMode];
    
    [builder appendData:[@"\n*Mixed Text*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
//  rect = CGRectMake(0, 0, width,  height);
    rect = CGRectMake(0, 0, width,  width);
    
    [builder beginPageMode:rect rotation:SCBBitmapConverterRotationNormal];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendDataWithAbsolutePosition:otherData position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationRight90];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendDataWithAbsolutePosition:otherData position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationRotate180];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendDataWithAbsolutePosition:otherData position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationLeft90];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendDataWithAbsolutePosition:otherData position:width / 2];
    
    [builder endPageMode];
    
    [builder appendData:[@"\n*Mixed Bitmap*\n" dataUsingEncoding:NSASCIIStringEncoding]];
    
//  rect = CGRectMake(0, 0, width,  height);
    rect = CGRectMake(0, 0, width,  width);
    
    [builder beginPageMode:rect rotation:SCBBitmapConverterRotationNormal];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationRight90];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationRotate180];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES position:width / 2];
    
    [builder appendPageModeRotation:SCBBitmapConverterRotationLeft90];
    
    [builder appendPageModeVerticalAbsolutePosition:width / 2];
    
    [builder appendBitmapWithAbsolutePosition:starLogoImage diffusion:YES position:width / 2];
    
    [builder endPageMode];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return [builder.commands copy];
}

+ (NSData *)createPrintableAreaDataWithEmulation:(StarIoExtEmulation)emulation
                                            type:(SCBPrintableAreaType)type {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [builder appendPrintableArea:type];
    
    switch (type) {
        case SCBPrintableAreaTypeStandard:
            [builder appendData:[@"*Standard*\n" dataUsingEncoding:NSASCIIStringEncoding]];
            break;
        case SCBPrintableAreaTypeType1:
            [builder appendData:[@"*Type1*\n" dataUsingEncoding:NSASCIIStringEncoding]];
            break;
        case SCBPrintableAreaTypeType2:
            [builder appendData:[@"*Type2*\n" dataUsingEncoding:NSASCIIStringEncoding]];
            break;
        case SCBPrintableAreaTypeType3:
            [builder appendData:[@"*Type3*\n" dataUsingEncoding:NSASCIIStringEncoding]];
            break;
        case SCBPrintableAreaTypeType4:
            [builder appendData:[@"*Type4*\n" dataUsingEncoding:NSASCIIStringEncoding]];
            break;
    }
    
    UIImage *image = [UIImage imageNamed:@"PrintableAreaImage.png"];
    [builder appendBitmap:image diffusion:true];
    
    NSData *data1 = [@"123456789" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *data2 = [@"0" dataUsingEncoding:NSASCIIStringEncoding];
    
    for (int i = 0; i < 8; i++) {
        [builder appendData:data1];
        [builder appendDataWithInvert:data2];
    }
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
    
    [builder endDocument];
    
    return builder.commands;
}

@end
