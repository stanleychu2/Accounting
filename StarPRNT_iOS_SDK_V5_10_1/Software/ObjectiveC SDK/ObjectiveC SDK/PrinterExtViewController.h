//
//  PrinterExtViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import <StarIO_Extension/StarIoExtManager.h>

@interface PrinterExtViewController : CommonViewController <StarIoExtManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *printButton;

@property (nonatomic) StarIoExtManager *starIoExtManager;

@property (nonatomic) BOOL didAppear;

- (IBAction)touchUpInsidePrintButton:(id)sender;

- (void)beginAnimationCommantLabel;

@end
