//
//  MainViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "MainViewController.h"

#import "AppDelegate.h"

#import "ModelCapability.h"

#import "Communication.h"

#import "SearchPortViewController.h"

#import <SMCloudServices/SMCloudServices.h>

typedef NS_ENUM(NSInteger, SectionIndex) {
    SectionIndexDevice = 0,
    SectionIndexPrinter,
    SectionIndexPeripheral,
    SectionIndexCombination,
    SectionIndexApi,
    SectionIndexAllReceipts,
    SectionIndexDeviceStatus,
    SectionIndexBluetooth,
    SectionIndexAppendix
};

@interface MainViewController ()

@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *title = @"StarPRNT Objective-C SDK";
    
    NSString *version = [NSString stringWithFormat:@"Ver.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", title, version];
    
    _selectedIndexPath = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
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
    
//  return SectionIndexDevice            + 1;
//  return SectionIndexPrinter           + 1;
//  return SectionIndexPeripheral        + 1;
//  return SectionIndexCombination       + 1;
//  return SectionIndexApi               + 1;
//  return SectionIndexAllReceipts       + 1;
//  return SectionIndexDeviceStatus      + 1;
//  return SectionIndexBluetooth         + 1;
    return SectionIndexAppendix          + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == SectionIndexDevice) {
        return 1;
    }
    
    if (section == SectionIndexPrinter) {
        return 5;
    }
    
    if (section == SectionIndexPeripheral) {
        return 4;
    }
    
    if (section == SectionIndexDeviceStatus) {
        return 2;
    }
    
    if (section == SectionIndexBluetooth) {
        return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if (indexPath.section == SectionIndexDevice) {
        if ([appDelegate.settingManager.settings[0] isNull]) {
            static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            }
            
            if (cell != nil) {
                cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
                
                cell.      textLabel.text = @"Unselected State";
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
        }
        else {
            PrinterSetting *printerSetting = appDelegate.settingManager.settings[indexPath.row];
            
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
    }
    else {
        static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        if (cell != nil) {
            switch (indexPath.section) {
                case SectionIndexPrinter: {
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    switch (indexPath.row) {
                        default:
                        case 0:
                            cell.textLabel.text = @"Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 1:
                            cell.textLabel.text = @"Black Mark Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 2:
                            cell.textLabel.text = @"Black Mark Sample (Paste)";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 3:
                            cell.textLabel.text = @"Page Mode Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 4:
                            cell.textLabel.text = @"Print Re-Direction Sample";
                            cell.detailTextLabel.text = @"";
                    }
                    
                    cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                }
                case SectionIndexPeripheral :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    switch (indexPath.row) {
                        default:
                        case 0:
                            cell.textLabel.text = @"Cash Drawer Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 1:
                            cell.textLabel.text = @"Barcode Reader Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 2:
                            cell.textLabel.text = @"Display Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 3:
                            cell.textLabel.text = @"Melody Speaker Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                    }
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexCombination   :
                    cell.backgroundColor = [UIColor whiteColor];

                    cell.      textLabel.text = @"StarIoExtManager Sample";
                    cell.detailTextLabel.text = @"";

                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexApi :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    cell.      textLabel.text = @"Sample";
                    cell.detailTextLabel.text = @"";
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexAllReceipts :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    cell.      textLabel.text = @"Sample";
                    cell.detailTextLabel.text = @"";
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexDeviceStatus :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    switch (indexPath.row) {
                        default :
//                      case 0  :
                            cell.      textLabel.text = @"Sample";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 1 :
                            cell.      textLabel.text = @"Product Serial Number";
                            cell.detailTextLabel.text = @"";
                            break;
                    }
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexBluetooth :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    switch (indexPath.row) {
                        default :
//                      case 0  :
                            cell.      textLabel.text = @"Pairing and Connect Bluetooth";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 1 :
                            cell.      textLabel.text = @"Disconnect Bluetooth";
                            cell.detailTextLabel.text = @"";
                            break;
                        case 2 :
                            cell.      textLabel.text = @"Bluetooth Setting";
                            cell.detailTextLabel.text = @"";
                            break;
                    }
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
                case SectionIndexAppendix :
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    cell.      textLabel.text = @"Framework Version";
                    cell.detailTextLabel.text = @"";
                    
                    cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                    break;
            }
            
            BOOL userInteractionEnabled = YES;
            
            if ([[AppDelegate getModelName] isEqualToString:@""]) {
                userInteractionEnabled = NO;
            }
            
            ModelIndex modelIndex = [AppDelegate getSelectedModelIndex];
            
            if (modelIndex != ModelIndexNone) {
                PrinterInfo *printerInfo = [ModelCapability printerInfoAtModelIndex:modelIndex];
                if (printerInfo != nil) {
                    switch (indexPath.section) {
                        case SectionIndexPrinter:
                            switch (indexPath.row) {
                                case 1:
                                case 2:
                                    userInteractionEnabled = printerInfo.supportBlackMark;
                                    break;
                                case 3:
                                    userInteractionEnabled = printerInfo.supportPageMode;
                                    break;
                                case 4:
                                    if ([appDelegate.settingManager.settings[0] isNull]) {
                                        userInteractionEnabled = NO;
                                    }
                                    break;
                            }
                            break;
                        case SectionIndexPeripheral:
                            switch (indexPath.row) {
                                case 0:
                                    userInteractionEnabled = printerInfo.supportCashDrawer;
                                    break;
                                case 1:
                                    userInteractionEnabled = printerInfo.supportBarcodeReader;
                                    break;
                                case 2:
                                    userInteractionEnabled = printerInfo.supportCustomerDisplay;
                                    break;
                                case 3:
                                    userInteractionEnabled = printerInfo.supportMelodySpeaker;
                                    break;
                            }
                            break;
                        case SectionIndexCombination:
                            userInteractionEnabled = printerInfo.supportBarcodeReader;
                            break;
                        case SectionIndexAllReceipts:
                            userInteractionEnabled = printerInfo.supportAllReceipts;
                            break;
                        case SectionIndexDeviceStatus:
                            if (indexPath.row == 1) {
                                NSString *modelName = [AppDelegate getModelName];
                                NSLog(@"modelName = %@", modelName);
                                if (([modelName hasPrefix:@"TSP113 "]) ||
                                    ([modelName hasPrefix:@"TSP143 "])) {
                                    userInteractionEnabled = NO;
                                } else {
                                    userInteractionEnabled = printerInfo.supportProductSerialNumber;
                                }
                            }
                            break;
                        case SectionIndexBluetooth:
                            if (indexPath.row == 1) {
                                userInteractionEnabled = printerInfo.supportDisconnectBluetooth;
                            }
                            break;
                        default:
                            break;
                    }
                } else {
                    userInteractionEnabled = NO;
                }
            } else {
                userInteractionEnabled = NO;
            }
            
            if (indexPath.section == SectionIndexBluetooth) {
                if (indexPath.row == 0) {     // Pairing and Connect Bluetooth
                    userInteractionEnabled = YES;
                }
                if (indexPath.row == 1) {     // Disconnect Bluetooth
                    if ([[AppDelegate getPortName] hasPrefix:@"BT:"] == NO) {
                        userInteractionEnabled = NO;
                    }
                }
                if (indexPath.row == 2) {     // Bluetooth Setting
                    if ([[AppDelegate getPortName] hasPrefix:@"BT:"]  == NO &&
                        [[AppDelegate getPortName] hasPrefix:@"BLE:"] == NO) {
                        userInteractionEnabled = NO;
                    }
                }
            }
            
            if (indexPath.section == SectionIndexAppendix) {
                userInteractionEnabled = YES;
            }
            
            if (userInteractionEnabled == YES) {
                cell.      textLabel.alpha = 1.0;
                cell.detailTextLabel.alpha = 1.0;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.userInteractionEnabled = YES;
            }
            else {
                cell.      textLabel.alpha = 0.3;
                cell.detailTextLabel.alpha = 0.3;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.userInteractionEnabled = NO;
            }
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    switch (section) {
        default                 :
//      case SectionIndexDevice :
            title = @"Destination Device";
            break;
        case SectionIndexPrinter :
            title = @"Printer";
            break;
        case SectionIndexPeripheral :
            title = @"Peripheral";
            break;
        case SectionIndexCombination :
            title = @"Combination";
            break;
        case SectionIndexApi :
            title = @"API";
            break;
        case SectionIndexAllReceipts :
            title = @"Star Micronics Cloud";
            break;
        case SectionIndexDeviceStatus :
            title = @"Device Status";
            break;
        case SectionIndexBluetooth :
            title = @"Interface";
            break;
        case SectionIndexAppendix :
            title = @"Appendix";
            break;
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedIndexPath = indexPath;
    
    switch (_selectedIndexPath.section) {
        case SectionIndexDevice:
            [self performSegueWithIdentifier:@"PushSearchPortViewController" sender:nil];
            break;
        case SectionIndexPrinter:
            switch (_selectedIndexPath.row) {
                case 0: {
                    [self showAlertWithTitle:@"Select language."
                                     message:nil
                                buttonTitles:@[@"English", @"Japanese", @"French",
                                               @"Portuguese", @"Spanish", @"German",
                                               @"Russian", @"Simplified Chinese",
                                               @"Traditional Chinese", @"UTF8 Multi language"]
                                     handler:^(int buttonIndex) {
                                         [AppDelegate setSelectedLanguage:buttonIndex];
                                         
                                         NSString *segueName = @"PushPrinterViewController";
                                         
                                         [self performSegueWithIdentifier:segueName sender:nil];
                                      }];
                    break;
                }
                case 1: {
                    [self showAlertWithTitle:@"Select language."
                                     message:nil
                                buttonTitles:@[@"English", @"Japanese"]
                                     handler:^(int buttonIndex) {
                                         [AppDelegate setSelectedLanguage:buttonIndex];
                                         
                                         NSString *segueName = @"PushBlackMarkViewController";
                                         
                                         [self performSegueWithIdentifier:segueName sender:nil];
                                     }];
                }
                case 2: {
                    [self showAlertWithTitle:@"Select language."
                                     message:nil
                                buttonTitles:@[@"English", @"Japanese"]
                                     handler:^(int buttonIndex) {
                                         [AppDelegate setSelectedLanguage:buttonIndex];
                                         
                                         NSString *segueName = @"PushBlackMarkPasteViewController";
                                         
                                         [self performSegueWithIdentifier:segueName sender:nil];
                                     }];
                    break;
                }
                case 3: {
                    [self showAlertWithTitle:@"Select language."
                                     message:nil
                                buttonTitles:@[@"English", @"Japanese"]
                                     handler:^(int buttonIndex) {
                                         [AppDelegate setSelectedLanguage:buttonIndex];
                                         
                                         NSString *segueName = @"PushPageModeViewController";
                                         
                                         [self performSegueWithIdentifier:segueName sender:nil];
                                     }];
                    break;
                }
                case 4: {
                    [self showAlertWithTitle:@"Select language."
                                     message:nil
                                buttonTitles:@[@"English", @"Japanese", @"French",
                                               @"Portuguese", @"Spanish", @"German",
                                               @"Russian", @"Simplified Chinese",
                                               @"Traditional Chinese"]
                                     handler:^(int buttonIndex) {
                                         [AppDelegate setSelectedLanguage:buttonIndex];
                                         
                                         NSString *segueName = @"PushPrintReDirectionViewController";
                                         
                                         [self performSegueWithIdentifier:segueName
                                                                   sender:nil];
                                     }];
                    break;
                }
            }
            break;
        case SectionIndexPeripheral:
            switch (_selectedIndexPath.row) {
                case 0: {
                    [self performSegueWithIdentifier:@"PushCashDrawerViewController" sender:nil];
                    break;
                }
                case 1: {
                    [self performSegueWithIdentifier:@"PushBarcodeReaderExtViewController" sender:nil];
                    break;
                }
                case 2: {
                    [self performSegueWithIdentifier:@"PushDisplayViewController" sender:nil];
                    break;
                }
                case 3: {
                    [self performSegueWithIdentifier:@"PushMelodySpeakerViewController" sender:nil];
                    break;
                }
            }
            break;
        case SectionIndexCombination: {
            [self showAlertWithTitle:@"Select language."
                             message:nil
                        buttonTitles:@[@"English", @"Japanese", @"French", @"Portuguese",
                                       @"Spanish", @"German", @"Russian", @"Simplified Chinese",
                                       @"Traditional Chinese"]
                             handler:^(int buttonIndex) {
                                 [AppDelegate setSelectedLanguage:buttonIndex];
                                 
                                 NSString *segueName = @"PushCombinationViewController";
                                 
                                 [self performSegueWithIdentifier:segueName sender:nil];
                             }];
            break;
        }
        case SectionIndexApi:
            [self performSegueWithIdentifier:@"PushApiViewController" sender:nil];
            break;
        case SectionIndexAllReceipts: {
            [self showAlertWithTitle:@"Select language."
                             message:nil
                        buttonTitles:@[@"English", @"Japanese", @"French", @"Portuguese", @"Spanish", @"German"]
                             handler:^(int buttonIndex) {
                                 [AppDelegate setSelectedLanguage:buttonIndex];
                                 
                                 NSString *segueName = @"PushAllReceiptsViewController";
                                 
                                 [self performSegueWithIdentifier:segueName sender:nil];
                             }];
            
            break;
        }
        case SectionIndexDeviceStatus :
            if (_selectedIndexPath.row == 0) {
                [self performSegueWithIdentifier:@"PushDeviceStatusViewController" sender:nil];
            }
            else {
                [self confirmSerialNumber];
            }
            
            break;
        case SectionIndexBluetooth :
            if (_selectedIndexPath.row == 0) {
                [Communication connectBluetooth:^(BOOL result, NSString *title, NSString *message) {
                    if (title   != nil ||
                        message != nil) {
                        [self showSimpleAlertWithTitle:title
                                               message:message
                                           buttonTitle:@"OK"
                                           buttonStyle:UIAlertActionStyleCancel
                                            completion:nil];
                    }
                }];
            }
            else if (_selectedIndexPath.row == 1) {
                self.blind = YES;
                
                NSString *modelName    = [AppDelegate getModelName];
                NSString *portName     = [AppDelegate getPortName];
                NSString *portSettings = [AppDelegate getPortSettings];
                
                [Communication disconnectBluetooth:modelName portName:portName portSettings:portSettings timeout:10000 completionHandler:^(BOOL result, NSString *title, NSString *message) {     // 10000mS!!!
                    [self showSimpleAlertWithTitle:title
                                           message:message
                                       buttonTitle:@"OK"
                                       buttonStyle:UIAlertActionStyleCancel
                                        completion:nil];
                    
                }];
                
                self.blind = NO;
            }
            else {  // _selectedIndexPath.row == 2
                [self performSegueWithIdentifier:@"PushBluetoothSettingViewController" sender:nil];
            }
            
            break;
        case SectionIndexAppendix :
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@\n%@\n%@", @"StarIO version",
                                 [SMPort StarIOVersion],
                                 [StarIoExt description],
                                 [SMCloudServices description]];

            [self showSimpleAlertWithTitle:@"Framework Version"
                                   message:message
                               buttonTitle:@"OK"
                               buttonStyle:UIAlertActionStyleDefault
                                completion:nil];
        }
            break;
    }
}

- (void)confirmSerialNumber {
    self.blind = YES;
    
    NSString *portName = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    NSInteger timeout = 10000;
    
    [Communication confirmSerialNumber:portName
                          portSettings:portSettings
                               timeout:timeout
                     completionHandler:^(BOOL result, NSString *title, NSString *message) {
                         [self showSimpleAlertWithTitle:title
                                                message:message
                                            buttonTitle:@"OK"
                                            buttonStyle:UIAlertActionStyleCancel
                                             completion:nil];
                     }];
    
    self.blind = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushSearchPortViewController"]) {
        SearchPortViewController *vc = (SearchPortViewController *)segue.destinationViewController;
        vc.selectedPrinterIndex = 0;
    }
}

@end
