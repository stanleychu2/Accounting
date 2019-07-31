//
//  MelodySpeakerViewController.h
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

@interface MelodySpeakerViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *soundTypeSegment;
@property (weak, nonatomic) IBOutlet UIButton *soundStorageAreaButton;
@property (weak, nonatomic) IBOutlet UILabel *soundNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *soundNumberField;
@property (weak, nonatomic) IBOutlet UIButton *soundFileButton;
@property (weak, nonatomic) IBOutlet UIButton *volumeSettingButton;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIView *soundStorageAreaView;
@property (weak, nonatomic) IBOutlet UIView *soundFileView;
@property (weak, nonatomic) IBOutlet UIView *volumeView;
@property (weak, nonatomic) IBOutlet UIView *playView;

@end
