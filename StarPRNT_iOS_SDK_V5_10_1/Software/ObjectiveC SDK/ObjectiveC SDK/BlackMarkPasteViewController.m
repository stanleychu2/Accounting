//
//  BlackMarkPasteViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "BlackMarkPasteViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "PrinterFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

@interface BlackMarkPasteViewController ()

- (void)closeKeyboard:(UITextView *)textView;

@end

@implementation BlackMarkPasteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    toolBar.barStyle = UIBarStyleDefault;
    
    [toolBar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeKeyboard:)];
    
    toolBar.items = @[spacer, doneButton];
    
    _textView.inputAccessoryView = toolBar;
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    _textView.text = [localizeReceipts createPasteTextLabelString];
    
    _textView.layer.borderWidth = 1.0;
    
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    if (emulation == StarIoExtEmulationStarLine      ||
        emulation == StarIoExtEmulationStarDotImpact ||
        emulation == StarIoExtEmulationEscPos) {
        _detectionSwitch.enabled = YES;
//      _detectionLabel .enabled = YES;
        _detectionLabel .alpha   = 1.0;
    }
    else {
        _detectionSwitch.enabled = NO;
//      _detectionLabel .enabled = NO;
        _detectionLabel .alpha   = 0.3;
    }
    
    _clearButton.enabled           = YES;
//  _clearButton.backgroundColor   = [UIColor cyanColor];
    _clearButton.backgroundColor   = [UIColor colorWithRed:0.8 green:0.8 blue:1.0 alpha:1.0];
    _clearButton.layer.borderColor = [UIColor blueColor].CGColor;
    _clearButton.layer.borderWidth = 1.0;
    
    _printButton.enabled           = YES;
    _printButton.backgroundColor   = [UIColor cyanColor];
    _printButton.layer.borderColor = [UIColor blueColor].CGColor;
    _printButton.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)closeKeyboard:(UITextView *)textView {
    [_textView endEditing:YES];
}

- (void)commitButtonTapped {
    [self.view endEditing:YES];
}

- (IBAction)touchUpInsideClearButton:(id)sender {
    _textView.text = @"";
}

- (IBAction)touchUpInsidePrintButton:(id)sender {
    NSData *commands;
    
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    SCBBlackMarkType type;
    
    if (_detectionSwitch.on == NO) {
        type = SCBBlackMarkTypeValid;
    }
    else {
        type = SCBBlackMarkTypeValidWithDetection;
    }
    
    commands = [PrinterFunctions createPasteTextBlackMarkData:emulation
                                             localizeReceipts:localizeReceipts
                                                    pasteText:_textView.text
                                                 doubleHeight:_doubleHeightSwitch.on
                                                         type:type
                                                         utf8:NO];
    
    self.blind = YES;
    
    NSString  *portName     = [AppDelegate getPortName];
    NSString  *portSettings = [AppDelegate getPortSettings];
    NSInteger  timeout      = 10000;                             // 10000mS!!!
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [Communication sendCommands:commands
                           portName:portName
                       portSettings:portSettings
                            timeout:timeout
                  completionHandler:^(BOOL result, NSString *title, NSString *message) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [self showSimpleAlertWithTitle:title
                                                 message:message
                                             buttonTitle:@"OK"
                                             buttonStyle:UIAlertActionStyleCancel
                                              completion:nil];
                          
                          self.blind = NO;
                      });
                  }];
    });
}

@end
