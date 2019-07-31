//
//  SoundFileViewController.h
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

typedef void (^DidSelectSoundFileHandler)(NSString *title);

@interface SoundFileViewController : UITableViewController

@property (nonatomic) DidSelectSoundFileHandler didSelectSoundFileHandler;

@end
