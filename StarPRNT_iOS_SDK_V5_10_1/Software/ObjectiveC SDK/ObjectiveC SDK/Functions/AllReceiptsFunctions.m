//
//  AllReceiptsFunctions.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "AllReceiptsFunctions.h"

#import <SMCloudServices/SMCSAllReceipts.h>

@implementation AllReceiptsFunctions

+ (NSData *)createRasterReceiptData:(StarIoExtEmulation)emulation
                   localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                            receipt:(BOOL)receipt
                               info:(BOOL)info
                             qrCode:(BOOL)qrCode
                         completion:(void (^)(NSInteger statusCode, NSError *error))completion {
    UIImage *image = [localizeReceipts createRasterReceiptImage];
    
    NSString *urlString = [SMCSAllReceipts uploadBitmap:image completion:completion];
    
    if (receipt == YES ||
        info    == YES ||
        qrCode  == YES) {
        ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        if (receipt == YES) {
            [builder appendBitmap:image diffusion:NO];
        }
        
        if (info   == YES ||
            qrCode == YES) {
            NSData *allReceiptsData;
            
            if (emulation == StarIoExtEmulationStarGraphic) {
                NSInteger width = [AppDelegate getSelectedPaperSize];
                
                allReceiptsData = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode width: width];     // Support to centering in Star Graphic.
            }
            else {
                allReceiptsData = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode];     // Non support to centering in Star Graphic.
            }
            
//          [builder appendData   :allReceiptsData];
            [builder appendRawData:allReceiptsData];
        }
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
    }
    
    return nil;
}

+ (NSData *)createScaleRasterReceiptData:(StarIoExtEmulation)emulation
                        localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                                   width:(NSInteger)width
                               bothScale:(BOOL)bothScale
                                 receipt:(BOOL)receipt
                                    info:(BOOL)info
                                  qrCode:(BOOL)qrCode
                              completion:(void (^)(NSInteger statusCode, NSError *error))completion {
    UIImage *image = [localizeReceipts createScaleRasterReceiptImage];
    
    NSString *urlString = [SMCSAllReceipts uploadBitmap:image completion:completion];
    
    if (receipt == YES ||
        info    == YES ||
        qrCode  == YES) {
        ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        if (receipt == YES) {
            [builder appendBitmap:image diffusion:NO width:width bothScale:bothScale];
        }
        
        if (info   == YES ||
            qrCode == YES) {
            NSData *allReceiptsData;
            
            if (emulation == StarIoExtEmulationStarGraphic) {
                allReceiptsData = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode width: width];     // Support to centering in Star Graphic.
            }
            else {
                allReceiptsData = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode];     // Non support to centering in Star Graphic.
            }
            
//          [builder appendData   :allReceiptsData];
            [builder appendRawData:allReceiptsData];
        }
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
    }
    
    return nil;
}

+ (NSData *)createTextReceiptData:(StarIoExtEmulation)emulation
                 localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                             utf8:(BOOL)utf8
                            width:(NSInteger)width
                          receipt:(BOOL)receipt
                             info:(BOOL)info
                           qrCode:(BOOL)qrCode
                       completion:(void (^)(NSInteger statusCode, NSError *error))completion {
    ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
    
    [builder beginDocument];
    
    [localizeReceipts appendTextReceiptData:builder utf8:utf8];
    
//  [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];     // No need.
    
    [builder endDocument];
    
    NSData *receiptData = [builder.commands copy];
    
    NSString *urlString = [SMCSAllReceipts uploadData:receiptData emulation:emulation characterCode:localizeReceipts.characterCode width:width completion:completion];
    
    if (receipt == YES ||
        info    == YES ||
        qrCode  == YES) {
//      ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
                     builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        if (receipt == YES) {
            [localizeReceipts appendTextReceiptData:builder utf8:utf8];
        }
        
        if (info   == YES ||
            qrCode == YES) {
            NSData *allReceiptsData = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode];
            
//          [builder appendData   :allReceiptsData];
            [builder appendRawData:allReceiptsData];
        }
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
    }
    
    return nil;
}

@end
