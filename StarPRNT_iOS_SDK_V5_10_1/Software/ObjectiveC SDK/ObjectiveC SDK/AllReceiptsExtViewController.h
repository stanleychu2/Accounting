//
//  AllReceiptsExtViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import <StarIO_Extension/StarIoExtManager.h>

@interface AllReceiptsExtViewController : CommonViewController <StarIoExtManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *printButton;

- (IBAction)touchUpInsidePrintButton:(id)sender;

@end
