//
//  CashDrawerExtViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import <StarIO_Extension/StarIoExtManager.h>

@interface CashDrawerExtViewController : CommonViewController <StarIoExtManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *openButton;

- (IBAction)touchUpInsideOpenButton:(id)sender;

@end
