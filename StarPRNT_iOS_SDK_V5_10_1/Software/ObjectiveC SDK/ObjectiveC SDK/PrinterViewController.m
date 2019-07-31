//
//  PrinterViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "PrinterViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "PrinterFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

#import "ModelCapability.h"

#import "PrinterInfo.h"

@interface CustomUIImagePickerController : UIImagePickerController

@end

@implementation CustomUIImagePickerController

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (IS_IPAD()) {
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end

@interface PrinterViewController ()

@end

@implementation PrinterViewController

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
    
    if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
        return 3;
    }
    else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
        if (section == 0) {
            return 7;
        } else if (section == 1) {
            return 8;
        } else {
            return 2;
        }
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        if (indexPath.section != 2) {
            ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
            
            if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
                switch (indexPath.row) {
                    default :
//                  case 0  :
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
                    case 5 :
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon",                  localizeReceipts.languageCode];
                        break;
                    case 6 :
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode];
                        break;
                    case 7 : {
                        NSString *receiptTypeTitle = nil;
                        if ([AppDelegate getEmulation] == StarIoExtEmulationStarDotImpact) {
                            receiptTypeTitle = @"Text";
                        } else {
                            receiptTypeTitle = @"Raster";
                        }
                        
                        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@ Receipt (connectAsync)",
                                               localizeReceipts.languageCode,
                                               localizeReceipts.paperSize,
                                               receiptTypeTitle];
                    }
                }
            }
            else {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt (UTF8)", localizeReceipts.languageCode, localizeReceipts.paperSize];
            }
            
            cell.detailTextLabel.text = @"";
            
            cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            
//          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
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
        else {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Print Photo from Library";
            }
            else {
                cell.textLabel.text = @"Print Photo by Camera";
            }
            
            cell.detailTextLabel.text = @"";
            
            cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
                        
            cell.      textLabel.alpha = 1.0;
            cell.detailTextLabel.alpha = 1.0;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.userInteractionEnabled = YES;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Like a StarIO-SDK Sample";
    }
    else if (section == 1) {
        title = @"StarIoExtManager Sample";
    }
    else {
        title = @"Appendix";
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSData *commands = nil;
        
        StarIoExtEmulation emulation = [AppDelegate getEmulation];
        
        NSInteger width = [AppDelegate getSelectedPaperSize];
        
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
            switch (indexPath.row) {
                default :
//              case 0  :
                    commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:NO];
                    break;
                case 1 :
                    commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:YES];
                    break;
                case 2 :
                case 7 :
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
        }
        else {
            commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:YES];
        }
        
        self.blind = YES;
        
        NSString *portName     = [AppDelegate getPortName];
        NSString *portSettings = [AppDelegate getPortSettings];

        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommands:commands
                               portName:portName
                           portSettings:portSettings
                                timeout:10000
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
    else if (indexPath.section == 1) {
        if ([AppDelegate getSelectedLanguage] != LanguageIndexCJKUnifiedIdeograph) {
            [AppDelegate setSelectedIndex:indexPath.row];
        }
        else {
            [AppDelegate setSelectedIndex:1];
        }

        NSString *identifier = (indexPath.row == 7) ? @"PushPrinterExtWithConnectAsyncViewController" : @"PushPrinterExtViewController";
        [self performSegueWithIdentifier:identifier sender:nil];
    }
    else {
        if (indexPath.row == 0) {
//                UIImagePickerController *imagePickerController =       [[UIImagePickerController alloc] init];
            CustomUIImagePickerController *imagePickerController = [[CustomUIImagePickerController alloc] init];
            
            imagePickerController.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.allowsEditing = NO;
            imagePickerController.delegate      = self;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.sourceType    = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.allowsEditing = NO;
            imagePickerController.delegate      = self;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSData *commands = nil;
        
        ISCBBuilder *builder = [StarIoExt createCommandBuilder:[AppDelegate getEmulation]];
        
        [builder beginDocument];
        
        [builder appendBitmap:image diffusion:YES width:[AppDelegate getSelectedPaperSize] bothScale:YES];
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        commands = [builder.commands copy];
        
        self.blind = YES;
        
        NSString *portName     = [AppDelegate getPortName];
        NSString *portSettings = [AppDelegate getPortSettings];
        
        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommands:commands
                               portName:portName
                           portSettings:portSettings
                                timeout:10000
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
    }];
}

@end
