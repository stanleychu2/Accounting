//
//  NSObject+MelodySpeakerFunctions.h
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <StarIO_Extension/StarIoExt.h>

@interface MelodySpeakerFunctions : NSObject

+ (NSData *)createPlayingRegisteredSound:(StarIoExtMelodySpeakerModel)model
                            specifySound:(BOOL)specifySound
                        soundStorageArea:(SMCBSoundStorageArea)soundStorageArea
                             soundNumber:(NSInteger)soundNumber
                           specifyVolume:(BOOL)specifyVolume
                                  volume:(NSInteger)volume
                                   error:(NSError**) error;

+ (NSData *)createPlayingReceivedData:(StarIoExtMelodySpeakerModel)model
                             filePath:(NSString *)filePath
                        specifyVolume:(BOOL)specifyVolume
                               volume:(NSInteger)volume
                                error:(NSError**)error;

@end

