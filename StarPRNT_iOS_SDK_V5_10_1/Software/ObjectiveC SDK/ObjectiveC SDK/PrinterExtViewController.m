//
//  PrinterExtViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "PrinterExtViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "PrinterFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

@interface PrinterExtViewController ()

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;

- (void)refreshPrinter;

@end

@implementation PrinterExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _commentLabel.text = @"";
    
    _commentLabel.adjustsFontSizeToFitWidth = YES;
    
    _printButton.enabled           = YES;
    _printButton.backgroundColor   = [UIColor cyanColor];
    _printButton.layer.borderColor = [UIColor blueColor].CGColor;
    _printButton.layer.borderWidth = 1.0;
    
    [self appendRefreshButton:@selector(refreshPrinter)];
    
    _starIoExtManager = [[StarIoExtManager alloc] initWithType:StarIoExtManagerTypeStandard
                                                      portName:[AppDelegate getPortName]
                                                  portSettings:[AppDelegate getPortSettings]
                                               ioTimeoutMillis:10000];                           // 10000mS!!!
    
    _starIoExtManager.cashDrawerOpenActiveHigh = [AppDelegate getCashDrawerOpenActiveHigh];
    
    _starIoExtManager.delegate = self;
    
    _didAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)  name:UIApplicationDidBecomeActiveNotification  object:nil];
    
//  [self refreshPrinter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshPrinter];
            
            if (self->_didAppear == NO) {
                if (self->_starIoExtManager.port != nil) {
                    [self->_printButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
                
                self->_didAppear = YES;
            }
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self->_starIoExtManager disconnect];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification  object:nil];
}

- (void)applicationDidBecomeActive {
    [self beginAnimationCommantLabel];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshPrinter];
        });
    });
}

- (void)applicationWillResignActive {
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self->_starIoExtManager disconnect];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)touchUpInsidePrintButton:(id)sender {
    NSData *commands = nil;
    
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    NSInteger width = [AppDelegate getSelectedPaperSize];
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    switch ([AppDelegate getSelectedIndex]) {
        default :
//      case 0  :
            commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:NO];
            break;
        case 1 :
            commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:YES];
            break;
        case 2 :
            commands = [PrinterFunctions createRasterReceiptData:emulation localizeReceipts:localizeReceipts];
            break;
        case 3 :
            commands = [PrinterFunctions createScaleRasterReceiptData:emulation localizeReceipts:localizeReceipts width:width bothScale:YES];
            break;
        case 4 :
            commands = [PrinterFunctions createScaleRasterReceiptData:emulation localizeReceipts:localizeReceipts width:width bothScale:NO];
            break;
        case 5 :
            commands = [PrinterFunctions createCouponData:emulation localizeReceipts:localizeReceipts width:width rotation:SCBBitmapConverterRotationNormal];
            break;
        case 6 :
            commands = [PrinterFunctions createCouponData:emulation localizeReceipts:localizeReceipts width:width rotation:SCBBitmapConverterRotationRight90];
            break;
    }
    
    
    self.blind = YES;
    
    [_starIoExtManager.lock lock];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [Communication sendCommands:commands
                               port:self->_starIoExtManager.port
                  completionHandler:^(BOOL result, NSString *title, NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showSimpleAlertWithTitle:title
                                       message:message
                                   buttonTitle:@"OK"
                                   buttonStyle:UIAlertActionStyleCancel
                                    completion:nil];
                
                [self->_starIoExtManager.lock unlock];
                
                self.blind = NO;
            });
        }];
    });
}

- (void)refreshPrinter {
    self.blind = YES;
    
    [_starIoExtManager disconnect];
    
    if ([_starIoExtManager connect] == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Fail to Open Port."
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    self->_commentLabel.text = @"Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button.";
                                                    
                                                    self->_commentLabel.textColor = [UIColor redColor];
                                                    
                                                    [self beginAnimationCommantLabel];
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    self.blind = NO;
}

- (void)didPrinterImpossible:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Impossible.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterOnline:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Online.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterOffline:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
//  _commentLabel.text = @"Printer Offline.";
//
//  _commentLabel.textColor = [UIColor redColor];
//
//  [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperReady:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
//  _commentLabel.text = @"Printer Paper Ready.";
//
//  _commentLabel.textColor = [UIColor blueColor];
//
//  [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperNearEmpty:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Paper Near Empty.";
    
    _commentLabel.textColor = [UIColor orangeColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperEmpty:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Paper Empty.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterCoverOpen:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Cover Open.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterCoverClose:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
//  _commentLabel.text = @"Printer Cover Close.";
//
//  _commentLabel.textColor = [UIColor blueColor];
//
//  [self beginAnimationCommantLabel];
}

- (void)didAccessoryConnectSuccess:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Success.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didAccessoryConnectFailure:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Failure.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didAccessoryDisconnect:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Disconnect.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didStatusUpdate:(StarIoExtManager *)manager status:(NSString *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
//  _commentLabel.text = status;
//
//  _commentLabel.textColor = [UIColor greenColor];
//
//  [self beginAnimationCommantLabel];
}

- (void)beginAnimationCommantLabel {
    [UIView beginAnimations:nil context:nil];
    
    _commentLabel.alpha = 0.0;
    
    [UIView setAnimationDelay             :0.0];                            // 0mS!!!
    [UIView setAnimationDuration          :0.6];                            // 600mS!!!
    [UIView setAnimationRepeatCount       :UINT32_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve             :UIViewAnimationCurveEaseIn];
    
    _commentLabel.alpha = 1.0;
    
    [UIView commitAnimations];
}

@end
