//
//  DisplayExtViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "DisplayExtViewController.h"

#import "AppDelegate.h"

#import <StarIO_Extension/StarIoExt.h>

#import "Communication.h"

#import "DisplayFunctions.h"

#import "GlobalQueueManager.h"

typedef NS_ENUM(NSInteger, DisplayStatus) {
    DisplayStatusInvalid = 0,
    DisplayStatusImpossible,
    DisplayStatusConnect,
    DisplayStatusDisconnect
};

@interface DisplayExtViewController ()

@property (nonatomic) SMPort *port;

@property (nonatomic) DisplayStatus displayStatus;

@property (nonatomic) NSRecursiveLock *lock;

@property (nonatomic) dispatch_group_t dispatchGroup;

@property (nonatomic) dispatch_semaphore_t terminateTaskSemaphore;

@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) SDCBInternationalType internationalType;
@property (nonatomic) SDCBCodePageType      codePageType;

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;

- (void)refreshDisplay;

- (BOOL)connect;

- (BOOL)disconnect;

- (void)watchDisplayTask;

- (void)beginAnimationCommantLabel;
- (void)endAnimationCommantLabel;

@end

@implementation DisplayExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _commentLabel.text = @"";
    
    _commentLabel.adjustsFontSizeToFitWidth = YES;
    
    [self appendRefreshButton:@selector(refreshDisplay)];
    
    _port = nil;
    
    _displayStatus = DisplayStatusInvalid;
    
    _lock = [NSRecursiveLock new];
    
    _dispatchGroup = dispatch_group_create();
    
    _terminateTaskSemaphore = dispatch_semaphore_create(1);
    
    _selectedIndexPath = nil;
    
    _internationalType = SDCBInternationalTypeUSA;
    _codePageType      = SDCBCodePageTypeCP437;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)  name:UIApplicationDidBecomeActiveNotification  object:nil];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshDisplay];
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self disconnect];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification  object:nil];
}

- (void)applicationDidBecomeActive {
    [self beginAnimationCommantLabel];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshDisplay];
        });
    });
}

- (void)applicationWillResignActive {
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self disconnect];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        switch (indexPath.row) {
            default : cell.textLabel.text = @"Text";                       break;     // 0
            case 1  : cell.textLabel.text = @"Graphic";                    break;
            case 2  : cell.textLabel.text = @"Back Light (Turn On / Off)"; break;
            case 3  : cell.textLabel.text = @"Cursor";                     break;
            case 4  : cell.textLabel.text = @"Contrast";                   break;
            case 5  : cell.textLabel.text = @"Character Set";              break;
            case 6  : cell.textLabel.text = @"User Defined Character";     break;
        }
        
        cell.detailTextLabel.text = @"";
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Contents";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedIndexPath = indexPath;
    
    [_pickerView reloadAllComponents];
    
    ISDCBBuilder *builder = [StarIoExt createDisplayCommandBuilder:StarIoExtDisplayModelSCD222];
    
    switch (indexPath.row) {
        default :
//      case 0  :     // Text
            [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:0 inComponent:0 animated:NO];
            
            [DisplayFunctions appendCharacterSet:builder internationalType:_internationalType codePageType:_codePageType];
            
            [DisplayFunctions appendTextPattern:builder number:0];
            break;
        case 1 :     // Graphic
            [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:0 inComponent:0 animated:NO];
            
            [DisplayFunctions appendGraphicPattern:builder number:0];
            break;
        case 2 :     // Turn On / Off
//          [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:0 inComponent:0 animated:NO];
            
            [DisplayFunctions appendTurnOn:builder turnOn:YES];
            break;
        case 3 :     // Cursor
            [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:SDCBCursorModeOn inComponent:0 animated:NO];
            
            [DisplayFunctions appendCursorMode:builder cursorMode:SDCBCursorModeOn];
            break;
        case 4 :     // Contrast
//          [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:SDCBContrastModeDefault inComponent:0 animated:NO];
            
            [DisplayFunctions appendContrastMode:builder contrastMode:SDCBContrastModeDefault];
            break;
        case 5 :     // Character Set
            [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:SDCBInternationalTypeUSA inComponent:0 animated:NO];
            [_pickerView selectRow:SDCBCodePageTypeCP437    inComponent:1 animated:NO];
            
            _internationalType = SDCBInternationalTypeUSA;
            _codePageType      = SDCBCodePageTypeCP437;
            
            [DisplayFunctions appendCharacterSet:builder internationalType:_internationalType codePageType:_codePageType];
            break;
        case 6 :     // User Defined Character
            [DisplayFunctions appendClearScreen:builder];
            
            [_pickerView selectRow:0 inComponent:0 animated:NO];
            
            [DisplayFunctions appendUserDefinedCharacter:builder set:YES];
            break;
    }
    
//  NSData *commands = [builder.commands            copy];
    NSData *commands = [builder.passThroughCommands copy];
    
    self.blind = YES;
    
    [_lock lock];
    
    if (_displayStatus == DisplayStatusConnect) {
        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommandsDoNotCheckCondition:commands
                                                      port:self->_port
                                         completionHandler:^(BOOL result, NSString *title, NSString *message) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result == NO) {
                        [self showSimpleAlertWithTitle:title
                                               message:message
                                           buttonTitle:@"OK"
                                           buttonStyle:UIAlertActionStyleCancel
                                            completion:nil];
                    }
                    
                    [self->_lock unlock];
                    
                    self.blind = NO;
                });
            }];
        });
    }
    else {
        [self showSimpleAlertWithTitle:@"Failure"
                               message:@"Display Disconnect."
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        
        [_lock unlock];
        
        self.blind = NO;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSInteger number;
    
    if (_selectedIndexPath == nil) {
        number = 0;
    }
    else {
        switch (_selectedIndexPath.row) {
            default : number = 1; break;     // Text
            case 1  : number = 1; break;     // Graphic
            case 2  : number = 1; break;     // Turn On / Off
            case 3  : number = 1; break;     // Cursor
            case 4  : number = 1; break;     // Contrast
            case 5  : number = 2; break;     // Character Set
            case 6  : number = 1; break;     // User Defined Character
        }
    }
    
    return number;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger number;
    
    if (_selectedIndexPath == nil) {
        number = 0;
    }
    else {
        switch (_selectedIndexPath.row) {
            default : number = 6;  break;     // Text
            case 1  : number = 2;  break;     // Graphic
            case 2  : number = 2;  break;     // Turn On / Off
            case 3  : number = 3;  break;     // Cursor
            case 4  : number = 7;  break;     // Contrast
            case 5  : number = 14; break;     // Character Set
            case 6  : number = 2;  break;     // User Defined Character
        }
    }
    
    return number;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *label = (id)view;
    
    if (! label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    if (_selectedIndexPath == nil) {
        label.text = @"";
    }
    else {
        switch (_selectedIndexPath.row) {
            default :
//          case 0  :     // Text
                switch (row) {
                    default : label.text = @"Pattern 1"; break;     // 0
                    case 1  : label.text = @"Pattern 2"; break;
                    case 2  : label.text = @"Pattern 3"; break;
                    case 3  : label.text = @"Pattern 4"; break;
                    case 4  : label.text = @"Pattern 5"; break;
                    case 5  : label.text = @"Pattern 6"; break;
                }
                
                break;
            case 1 :     // Graphic
                switch (row) {
                    case 0: label.text = @"Pattern 1"; break;
                    case 1: label.text = @"Pattern 2"; break;
                }
                
                break;
            case 2 :     // Turn On / Off
                switch (row) {
                    default : label.text = @"Turn On";  break;     // 0
                    case 1  : label.text = @"Turn Off"; break;
                }
                
                break;
            case 3 :     // Cursor
                switch (row) {
                    default : label.text = @"Off";   break;     // 0
                    case 1  : label.text = @"Blink"; break;
                    case 2  : label.text = @"On";    break;
                }
                
                break;
            case 4 :     // Contrast
                switch (row) {
                    case 0  : label.text = @"Contrast -3"; break;
                    case 1  : label.text = @"Contrast -2"; break;
                    case 2  : label.text = @"Contrast -1"; break;
                    default : label.text = @"Default";     break;     // 3
                    case 4  : label.text = @"Contrast +1"; break;
                    case 5  : label.text = @"Contrast +2"; break;
                    case 6  : label.text = @"Contrast +3"; break;
                }
                
                break;
            case 5 :     // Character Set
                switch (component) {
                    default :     // 0
                        switch (row) {
                            default : label.text = @"USA";           break;     // 0
                            case 1  : label.text = @"France";        break;
                            case 2  : label.text = @"Germany";       break;
                            case 3  : label.text = @"UK";            break;
                            case 4  : label.text = @"Denmark";       break;
                            case 5  : label.text = @"Sweden";        break;
                            case 6  : label.text = @"Italy";         break;
                            case 7  : label.text = @"Spain";         break;
                            case 8  : label.text = @"Japan";         break;
                            case 9  : label.text = @"Norway";        break;
                            case 10 : label.text = @"Denmark 2";     break;
                            case 11 : label.text = @"Spain 2";       break;
                            case 12 : label.text = @"Latin America"; break;
                            case 13 : label.text = @"Korea";         break;
                        }
                        
                        break;
                    case 1 :
                        switch (row) {
                            default : label.text = @"Code Page 437";       break;     // 0
                            case 1  : label.text = @"Katakana";            break;
                            case 2  : label.text = @"Code Page 850";       break;
                            case 3  : label.text = @"Code Page 860";       break;
                            case 4  : label.text = @"Code Page 863";       break;
                            case 5  : label.text = @"Code Page 865";       break;
                            case 6  : label.text = @"Code Page 1252";      break;
                            case 7  : label.text = @"Code Page 866";       break;
                            case 8  : label.text = @"Code Page 852";       break;
                            case 9  : label.text = @"Code Page 858";       break;
                            case 10 : label.text = @"Japanese";            break;
                            case 11 : label.text = @"Simplified Chinese";  break;
                            case 12 : label.text = @"Traditional Chinese"; break;
                            case 13 : label.text = @"Hangul";              break;
                        }
                        
                        break;
                }
                
                break;
            case 6 :     // User Defined Character
                switch (row) {
                    default : label.text = @"Set";   break;     // 0
                    case 1  : label.text = @"Reset"; break;
                }
                
                break;
        }
    }
    
    label.font                      = [UIFont systemFontOfSize:22.0];
    label.textAlignment             = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    ISDCBBuilder *builder = [StarIoExt createDisplayCommandBuilder:StarIoExtDisplayModelSCD222];
    
    switch (_selectedIndexPath.row) {
        default :
//      case 0  :     // Text
            [DisplayFunctions appendTextPattern:builder number:(int) row];
            break;
        case 1 :     // Graphic
            [DisplayFunctions appendGraphicPattern:builder number:(int) row];
            break;
        case 2 :     // Turn On / Off
            switch (row) {
                default : [DisplayFunctions appendTurnOn:builder turnOn:YES]; break;     // 0
                case 1  : [DisplayFunctions appendTurnOn:builder turnOn:NO];  break;
            }
            
            break;
        case 3 :     // Cursor
            [DisplayFunctions appendCursorMode:builder cursorMode:row];
            break;
        case 4 :     // Contrast
            [DisplayFunctions appendContrastMode:builder contrastMode:row];
            break;
        case 5 :     // Character Set
            _internationalType = [_pickerView selectedRowInComponent:0];
            _codePageType      = [_pickerView selectedRowInComponent:1];
            
            [DisplayFunctions appendCharacterSet:builder internationalType:_internationalType codePageType:_codePageType];
            break;
        case 6 :     // User Defined Character
            switch (row) {
                default : [DisplayFunctions appendUserDefinedCharacter:builder set:YES]; break;     // 0
                case 1  : [DisplayFunctions appendUserDefinedCharacter:builder set:NO];  break;
            }
            
            break;
    }
    
//  NSData *commands = [builder.commands            copy];
    NSData *commands = [builder.passThroughCommands copy];
    
    self.blind = YES;
    
    [_lock lock];
    
    if (_displayStatus == DisplayStatusConnect) {
        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            [Communication sendCommandsDoNotCheckCondition:commands
                                                      port:self->_port
                                         completionHandler:^(BOOL result, NSString *title, NSString *message) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result == NO) {
                        [self showSimpleAlertWithTitle:title
                                               message:message
                                           buttonTitle:@"OK"
                                           buttonStyle:UIAlertActionStyleCancel
                                            completion:nil];
                    }
                    
                    [self->_lock unlock];
                    
                    self.blind = NO;
                });
            }];
        });
    }
    else {
        [self showSimpleAlertWithTitle:@"Failure"
                               message:@"Display Disconnect."
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        
        [_lock unlock];
        
        self.blind = NO;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 160;
}

- (void)refreshDisplay {
    self.blind = YES;
    
    [self disconnect];
    
    if ([self connect] == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Fail to Open Port."
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    self->_commentLabel.text = @"Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button.";
                                                    
                                                    self->_commentLabel.textColor = [UIColor redColor];
                                                    
                                                    [self beginAnimationCommantLabel];
                                                    
                                                    self->_commentLabel.hidden = NO;
                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    self.blind = NO;
}

- (BOOL)connect {
    BOOL result = YES;
    
    if (_port == nil) {
        result = NO;
        
        @try {
            NSString *portName = [AppDelegate getPortName];

            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          _port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :10000];
            _port = [SMPort getPort:portName :[AppDelegate getPortSettings] :10000];     // 10000mS!!!
            
            if (_port != nil) {
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                NSOperatingSystemVersion version = {11, 0, 0};
                BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
                if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                    [NSThread sleepForTimeInterval:0.2];
                }
                
                StarPrinterStatus_2 status;
                
                [_port getParsedStatus:&status :2];
                
                dispatch_semaphore_wait(_terminateTaskSemaphore, DISPATCH_TIME_FOREVER);
                
                dispatch_group_async(_dispatchGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self watchDisplayTask];
                });
                
                result = YES;
            }
        }
        @catch (NSException *exc) {
            [SMPort releasePort:_port];
            
            _port = nil;
        }
    }
    
    return result;
}

- (BOOL)disconnect {
    BOOL result = YES;
    
    if (_port != nil) {
        result = NO;
        
        dispatch_semaphore_signal(_terminateTaskSemaphore);
        
        dispatch_group_wait(_dispatchGroup, DISPATCH_TIME_FOREVER);
        
        [SMPort releasePort:_port];
        
        _port = nil;
        
        _displayStatus = DisplayStatusInvalid;
        
        result = YES;
    }
    
    return result;
}

- (void)watchDisplayTask {
    while (YES) {
        @autoreleasepool {
//          BOOL portValid = NO;
            BOOL portValid = YES;
            
            if ([_lock tryLock]) {
                portValid = NO;
                
                if (_port != nil) {
                    if (_port.connected == YES) {
                        portValid = YES;
                    }
                }
                
                if (portValid == YES) {
                    ISCPConnectParser *parser = [StarIoExt createDisplayConnectParser:StarIoExtDisplayModelSCD222];
                    
                    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                    
                    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
                        [Communication parseDoNotCheckCondition:parser
                                                           port:self->_port
                                              completionHandler:^(BOOL result, NSString *title, NSString *message) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (result == YES) {
                                    if (parser.connect == YES) {
                                        if (self->_displayStatus != DisplayStatusConnect) {
                                            self->_displayStatus = DisplayStatusConnect;
                                            
//                                          _commentLabel.text = @"Accessory Connect Success.";
//
//                                          _commentLabel.textColor = [UIColor blueColor];
//
//                                          [self beginAnimationCommantLabel];
                                            
                                            self->_commentLabel.hidden = YES;
                                        }
                                    }
                                    else {
                                        if (self->_displayStatus != DisplayStatusDisconnect) {
                                            self->_displayStatus = DisplayStatusDisconnect;
                                            
                                            self->_commentLabel.text = @"Display Disconnect.";
                                            
                                            self->_commentLabel.textColor = [UIColor redColor];
                                            
                                            [self beginAnimationCommantLabel];
                                            
                                            self->_commentLabel.hidden = NO;
                                        }
                                    }
                                }
                                else {
                                    if (self->_displayStatus != DisplayStatusImpossible) {
                                        self->_displayStatus = DisplayStatusImpossible;
                                        
//                                      _commentLabel.text = @"Display Impossible.";
                                        self->_commentLabel.text = @"Printer Impossible.";
                                        
                                        self->_commentLabel.textColor = [UIColor redColor];
                                        
                                        [self beginAnimationCommantLabel];
                                        
                                        self->_commentLabel.hidden = NO;
                                    }
                                }
                            });
                        }];
                        
                        dispatch_semaphore_signal(semaphore);
                    });
                    
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self->_displayStatus != DisplayStatusImpossible) {
                            self->_displayStatus = DisplayStatusImpossible;
                            
//                          _commentLabel.text = @"Display Impossible.";
                            self->_commentLabel.text = @"Printer Impossible.";
                            
                            self->_commentLabel.textColor = [UIColor redColor];
                            
                            [self beginAnimationCommantLabel];
                            
                            self->_commentLabel.hidden = NO;
                        }
                    });
                }
                
                [_lock unlock];
            }
            
            dispatch_time_t timeout;
            
            timeout = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);     // 1000mS!!!
            
            if (dispatch_semaphore_wait(_terminateTaskSemaphore, timeout) == 0) {
                dispatch_semaphore_signal(_terminateTaskSemaphore);
                break;
            }
        }
    }
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

- (void)endAnimationCommantLabel {
    [_commentLabel.layer removeAllAnimations];
}

@end
