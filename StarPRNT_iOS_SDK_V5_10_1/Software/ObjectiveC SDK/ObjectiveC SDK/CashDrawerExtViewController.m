//
//  CashDrawerExtViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CashDrawerExtViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "CashDrawerFunctions.h"

#import "GlobalQueueManager.h"

@interface CashDrawerExtViewController ()

@property (nonatomic) StarIoExtManager *starIoExtManager;

@property (nonatomic) BOOL didAppear;

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;

- (void)refreshCashDrawer;

- (void)beginAnimationCommantLabel;

@end

@implementation CashDrawerExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _commentLabel.text = @"";
    
    _commentLabel.adjustsFontSizeToFitWidth = YES;
    
    _openButton.enabled           = YES;
    _openButton.backgroundColor   = [UIColor cyanColor];
    _openButton.layer.borderColor = [UIColor blueColor].CGColor;
    _openButton.layer.borderWidth = 1.0;
    
    [self appendRefreshButton:@selector(refreshCashDrawer)];
    
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
    
//  [self refreshCashDrawer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshCashDrawer];
            
            if (self->_didAppear == NO) {
                if (self->_starIoExtManager.port != nil) {
                    [self->_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
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
            [self refreshCashDrawer];
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

- (IBAction)touchUpInsideOpenButton:(id)sender {
    NSData *commands;
    
    switch ([AppDelegate getSelectedIndex]) {
        default :
//      case 0  :
//      case 1  :
            commands = [CashDrawerFunctions createData:[AppDelegate getEmulation] channel:SCBPeripheralChannelNo1];
            break;
        case 2 :
        case 3 :
            commands = [CashDrawerFunctions createData:[AppDelegate getEmulation] channel:SCBPeripheralChannelNo2];
            break;
    }
    
    switch ([AppDelegate getSelectedIndex]) {
        default :
//      case 0  :
//      case 2  :
        {
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
            });}
            
            break;
        case 1 :
        case 3 :
        {
            self.blind = YES;
            
            [_starIoExtManager.lock lock];
            
            dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
                [Communication sendCommandsDoNotCheckCondition:commands port:self->_starIoExtManager.port completionHandler:^(BOOL result, NSString *title, NSString *message) {
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
            });}
            
            break;
    }
}

- (void)refreshCashDrawer {
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

- (void)didCashDrawerOpen:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Cash Drawer Open.";
    
//  _commentLabel.textColor = [UIColor redColor];
    _commentLabel.textColor = [UIColor magentaColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didCashDrawerClose:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Cash Drawer Close.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
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
