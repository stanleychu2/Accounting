//
//  AllReceiptsExtViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "AllReceiptsExtViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "AllReceiptsFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

#import <SMCloudServices/SMCSAllReceipts.h>

@interface AllReceiptsExtViewController ()

@property (nonatomic) StarIoExtManager *starIoExtManager;

@property (nonatomic) BOOL didAppear;

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;

- (void)refreshPrinter;

- (void)beginAnimationCommantLabel;

@end

@implementation AllReceiptsExtViewController

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
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    NSInteger width = [AppDelegate getSelectedPaperSize];
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    void (^completionUpload)(NSInteger statusCode, NSError *error) = ^(NSInteger statusCode, NSError *error) {
        NSString *prompt = nil;
        
        if (error) {
            prompt = [NSString stringWithFormat:@"%@", error];
        }
        else {
            prompt = [NSString stringWithFormat:@"Status Code : %ld", (long) statusCode];
        }
        
        NSLog(@"%@", prompt);
        
        self.navigationItem.prompt = prompt;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.navigationItem.prompt = nil;
        });
    };
    
    NSData *commands = nil;
    
    BOOL receipt = YES;
    BOOL info    = YES;
    BOOL qrCode  = YES;
    
    NSInteger allReceiptsSettings = [AppDelegate getAllReceiptsSettings];
    
    if ((allReceiptsSettings & 0x00000001) == 0x00000000) {
        receipt = NO;
    }
    
    if ((allReceiptsSettings & 0x00000002) == 0x00000000) {
        info = NO;
    }
    
    if ((allReceiptsSettings & 0x00000004) == 0x00000000) {
        qrCode = NO;
    }
    
    switch ([AppDelegate getSelectedIndex]) {
        default :
//      case 0  :
            commands = [AllReceiptsFunctions createTextReceiptData:emulation
                                                  localizeReceipts:localizeReceipts
                                                              utf8:NO
                                                             width:width
                                                           receipt:receipt
                                                              info:info
                                                            qrCode:qrCode
                                                        completion:completionUpload];
            break;
        case 1 :
            commands = [AllReceiptsFunctions createTextReceiptData:emulation
                                                  localizeReceipts:localizeReceipts
                                                              utf8:YES
                                                             width:width
                                                           receipt:receipt
                                                              info:info
                                                            qrCode:qrCode
                                                        completion:completionUpload];
            break;
        case 2 :
            commands = [AllReceiptsFunctions createRasterReceiptData:emulation
                                                    localizeReceipts:localizeReceipts
                                                             receipt:receipt
                                                                info:info
                                                              qrCode:qrCode
                                                          completion:completionUpload];
            break;
        case 3 :
            commands = [AllReceiptsFunctions createScaleRasterReceiptData:emulation
                                                         localizeReceipts:localizeReceipts
                                                                    width:width
                                                                bothScale:YES
                                                                  receipt:receipt
                                                                     info:info
                                                                   qrCode:qrCode
                                                               completion:completionUpload];
            break;
        case 4 :
            commands = [AllReceiptsFunctions createScaleRasterReceiptData:emulation
                                                         localizeReceipts:localizeReceipts
                                                                    width:width
                                                                bothScale:NO
                                                                  receipt:receipt
                                                                     info:info
                                                                   qrCode:qrCode
                                                               completion:completionUpload];
            break;
    }
    
    if (commands != nil) {
        self.blind = YES;
        
        [_starIoExtManager.lock lock];
        
        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommands:commands port:self->_starIoExtManager.port completionHandler:^(BOOL result, NSString *title, NSString *message) {
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
}

- (void)refreshPrinter {
    self.blind = YES;
    
    [_starIoExtManager disconnect];
    
    if ([_starIoExtManager connect] == NO) {
        [self showSimpleAlertWithTitle:@"Fail to Open Port."
                               message:@""
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:^(UIAlertController *alertController) {
                                self->_commentLabel.text = [NSString stringWithFormat:@"%@\n%@",
                                                            @"Check the device. (Power and Bluetooth pairing)",
                                                            @"Then touch up the Refresh button."];
                                
                                self->_commentLabel.textColor = [UIColor redColor];
                                
                                [self beginAnimationCommantLabel];
                            }];
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
    
    [SMCSAllReceipts updateStatus:status completion:^(NSInteger statusCode, NSError *error) {
         NSString *prompt = nil;
         
         if (error) {
             prompt = [NSString stringWithFormat:@"%@", error];
         }
         else {
             prompt = [NSString stringWithFormat:@"Status Code : %ld", (long) statusCode];
         }
         
         NSLog(@"%@", prompt);
         
         self.navigationItem.prompt = prompt;
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
             self.navigationItem.prompt = nil;
         });
     }];
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
