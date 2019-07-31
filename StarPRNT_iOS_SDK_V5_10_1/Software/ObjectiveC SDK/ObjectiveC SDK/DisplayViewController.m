//
//  DisplayViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "DisplayViewController.h"

#import "AppDelegate.h"

#import <StarIO_Extension/StarIoExt.h>

#import "Communication.h"

#import "DisplayFunctions.h"

@interface DisplayViewController ()

@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) SDCBInternationalType internationalType;
@property (nonatomic) SDCBCodePageType      codePageType;

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectedIndexPath = nil;
    
    _internationalType = SDCBInternationalTypeUSA;
    _codePageType      = SDCBCodePageTypeCP437;
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 9;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                default : cell.textLabel.text = @"Check Status";                  break;     // 0
                case 1  : cell.textLabel.text = @"Text";                          break;
                case 2  : cell.textLabel.text = @"Graphic";                       break;
                case 3  : cell.textLabel.text = @"Back Light (Turn On / Off)";    break;
                case 4  : cell.textLabel.text = @"Cursor";                        break;
                case 5  : cell.textLabel.text = @"Contrast";                      break;
                case 6  : cell.textLabel.text = @"Character Set (International)"; break;
                case 7  : cell.textLabel.text = @"Character Set (Code Page)";     break;
                case 8  : cell.textLabel.text = @"User Defined Character";        break;
            }
        }
        else {
            cell.textLabel.text = @"Sample";
        }
        
        cell.detailTextLabel.text = @"";
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Contents";
    }
    else {
        title = @"Like a StarIoExtManager Sample";
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedIndexPath = indexPath;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.blind = YES;
            
            SMPort *port = nil;
            
            @try {
                NSString *portName = [AppDelegate getPortName];
                
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :10000];
                port = [SMPort getPort:portName :[AppDelegate getPortSettings] :10000];     // 10000mS!!!
                
                if (port != nil) {
                    // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                    // (Refer Readme for details)
                    NSOperatingSystemVersion version = {11, 0, 0};
                    BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
                    if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                        [NSThread sleepForTimeInterval:0.2];
                    }
                    
                    ISCPConnectParser *parser = [StarIoExt createDisplayConnectParser:StarIoExtDisplayModelSCD222];
                    
                    [Communication parseDoNotCheckCondition:parser port:port completionHandler:^(BOOL result, NSString *title, NSString *message) {
                        if (result == YES) {
                            if (parser.connect == YES) {
                                [self showSimpleAlertWithTitle:@"Check Status"
                                                       message:@"Display Connect."
                                                   buttonTitle:@"OK"
                                                   buttonStyle:UIAlertActionStyleCancel
                                                    completion:nil];
                            }
                            else {
                                [self showSimpleAlertWithTitle:@"Check Status"
                                                       message:@"Display Disconnect."
                                                   buttonTitle:@"OK"
                                                   buttonStyle:UIAlertActionStyleCancel
                                                    completion:nil];
                            }
                        }
                        else {
                            [self showSimpleAlertWithTitle:@"Failure"
                                                   message:@"Printer Impossible."
                                               buttonTitle:@"OK"
                                               buttonStyle:UIAlertActionStyleCancel
                                                completion:nil];
                        }
                    }];
                }
                else {
                    [self showSimpleAlertWithTitle:@"Fail to Open Port"
                                           message:@""
                                       buttonTitle:@"OK"
                                       buttonStyle:UIAlertActionStyleCancel
                                        completion:nil];
                }
            }
            @catch (PortException *exc) {
            }
            @finally {
                if (port != nil) {
                    [SMPort releasePort:port];
                    
                    port = nil;
                }
            }
            
            self.blind = NO;
        }
        else {
            ISDCBBuilder *builder = [StarIoExt createDisplayCommandBuilder:StarIoExtDisplayModelSCD222];
            
            switch (indexPath.row) {
                case 1: {
                    [self showAlertWithTitle:@"Select Text"
                                     message:nil
                                buttonTitles:@[@"Pattern 1", @"Pattern 2", @"Pattern 3",
                                               @"Pattern 4", @"Pattern 5", @"Pattern 6"]
                                     handler:^(int buttonIndex) {
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         [DisplayFunctions appendCharacterSet:builder
                                                            internationalType:self->_internationalType
                                                                 codePageType:self->_codePageType];
                                         
                                         [DisplayFunctions appendTextPattern:builder
                                                                      number:(int) buttonIndex];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 2: {
                    [self showAlertWithTitle:@"Select Graphic"
                                     message:nil
                                buttonTitles:@[@"Pattern 1", @"Pattern 2"]
                                     handler:^(int buttonIndex) {
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         [DisplayFunctions appendGraphicPattern:builder
                                                                         number:(int) buttonIndex];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 3: {
                    [self showAlertWithTitle:@"Select Turn On / Off"
                                     message:nil
                                buttonTitles:@[@"Turn On", @"Turn Off"]
                                     handler:^(int buttonIndex) {
                                         switch (buttonIndex) {
                                             case 0:
                                                 [DisplayFunctions appendTurnOn:builder
                                                                         turnOn:YES];
                                                 break;
                                             case 1:
                                                 [DisplayFunctions appendTurnOn:builder
                                                                         turnOn:NO];
                                                 break;
                                         }
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 4: {
                    [self showAlertWithTitle:@"Select Cursor"
                                     message:nil
                                buttonTitles:@[@"Off", @"Blink", @"On"]
                                     handler:^(int buttonIndex) {
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         [DisplayFunctions appendCursorMode:builder
                                                                 cursorMode:buttonIndex];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 5: {
                    [self showAlertWithTitle:@"Select Contrast"
                                     message:nil
                                buttonTitles:@[@"Contrast -3", @"Contrast -2", @"Contrast -1",
                                               @"Default", @"Contrast +1", @"Contrast +2",
                                               @"Contrast +3"]
                                     handler:^(int buttonIndex) {
                                         [DisplayFunctions appendContrastMode:builder
                                                                 contrastMode:buttonIndex];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 6: {
                    [self showAlertWithTitle:@"Select Character Set (International)"
                                     message:nil
                                buttonTitles:@[@"USA", @"France", @"Germany", @"UK",
                                               @"Denmark", @"Sweden", @"Italy", @"Spain",
                                               @"Japan", @"Norway", @"Denmark 2",
                                               @"Spain 2", @"Latin America", @"Korea"]
                                     handler:^(int buttonIndex) {
                                         self->_internationalType = buttonIndex;
                                         
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         [DisplayFunctions appendCharacterSet:builder
                                                            internationalType:self->_internationalType
                                                                 codePageType:self->_codePageType];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 7: {
                    [self showAlertWithTitle:@"Select Character Set (Code Page)"
                                     message:nil
                                buttonTitles:@[@"Code Page 437", @"Katakana", @"Code Page 850",
                                               @"Code Page 860", @"Code Page 863",
                                               @"Code Page 865", @"Code Page 1252",
                                               @"Code Page 866", @"Code Page 852",
                                               @"Code Page 858", @"Japanese", @"Simplified Chinese",
                                               @"Traditional Chinese", @"Hangul"]
                                     handler:^(int buttonIndex) {
                                         self->_codePageType = buttonIndex;
                                         
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         [DisplayFunctions appendCharacterSet:builder
                                                            internationalType:self->_internationalType
                                                                 codePageType:self->_codePageType];
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                case 8: {
                    [self showAlertWithTitle:@"Select User Defined Character"
                                     message:nil
                                buttonTitles:@[@"Set", @"Reset"]
                                     handler:^(int buttonIndex) {
                                         [DisplayFunctions appendClearScreen:builder];
                                         
                                         switch (buttonIndex) {
                                             case 0:
                                                 [DisplayFunctions appendUserDefinedCharacter:builder
                                                                                          set:YES];
                                                 break;
                                             case 1:
                                                 [DisplayFunctions appendUserDefinedCharacter:builder
                                                                                          set:NO];
                                                 break;
                                         }
                                         
                                         NSData *commands = [builder.passThroughCommands copy];
                                         
                                         [self sendCommandsToPrinter:commands];
                                     }];
                    break;
                }
                default :
                    NSAssert(YES, nil);
            }
        }
    }
    else {
        [AppDelegate setSelectedIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"PushDisplayExtViewController" sender:nil];
    }
}

- (void)sendCommandsToPrinter:(NSData *)commands {
    self.blind = YES;
    
    SMPort *port = nil;
    
    @try {
        NSString *portName = [AppDelegate getPortName];

        // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
        // (Refer Readme for details)
//      port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :10000];
        port = [SMPort getPort:portName :[AppDelegate getPortSettings] :10000];     // 10000mS!!!
        
        if (port != nil) {
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            ISCPConnectParser *parser = [StarIoExt createDisplayConnectParser:StarIoExtDisplayModelSCD222];
            
            [Communication parseDoNotCheckCondition:parser port:port completionHandler:^(BOOL result, NSString *title, NSString *message) {
                if (result == YES) {
                    if (parser.connect == YES) {
                        [Communication sendCommandsDoNotCheckCondition:commands port:port completionHandler:^(BOOL result, NSString *title, NSString *message) {
                            if (result == NO) {
                                [self showSimpleAlertWithTitle:title
                                                       message:message
                                                   buttonTitle:@"OK"
                                                   buttonStyle:UIAlertActionStyleCancel
                                                    completion:nil];
                            }
                        }];
                    }
                    else {
                        [self showSimpleAlertWithTitle:@"Failure"
                                               message:@"Display Disconnect."
                                           buttonTitle:@"OK"
                                           buttonStyle:UIAlertActionStyleCancel
                                            completion:nil];
                    }
                }
                else {
                    [self showSimpleAlertWithTitle:@"Failure"
                                           message:@"Printer Impossible."
                                       buttonTitle:@"OK"
                                       buttonStyle:UIAlertActionStyleCancel
                                        completion:nil];
                }
            }];
        }
        else {
            [self showSimpleAlertWithTitle:@"Fail to Open Port"
                                   message:@""
                               buttonTitle:@"OK"
                               buttonStyle:UIAlertActionStyleCancel
                                completion:nil];
        }
    }
    @catch (PortException *exc) {
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    self.blind = NO;
}

@end
