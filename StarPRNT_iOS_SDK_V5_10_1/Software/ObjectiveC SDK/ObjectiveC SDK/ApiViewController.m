//
//  ApiViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "ApiViewController.h"

#import "AppDelegate.h"

#import "ApiFunctions.h"

#import "Communication.h"

#import "GlobalQueueManager.h"

@interface ApiViewController ()

@end

@implementation ApiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 27;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Generic";
                break;
            case 1:
                cell.textLabel.text = @"Font Style";
                break;
            case 2:
                cell.textLabel.text = @"Initialization";
                break;
            case 3:
                cell.textLabel.text = @"Code Page";
                break;
            case 4:
                cell.textLabel.text = @"International";
                break;
            case 5:
                cell.textLabel.text = @"Feed";
                break;
            case 6:
                cell.textLabel.text = @"Character Space";
                break;
            case 7:
                cell.textLabel.text = @"Line Space";
                break;
            case 8:
                cell.textLabel.text = @"Top Margin";
                break;
            case 9:
                cell.textLabel.text = @"Emphasis";
                break;
            case 10:
                cell.textLabel.text = @"Invert";
                break;
            case 11:
                cell.textLabel.text = @"Under Line";
                break;
            case 12:
                cell.textLabel.text = @"Multiple";
                break;
            case 13:
                cell.textLabel.text = @"Absolute Position";
                break;
            case 14:
                cell.textLabel.text = @"Alignment";
                break;
            case 15:
                cell.textLabel.text = @"Horizontal Tab Position";
                break;
            case 16 :
                cell.textLabel.text = @"Logo";
                break;
            case 17:
                cell.textLabel.text = @"Cut Paper";
                break;
            case 18:
                cell.textLabel.text = @"Peripheral";
                break;
            case 19:
                cell.textLabel.text = @"Sound";
                break;
            case 20:
                cell.textLabel.text = @"Bitmap";
                break;
            case 21:
                cell.textLabel.text = @"Barcode";
                break;
            case 22:
                cell.textLabel.text = @"PDF417";
                break;
            case 23:
                cell.textLabel.text = @"QR Code";
                break;
            case 24:
                cell.textLabel.text = @"Black Mark";
                break;
            case 25:
                cell.textLabel.text = @"Page Mode";
                break;
            case 26:
                cell.textLabel.text = @"Printable Area";
                break;
            default :
                NSAssert(NO, nil);
        }
        
        cell.detailTextLabel.text = @"";
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Sample";
}

- (void)sendCommands:(NSData *)commands {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSData *commands = nil;
    
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    NSInteger width = [AppDelegate getSelectedPaperSize];
    
    switch (indexPath.row) {
        case 0:
            commands = [ApiFunctions createGenericData:emulation];
            break;
        case 1:
            commands = [ApiFunctions createFontStyleData:emulation];
            break;
        case 2:
            commands = [ApiFunctions createInitializationData:emulation];
            break;
        case 3:
            commands = [ApiFunctions createCodePageData:emulation];
            break;
        case 4:
            commands = [ApiFunctions createInternationalData:emulation];
            break;
        case 5:
            commands = [ApiFunctions createFeedData:emulation];
            break;
        case 6:
            commands = [ApiFunctions createCharacterSpaceData:emulation];
            break;
        case 7:
            commands = [ApiFunctions createLineSpaceData:emulation];
            break;
        case 8:
            commands = [ApiFunctions createTopMarginData:emulation];
            break;
        case 9:
            commands = [ApiFunctions createEmphasisData:emulation];
            break;
        case 10:
            commands = [ApiFunctions createInvertData:emulation];
            break;
        case 11:
            commands = [ApiFunctions createUnderLineData:emulation];
            break;
        case 12:
            commands = [ApiFunctions createMultipleData:emulation];
            break;
        case 13:
            commands = [ApiFunctions createAbsolutePositionData:emulation];
            break;
        case 14:
            commands = [ApiFunctions createAlignmentData:emulation];
            break;
        case 15:
            commands = [ApiFunctions createHorizontalTabPositionData:emulation];
            break;
        case 16:
            commands = [ApiFunctions createLogoData:emulation];
            break;
        case 17:
            commands = [ApiFunctions createCutPaperData:emulation];
            break;
        case 18:
            commands = [ApiFunctions createPeripheralData:emulation];
            break;
        case 19:
            commands = [ApiFunctions createSoundData:emulation];
            break;
        case 20:
            commands = [ApiFunctions createBitmapData:emulation width:width];
            break;
        case 21:
            commands = [ApiFunctions createBarcodeData:emulation];
            break;
        case 22:
            commands = [ApiFunctions createPdf417Data:emulation];
            break;
        case 23:
            commands = [ApiFunctions createQrCodeData:emulation];
            break;
        case 24: {
            [self showAlertWithTitle:@"Select black mark type."
                             message:nil
                        buttonTitles:@[@"Invalid", @"Valid", @"Valid with Detection"]
                             handler:^(int buttonIndex) {
                                 StarIoExtEmulation emulation = [AppDelegate getEmulation];

                                 SCBBlackMarkType blackMarkType;
                                 switch (buttonIndex) {
                                     case 0:
                                         blackMarkType = SCBBlackMarkTypeInvalid;
                                         break;
                                     case 1:
                                         blackMarkType = SCBBlackMarkTypeValid;
                                         break;
                                     case 2:
                                         blackMarkType = SCBBlackMarkTypeValidWithDetection;
                                         break;
                                     default:
                                         exit(1);
                                 }

                                 NSData *commands = [ApiFunctions createBlackMarkData:emulation
                                                                                 type:blackMarkType];

                                 [self sendCommands:commands];
                             }];
            break;
        }
        case 25:
            commands = [ApiFunctions createPageModeData:emulation width:width];
            break;
        case 26:
            [self printPrintableAreaSampleWithEmulation:emulation];
            break;
        default:
            NSAssert(NO, @"");
    }
    
    if (commands != nil) {
        [self sendCommands:commands];
    }
}

- (void)printPrintableAreaSampleWithEmulation:(StarIoExtEmulation)emulation {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select printable area type."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    void (^addAction)(NSString *, SCBPrintableAreaType) = ^(NSString *title, SCBPrintableAreaType type){
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           NSData *commands = [ApiFunctions createPrintableAreaDataWithEmulation:emulation
                                                                                                                            type:type];
                                                           
                                                           [self sendCommands:commands];
                                                       }];
        [alert addAction:action];
    };
    
    addAction(@"Standard", SCBPrintableAreaTypeStandard);
    addAction(@"Type1", SCBPrintableAreaTypeType1);
    addAction(@"Type2", SCBPrintableAreaTypeType2);
    addAction(@"Type3", SCBPrintableAreaTypeType3);
    addAction(@"Type4", SCBPrintableAreaTypeType4);
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}
@end

