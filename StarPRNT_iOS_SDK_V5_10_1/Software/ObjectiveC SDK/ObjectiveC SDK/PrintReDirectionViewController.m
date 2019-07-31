//
//  PrintReDirectionViewController.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "PrintReDirectionViewController.h"

#import "AppDelegate.h"

#import "PrinterFunctions.h"

#import "GlobalQueueManager.h"

#import "Communication.h"

#import "SearchPortViewController.h"

#import <StarIO_Extension/StarIoExtManager.h>

@implementation PrintReDirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Backup Device";
        case 1:
            return @"Sample";
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 7;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"PushSearchSubPortViewController" sender:self];
    } else if (indexPath.section == 1) {
        NSData *commands = nil;
        
        StarIoExtEmulation emulation = [AppDelegate getEmulation];
        
        NSInteger width = [AppDelegate getSelectedPaperSize];
        
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage]
                                                                         paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
            switch (indexPath.row) {
                case 0:
                    commands = [PrinterFunctions createTextReceiptData:emulation
                                                      localizeReceipts:localizeReceipts
                                                                  utf8:NO];
                    break;
                case 1:
                    commands = [PrinterFunctions createTextReceiptData:emulation
                                                      localizeReceipts:localizeReceipts
                                                                  utf8:YES];
                    break;
                case 2:
                    commands = [PrinterFunctions createRasterReceiptData:emulation
                                                        localizeReceipts:localizeReceipts];
                    break;
                case 3:
                    commands = [PrinterFunctions createScaleRasterReceiptData:emulation
                                                             localizeReceipts:localizeReceipts
                                                                        width:width
                                                                    bothScale:YES];
                    break;
                case 4:
                    commands = [PrinterFunctions createScaleRasterReceiptData:emulation
                                                             localizeReceipts:localizeReceipts
                                                                        width:width
                                                                    bothScale:NO];
                    break;
                case 5:
                    commands = [PrinterFunctions createCouponData:emulation
                                                 localizeReceipts:localizeReceipts
                                                            width:width
                                                         rotation:SCBBitmapConverterRotationNormal];
                    break;
                case 6:
                    commands = [PrinterFunctions createCouponData:emulation
                                                 localizeReceipts:localizeReceipts
                                                            width:width
                                                         rotation:SCBBitmapConverterRotationRight90];
                    break;
                default:
                    assert(0);
            }
        }
        else {
            commands = [PrinterFunctions createTextReceiptData:emulation
                                              localizeReceipts:localizeReceipts
                                                          utf8:YES];
        }
        
        self.blind = YES;
        
        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommandsForPrintReDirectionWithCommands:commands timeout:10000
                                                            completion:^(BOOL result, NSString *message) {
                                                                self.blind = NO;
                                                                
                                                                [self showSimpleAlertWithTitle:@"Communication Result"
                                                                                       message:message buttonTitle:@"OK" buttonStyle:UIAlertActionStyleCancel completion:nil];
                                                            }];
        });
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    
    if (cell != nil) {
        if (indexPath.section == 0) {
            if ([appDelegate.settingManager.settings[1] isNull]) {
                static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                  reuseIdentifier:CellIdentifier];
                }
                
                if (cell != nil) {
                    cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
                    
                    cell.textLabel.text = @"Unselected State";
                    cell.detailTextLabel.text = @"";
                    
                    cell.textLabel.textColor = [UIColor redColor];
                    cell.detailTextLabel.textColor = [UIColor redColor];
                    
                    [UIView beginAnimations:nil context:nil];
                    
                    cell.textLabel.alpha = 0.0;
                    cell.detailTextLabel.alpha = 0.0;
                    
                    [UIView setAnimationDelay:0.0];
                    [UIView setAnimationDuration:0.6];
                    [UIView setAnimationRepeatCount:UINT32_MAX];
                    [UIView setAnimationRepeatAutoreverses:YES];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                    
                    cell.textLabel.alpha = 1.0;
                    cell.detailTextLabel.alpha = 1.0;
                    
                    [UIView commitAnimations];
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    cell.userInteractionEnabled = YES;
                }
            }
            else {
                PrinterSetting *printerSetting = appDelegate.settingManager.settings[1];
                
                static NSString *CellIdentifier = @"UITableViewCellStyleSubTitle";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                  reuseIdentifier:CellIdentifier];
                }
                
                cell.textLabel.text = printerSetting.modelName;
                
                if ([printerSetting.macAddress isEqualToString:@""]) {
                    cell.detailTextLabel.text = printerSetting.portName;
                } else {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)",
                                                 printerSetting.portName,
                                                 printerSetting.macAddress];
                }
                
                cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
                cell.textLabel.textColor = UIColor.blueColor;
                cell.detailTextLabel.textColor = UIColor.blueColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                return cell;
            }
        } else if (indexPath.section == 1) {
            ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage]
                                                                             paperSizeIndex:[AppDelegate getSelectedPaperSize]];
            
            if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.paperSize];
                        break;
                    case 1:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt (UTF8)",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.paperSize];
                        break;
                    case 2:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.paperSize];
                        break;
                    case 3:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Both Scale)",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.scalePaperSize];
                        break;
                    case 4:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Scale)",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.scalePaperSize];
                        break;
                    case 5:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon",
                                               localizeReceipts.languageCode];
                        break;
                    case 6:
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon (Rotation90)",
                                               localizeReceipts.languageCode];
                        break;
                }
            }
            else {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt (UTF8)", localizeReceipts.languageCode, localizeReceipts.paperSize];
            }
            
            cell.detailTextLabel.text = @"";
            
            cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            
            BOOL userInteractionEnabled = YES;
            
            ModelIndex modelIndex = AppDelegate.getSelectedModelIndex;
            
            PrinterInfo *printerInfo = [ModelCapability printerInfoAtModelIndex:modelIndex];
            
            if (indexPath.row == 0 ||     // Text Receipt
                indexPath.row == 1) {     // Text Receipt (UTF8)
                userInteractionEnabled = printerInfo.supportTextReceipt;
            }
            
            if (indexPath.row == 1) {     // Text Receipt (UTF8)
                userInteractionEnabled = printerInfo.supportUTF8;
            }
            
            if (indexPath.row == 2 ||     // Raster Receipt
                indexPath.row == 3 ||     // Raster Receipt (Both Scale)
                indexPath.row == 4) {     // Raster Receipt (Scale)
                userInteractionEnabled = printerInfo.supportRasterReceipt;
            }
            
            if ([AppDelegate getSelectedLanguage] == LanguageIndexCJKUnifiedIdeograph) {
                userInteractionEnabled = printerInfo.supportCJK;
            }
            
            if ([appDelegate.settingManager.settings[1] isNull]) {
                userInteractionEnabled = NO;
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
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushSearchSubPortViewController"]) {
        SearchPortViewController *vc = (SearchPortViewController *)segue.destinationViewController;
        vc.selectedPrinterIndex = 1;
    }
}

@end
