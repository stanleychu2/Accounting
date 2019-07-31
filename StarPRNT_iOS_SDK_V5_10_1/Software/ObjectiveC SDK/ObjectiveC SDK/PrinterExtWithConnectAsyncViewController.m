//
//  PrinterExtWithConnectAsyncViewController.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "PrinterExtWithConnectAsyncViewController.h"

#import "PrinterFunctions.h"

#import "Communication.h"

#import "GlobalQueueManager.h"

@implementation PrinterExtWithConnectAsyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshPrinter];
        });
    });
}

- (void)refreshPrinter {
    self.blind = YES;

    [self.starIoExtManager disconnect];
    
    [self.starIoExtManager connectAsync];
}

- (void)touchUpInsidePrintButton:(id)sender {
    NSData *commands = nil;

    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage]
                                                                     paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    switch (emulation) {
        case StarIoExtEmulationStarDotImpact:
            commands = [PrinterFunctions createTextReceiptData:emulation
                                              localizeReceipts:localizeReceipts
                                                          utf8:NO];
            break;
        default :
            commands = [PrinterFunctions createRasterReceiptData:emulation
                                                localizeReceipts:localizeReceipts];
            break;
    }
    
    self.blind = YES;
    
    [self.starIoExtManager.lock lock];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [Communication sendCommands:commands
                               port:self.starIoExtManager.port
                  completionHandler:^(BOOL result, NSString *title, NSString *message) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [self showSimpleAlertWithTitle:title
                                                 message:message
                                             buttonTitle:@"OK"
                                             buttonStyle:UIAlertActionStyleCancel
                                              completion:nil];
                          
                          [self.starIoExtManager.lock unlock];
                          
                          self.blind = NO;
                      });
                  }];
    });
}

- (void)manager:(StarIoExtManager *)manager didConnectPort:(NSString *)portName {
    if ((self.didAppear == NO) && (self.starIoExtManager.port != nil)) {
        [self.printButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        self.blind = NO;
    }
    
    self.didAppear = YES;
}

- (void)manager:(StarIoExtManager *)manager didFailToConnectPort:(NSString *)portName error:(NSError *)error {
    if (error != nil) {
        [self showSimpleAlertWithTitle:@"Fail to Open Port."
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:^(UIAlertController *alertController) {
                                self.commentLabel.text = [NSString stringWithFormat:@"%@\n"
                                                          "\n"
                                                          "Check the device. (Power and Bluetooth pairing)\n"
                                                          "Then touch up the Refresh button.\n", error.localizedDescription];
                                
                                self.commentLabel.textColor = UIColor.redColor;
                                
                                [self beginAnimationCommantLabel];
                                
                                self.blind = NO;
                            }];
    }
    
    self.didAppear = YES;
}

@end
