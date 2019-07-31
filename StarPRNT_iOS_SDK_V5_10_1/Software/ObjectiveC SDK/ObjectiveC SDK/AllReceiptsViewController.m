//
//  AllReceiptsViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "AllReceiptsViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "AllReceiptsFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

#import <SMCloudServices/SMCloudServices.h>

@interface AllReceiptsViewController ()

@end

@implementation AllReceiptsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger number;
    
    switch (section) {
        default :
//      case 0  :
//      case 1  :
            number = 5;
            break;
        case 2 :
            number = 1;
            break;
        case 3 :
            number = 3;
            break;
    }
    
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0 ||
        indexPath.section == 1) {
        static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        if (cell != nil) {
            cell.backgroundColor = [UIColor whiteColor];
            
            ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
            
            switch (indexPath.row) {
                default :
//              case 0  :
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize];
                    break;
                case 1 :
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize];
                    break;
                case 2 :
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize];
                    break;
                case 3 :
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize];
                    break;
                case 4 :
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize];
                    break;
            }
            
            cell.detailTextLabel.text = @"";
            
            cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            
//          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            ModelIndex modelIndex = [AppDelegate getSelectedModelIndex];
            if (modelIndex == ModelIndexNone) {
                NSAssert(NO, @"");
            }
            
            PrinterInfo *printerInfo = [ModelCapability printerInfoAtModelIndex:modelIndex];
            if (printerInfo == nil) {
                NSAssert(NO, @"");
            }
            
            BOOL userInteractionEnabled = YES;
            
            if ([SMCloudServices isRegistered] == NO) {
                userInteractionEnabled = NO;
            } else {
                if (indexPath.row == 0) {
                    userInteractionEnabled = printerInfo.supportTextReceipt;
                }
                if (indexPath.row == 1) {
                    userInteractionEnabled = printerInfo.supportUTF8 && printerInfo.supportTextReceipt;
                }
            }

            if (userInteractionEnabled == YES) {
                cell.textLabel.alpha = 1.0;
                cell.detailTextLabel.alpha = 1.0;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.userInteractionEnabled = YES;
            }
            else {
                cell.textLabel.alpha = 0.3;
                cell.detailTextLabel.alpha = 0.3;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.userInteractionEnabled = NO;
            }
        }
    }
    else if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        if (cell != nil) {
            cell.backgroundColor = [UIColor colorWithRed:0.8 green:1.0 blue:0.9 alpha:1.0];
            
            if ([SMCloudServices isRegistered] == NO) {
                cell.      textLabel.text = @"Unregistered Device";
                cell.detailTextLabel.text = @"";
                
                cell.      textLabel.textColor = [UIColor redColor];
                cell.detailTextLabel.textColor = [UIColor redColor];
                
                [UIView beginAnimations:nil context:nil];
                
                cell.      textLabel.alpha = 0.0;
                cell.detailTextLabel.alpha = 0.0;
                
                [UIView setAnimationDelay             :0.0];                            // 0mS!!!
                [UIView setAnimationDuration          :0.6];                            // 600mS!!!
                [UIView setAnimationRepeatCount       :UINT32_MAX];
                [UIView setAnimationRepeatAutoreverses:YES];
                [UIView setAnimationCurve             :UIViewAnimationCurveEaseIn];
                
                cell.      textLabel.alpha = 1.0;
                cell.detailTextLabel.alpha = 1.0;
                
                [UIView commitAnimations];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.userInteractionEnabled = YES;
            }
            else {
                cell.textLabel      .text = @"Registration Details";
                cell.detailTextLabel.text = @"";
                
                cell.      textLabel.textColor = [UIColor blueColor];
                cell.detailTextLabel.textColor = [UIColor blueColor];
                
                cell      .textLabel.alpha = 1.0;
                cell.detailTextLabel.alpha = 1.0;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.userInteractionEnabled = YES;
            }
        }
    }
    else {     // section == 3
        static NSString *CellIdentifier = @"SwitchTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell != nil) {
            SwitchTableViewCell *customCell = (SwitchTableViewCell *) cell;
            
            customCell.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0];
            
            customCell.stateSwitch.on = YES;
            
            NSInteger allReceiptsSettings = [AppDelegate getAllReceiptsSettings];
            
            switch (indexPath.row) {
                default :
//              case 0  :
                    customCell.titleLabel.text = @"Receipt";
                    
                    if ((allReceiptsSettings & 0x00000001) == 0x00000000) {
                        customCell.stateSwitch.on = NO;
                    }
                    
                    break;
                case 1 :
                    customCell.titleLabel.text = @"Information";
                    
                    if ((allReceiptsSettings & 0x00000002) == 0x00000000) {
                        customCell.stateSwitch.on = NO;
                    }
                    
                    break;
                case 2 :
                    customCell.titleLabel.text = @"QR Code";
                    
                    if ((allReceiptsSettings & 0x00000004) == 0x00000000) {
                        customCell.stateSwitch.on = NO;
                    }
                    
                    break;
            }
            
            customCell.titleLabel.textColor = [UIColor blueColor];
            
            customCell.delegate = self;
            
            CGRect frame = customCell.titleLabel.frame;
            
            UIEdgeInsets insets = self.tableView.separatorInset;
            
            frame.origin.x = insets.left;
            
            customCell.titleLabel.frame = frame;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    switch (section) {
        default :
//      case 0  :
            title = @"Like a StarIO-SDK Sample";
            break;
        case 1 :
            title = @"StarIoExtManager Sample";
            break;
        case 2 :
            title = @"Procedure";
            break;
        case 3 :
            title = @"Print Setting";
            break;
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        StarIoExtEmulation emulation = [AppDelegate getEmulation];
        
        NSInteger width = [AppDelegate getSelectedPaperSize];
        
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        void (^completionUpload)(NSInteger statusCode, NSError *error) = ^(NSInteger statusCode, NSError *error) {
            NSString *prompt = nil;
            
            if (error) {
                prompt = [NSString stringWithFormat:@"%@", error];
            }
            else {
                prompt = [NSString stringWithFormat:@"Status Code : %d", (int) statusCode];
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
        
        switch (indexPath.row) {
            default :
//          case 0  :
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
            
            NSString *portName     = [AppDelegate getPortName];
            NSString *portSettings = [AppDelegate getPortSettings];
            
            dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
                [Communication sendCommands:commands
                                   portName:portName
                               portSettings:portSettings
                                    timeout:10000
                          completionHandler:^(BOOL result, NSString *title, NSString *message) {     // 10000mS!!!
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
    }
    else if (indexPath.section == 1) {
        [AppDelegate setSelectedIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"PushAllReceiptsExtViewController" sender:nil];
    }
    else if (indexPath.section == 2) {
        [SMCloudServices showRegistrationView:^(BOOL isRegistration) {
            [self->_tableView reloadData];
        }];
    }
//  else {     // section == 3
//  }
}

- (void)tableView:(UITableView *)tableView valueChangedStateSwitch:(BOOL)on indexPath:(NSIndexPath *)indexPath {
    NSInteger allReceiptsSettings = [AppDelegate getAllReceiptsSettings];
    
    if (on == YES) {
        switch (indexPath.row) {
            default :
//          case 0  :
                allReceiptsSettings |= 0x00000001;
                break;
            case 1 :
                allReceiptsSettings |= 0x00000002;
                break;
            case 2 :
                allReceiptsSettings |= 0x00000004;
                break;
        }
    }
    else {
        switch (indexPath.row) {
            default :
//          case 0  :
                allReceiptsSettings &= 0x0000fffe;
                break;
            case 1 :
                allReceiptsSettings &= 0x0000fffd;
                break;
            case 2 :
                allReceiptsSettings &= 0x0000fffb;
                break;
        }
    }
    
    [AppDelegate setAllReceiptsSettings:allReceiptsSettings];
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [appDelegate.settingManager save];
}

@end
