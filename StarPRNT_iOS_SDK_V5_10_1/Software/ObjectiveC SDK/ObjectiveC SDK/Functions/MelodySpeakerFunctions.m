//
//  MelodySpeakerFunctions.m
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "MelodySpeakerFunctions.h"

#import <StarIO_Extension/SMSoundSetting.h>

@implementation MelodySpeakerFunctions

+ (NSData *)createPlayingRegisteredSound:(StarIoExtMelodySpeakerModel)model
                            specifySound:(BOOL)specifySound
                        soundStorageArea:(SMCBSoundStorageArea)soundStorageArea
                             soundNumber:(NSInteger)soundNumber
                           specifyVolume:(BOOL)specifyVolume
                                  volume:(NSInteger)volume
                                   error:(NSError * _Nullable * _Nullable) error {
    ISMCBBuilder *builder = [StarIoExt createMelodySpeakerCommandBuilder:model];
    
    SMSoundSetting *setting = [SMSoundSetting new];
    
    if (specifySound == YES) {
        [setting setSoundStorageArea:soundStorageArea];
        [setting setSoundNumber:soundNumber];
    }
    
    if (specifyVolume == YES) {
        [setting setVolume:volume];
    }
    
    [builder appendSoundWithSetting:setting
                              error:error];
    
    if (*error != nil) {
        return nil;
    }
    
    return [builder.commands copy];
}

+ (NSData *)createPlayingReceivedData:(StarIoExtMelodySpeakerModel)model
                             filePath:(NSString *)filePath
                        specifyVolume:(BOOL)specifyVolume
                               volume:(NSInteger)volume
                                error:(NSError * _Nullable * _Nullable)error {
    ISMCBBuilder *builder = [StarIoExt createMelodySpeakerCommandBuilder:model];
    
    SMSoundSetting *setting = [SMSoundSetting new];
    
    NSURL *fileUrl = [[NSURL alloc] initWithString:filePath];
    
    NSData *fileData = [[NSData alloc] initWithContentsOfURL:fileUrl];
    
    if (specifyVolume == YES) {
        [setting setVolume:volume];
    }
    
    [builder appendSoundWithSound:fileData
                          setting:setting
                            error:error];
    
    if (*error != nil) {
        return nil;
    }
    
    return [builder.commands copy];
}

@end
