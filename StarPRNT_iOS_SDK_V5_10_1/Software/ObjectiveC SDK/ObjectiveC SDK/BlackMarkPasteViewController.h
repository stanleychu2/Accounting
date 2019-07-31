//
//  BlackMarkPasteViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

@interface BlackMarkPasteViewController : CommonViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UISwitch *doubleHeightSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *detectionSwitch;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *printButton;

@property (weak, nonatomic) IBOutlet UILabel *detectionLabel;

@end
