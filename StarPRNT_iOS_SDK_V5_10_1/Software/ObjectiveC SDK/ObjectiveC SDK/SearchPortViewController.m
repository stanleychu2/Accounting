//
//  SearchPortViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "SearchPortViewController.h"

#import "AppDelegate.h"

#import "ModelCapability.h"

#import <StarIO/SMPort.h>

typedef NS_ENUM(NSInteger, CellParamIndex) {
    CellParamIndexPortName = 0,
    CellParamIndexModelName,
    CellParamIndexMacAddress
};

@interface SearchPortViewController ()

@property (nonatomic) NSMutableArray *cellArray;

@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) BOOL didAppear;

@property (nonatomic) NSString *portName;
@property (nonatomic) NSString *portSettings;
@property (nonatomic) NSString *modelName;
@property (nonatomic) NSString *macAddress;

@property (nonatomic) StarIoExtEmulation emulation;

@property (nonatomic) ModelIndex selectedModelIndex;

@property (nonatomic) PaperSizeIndex paperSizeIndex;

@property (nonatomic) AppDelegate *appDelegate;

- (void)refreshPortInfo;

@end

@implementation SearchPortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self appendRefreshButton:@selector(refreshPortInfo)];
    
    _cellArray = [[NSMutableArray alloc] init];
    
    _selectedIndexPath = nil;
    
    _paperSizeIndex = PaperSizeIndexNone;
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _didAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_didAppear == NO) {
        [self refreshPortInfo];
        
        _didAppear = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCellStyleSubtitle";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        NSArray *cellParam = _cellArray[indexPath.row];
        
        cell.textLabel.text = cellParam[CellParamIndexModelName];
        
        if ([cellParam[CellParamIndexMacAddress] isEqualToString:@""]) {
            cell.detailTextLabel.text = cellParam[CellParamIndexPortName];
        }
        else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", cellParam[CellParamIndexPortName], cellParam[CellParamIndexMacAddress]];
        }
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if (_selectedIndexPath != nil) {
            if ([indexPath compare:_selectedIndexPath] == NSOrderedSame) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"List";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell;
    
    if (_selectedIndexPath != nil) {
        cell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
        
        if (cell != nil) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    _selectedIndexPath = indexPath;
    
    NSArray *cellParam = _cellArray[_selectedIndexPath.row];
    
    NSString *modelName  = cellParam[CellParamIndexModelName];
    
    ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
    
    if (modelIndex != ModelIndexNone) {
        _selectedModelIndex = modelIndex;
        
        NSString *message = [NSString stringWithFormat:@"Is your printer %@?",
                             [ModelCapability titleAtModelIndex:modelIndex]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm."
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"YES"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self didConfirmModelWithButtonIndex:1];
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"NO"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self didConfirmModelWithButtonIndex:0];
                                                }]];
        
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.01f * NSEC_PER_SEC);
        dispatch_after(delay, dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
    }
    else {
        NSMutableArray<NSString *> *buttonTitles = [NSMutableArray array];
        for (int i = 0; i < [ModelCapability modelIndexCount]; i++) {
            NSString *title = [ModelCapability titleAtModelIndex:[ModelCapability modelIndexAtIndex:i]];
            
            [buttonTitles addObject:title];
        }
        
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.01f * NSEC_PER_SEC);
        dispatch_after(delay, dispatch_get_main_queue(), ^{
            [self showAlertWithTitle:@"Confirm."
                             message:@"What is your printer?"
                        buttonTitles:[buttonTitles copy]
                             handler:^(int buttonIndex) {
                                 [self didSelectModelWithButtonIndex:buttonIndex];
                             }];
        });
    }
}

- (void)refreshPortInfo {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Interface."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    NSArray<NSString *> *interfaces = @[@"LAN", @"Bluetooth", @"Bluetooth Low Energy", @"USB", @"All"];
    
    for (NSUInteger i = 0; i < interfaces.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:interfaces[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self didSelectRefreshPortWithButtonIndex:i];
                                                       }];
        [alert addAction:action];
    }

    [alert addAction:[UIAlertAction actionWithTitle:@"Manual"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self didSelectManual];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didConfirmModelWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {     // YES!!!
        NSArray *cellParam = _cellArray[_selectedIndexPath.row];
        
        _portName   = cellParam[CellParamIndexPortName];
        _modelName  = cellParam[CellParamIndexModelName];
        _macAddress = cellParam[CellParamIndexMacAddress];
        
        ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:_modelName];
        
        _portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
        _emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
        _selectedModelIndex = modelIndex;
        
        switch (_emulation) {
            case StarIoExtEmulationStarDotImpact:
                _paperSizeIndex = PaperSizeIndexDotImpactThreeInch;
                break;
            case StarIoExtEmulationEscPos:
                _paperSizeIndex = PaperSizeIndexEscPosThreeInch;
                break;
            default:
                _paperSizeIndex = PaperSizeIndexNone;
                break;
        }
        
        if (self.selectedPrinterIndex > 0) {
            _paperSizeIndex = self->_appDelegate.settingManager.settings[0].selectedPaperSize;
        }
        
        if (_paperSizeIndex == PaperSizeIndexNone) {
            [self showAlertWithTitle:@"Select paper size."
                             message:nil
                        buttonTitles:@[@"2\" (384dots)", @"3\" (576dots)", @"4\" (832dots)"]
                             handler:^(int buttonIndex) {
                                 [self didSelectPaperSizeWithButtonIndex:buttonIndex];
                             }];
        }
        else {
            if ([ModelCapability cashDrawerOpenActiveAtModelIndex:modelIndex] == YES) {
                [self showAlertWithTitle:@"Select CashDrawer Open Status."
                                 message:nil
                            buttonTitles:@[@"High when Open", @"Low when Open"]
                                 handler:^(int buttonIndex) {
                                     [self didSelectCashDrawerOpenActiveHighWithButtonIndex:buttonIndex];
                                 }];
            }
            else {
                [self saveParamsWithPortName:_portName
                                portSettings:_portSettings
                                   modelName:_modelName
                                  macAddress:_macAddress
                                   emulation:_emulation
                    cashDrawerOpenActiveHigh:YES
                                  modelIndex:_selectedModelIndex
                              paperSizeIndex:_paperSizeIndex];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else {     // NO!!!
        NSMutableArray<NSString *> *buttonTitles = [NSMutableArray array];
        for (int i = 0; i < [ModelCapability modelIndexCount]; i++) {
            NSString *title = [ModelCapability titleAtModelIndex:[ModelCapability modelIndexAtIndex:i]];
            
            [buttonTitles addObject:title];
        }
        
        [self showAlertWithTitle:@"Confirm."
                         message:@"What is your printer?"
                    buttonTitles:[buttonTitles copy]
                         handler:^(int buttonIndex) {
                             [self didSelectModelWithButtonIndex:buttonIndex];
                         }];
    }
}

- (void)didSelectPaperSizeWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            _paperSizeIndex = PaperSizeIndexTwoInch;
            break;
        case 1:
            _paperSizeIndex = PaperSizeIndexThreeInch;
            break;
        case 2:
            _paperSizeIndex = PaperSizeIndexFourInch;
            break;
    }
    
    if (_selectedModelIndex == ModelIndexNone) {
        NSAssert(NO, nil);
    }
    
    if ([ModelCapability cashDrawerOpenActiveAtModelIndex:_selectedModelIndex] == YES) {
        [self showAlertWithTitle:@"Select CashDrawer Open Status."
                         message:nil
                    buttonTitles:@[@"High when Open", @"Low when Open"]
                         handler:^(int buttonIndex) {
                             [self didSelectCashDrawerOpenActiveHighWithButtonIndex:buttonIndex];
                         }];
    }
    else {
        [self saveParamsWithPortName:_portName
                        portSettings:_portSettings
                           modelName:_modelName
                          macAddress:_macAddress
                           emulation:_emulation
            cashDrawerOpenActiveHigh:YES
                          modelIndex:_selectedModelIndex
                      paperSizeIndex:_paperSizeIndex];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didSelectModelWithButtonIndex:(int)buttonIndex {
    NSArray *cellParam = _cellArray[_selectedIndexPath.row];
    
    _portName   = cellParam[CellParamIndexPortName];
    _modelName  = cellParam[CellParamIndexModelName];
    _macAddress = cellParam[CellParamIndexMacAddress];
    
    ModelIndex modelIndex = [ModelCapability modelIndexAtIndex:buttonIndex];
    
    _portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
    _emulation    = [ModelCapability emulationAtModelIndex:modelIndex];
    _selectedModelIndex = modelIndex;
    
    switch (_emulation) {
        case StarIoExtEmulationEscPos:
            _paperSizeIndex = PaperSizeIndexEscPosThreeInch;
            break;
        case StarIoExtEmulationStarDotImpact:
            _paperSizeIndex = PaperSizeIndexDotImpactThreeInch;
            break;
        default:
            _paperSizeIndex = PaperSizeIndexNone;
            break;
    }
    
    if (self.selectedPrinterIndex > 0) {
        _paperSizeIndex = self->_appDelegate.settingManager.settings[0].selectedPaperSize;
    }
    
    if (_paperSizeIndex == PaperSizeIndexNone) {
        [self showAlertWithTitle:@"Select paper size."
                         message:nil
                    buttonTitles:@[@"2\" (384dots)", @"3\" (576dots)", @"4\" (832dots)"]
                         handler:^(int buttonIndex) {
                             [self didSelectPaperSizeWithButtonIndex:buttonIndex];
                         }];
    } else {
        if ([ModelCapability cashDrawerOpenActiveAtModelIndex:modelIndex] == YES) {
            [self showAlertWithTitle:@"Select CashDrawer Open Status."
                             message:nil
                        buttonTitles:@[@"High when Open", @"Low when Open"]
                             handler:^(int buttonIndex) {
                                 [self didSelectCashDrawerOpenActiveHighWithButtonIndex:buttonIndex];
                             }];
        }
        else {
            [self saveParamsWithPortName:_portName
                            portSettings:_portSettings
                               modelName:_modelName
                              macAddress:_macAddress
                               emulation:_emulation
                cashDrawerOpenActiveHigh:YES
                              modelIndex:_selectedModelIndex
                          paperSizeIndex:_paperSizeIndex];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
                         
- (void)didSelectCashDrawerOpenActiveHighWithButtonIndex:(NSInteger)buttonIndex {
    BOOL isCashDrawerOpenActiveHigh = NO;
    if (buttonIndex == 0) {     // High when Open
        isCashDrawerOpenActiveHigh = YES;
    }
    else if (buttonIndex == 1) {     // Low when Open
        isCashDrawerOpenActiveHigh = NO;
    } else {
        NSAssert(NO, nil);
    }
    
    [self saveParamsWithPortName:_portName
                    portSettings:_portSettings
                       modelName:_modelName
                      macAddress:_macAddress
                       emulation:_emulation
        cashDrawerOpenActiveHigh:isCashDrawerOpenActiveHigh
                      modelIndex:_selectedModelIndex
                  paperSizeIndex:_paperSizeIndex];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didInputPortName {
    if ([_portName isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the port name."
                                                                       message:@"Fill in the port name."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = self->_appDelegate.settingManager.settings[self->_selectedPrinterIndex].portName;
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    NSString *newPortName = alert.textFields.firstObject.text;
                                                    if (newPortName != nil) {
                                                        self->_portName = newPortName;
                                                    }
                                                    
                                                    [self didInputPortName];
                                                }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the port settings."
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = self->_appDelegate.settingManager.settings[self->_selectedPrinterIndex].portSettings;
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    NSString *newPortSettings = alert.textFields.firstObject.text;
                                                    if (newPortSettings != nil) {
                                                        self->_portSettings = newPortSettings;
                                                    }
                                                    
                                                    [self didInputPortSettings];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self.navigationController popViewControllerAnimated:YES];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didInputPortSettings {
    UIAlertController *nestAlertController = [UIAlertController alertControllerWithTitle:@"Confirm."
                                                                                 message:@"What is your printer?"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       NSUInteger index = [nestAlertController.actions indexOfObject:action];
                                                       
                                                       [self modelSelect1AlertClickedButtonAt:index];
                                                   }];
    
    [nestAlertController addAction:action];
    
    for (int i = 0; i < [ModelCapability modelIndexCount]; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[ModelCapability titleAtModelIndex:[ModelCapability modelIndexAtIndex:i]]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           NSUInteger index = [nestAlertController.actions indexOfObject:action];
                                                           
                                                           [self modelSelect1AlertClickedButtonAt:index];
                                                       }];
        
        [nestAlertController addAction:action];
    }
    
    [self presentViewController:nestAlertController
                       animated:YES
                     completion:nil];
}

- (void)didSelectRefreshPortWithButtonIndex:(NSInteger)buttonIndex {
    self.blind = YES;
    
    [_cellArray removeAllObjects];
    
    _selectedIndexPath = nil;
    
    NSArray *portInfoArray;
    
    switch (buttonIndex) {
        case 0:     // LAN
            portInfoArray = [SMPort searchPrinter:@"TCP:"];
            break;
        case 1:     // Bluetooth
            portInfoArray = [SMPort searchPrinter:@"BT:"];
            break;
        case 2:     // Bluetooth Low Energy
            portInfoArray = [SMPort searchPrinter:@"BLE:"];
            break;
        case 3:     // USB
            portInfoArray = [SMPort searchPrinter:@"USB:"];
            break;
        case 4:     // All
            portInfoArray = [SMPort searchPrinter];
            break;
    }
    
    PrinterSetting *currentSetting = self->_appDelegate.settingManager.settings[self->_selectedPrinterIndex];
    
    NSString *portName   = currentSetting.portName;
    NSString *modelName  = currentSetting.modelName;
    NSString *macAddress = currentSetting.macAddress;
    
    int row = 0;
    
    for (PortInfo *portInfo in portInfoArray) {
        [_cellArray addObject:@[portInfo.portName, portInfo.modelName, portInfo.macAddress]];
        
        if ([portInfo.portName   isEqualToString:portName]   == YES &&
            [portInfo.modelName  isEqualToString:modelName]  == YES &&
            [portInfo.macAddress isEqualToString:macAddress] == YES) {
            _selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        }
        
        row++;
    }
    
    [_tableView reloadData];
    
    self.blind = NO;
}

- (void)didSelectManual {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the port name."
                                                                   message:@"Fill in the port name."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = self->_appDelegate.settingManager.settings[self->_selectedPrinterIndex].portName;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                NSString *newPortName = alert.textFields.firstObject.text;
                                                if (newPortName != nil) {
                                                    self->_portName = newPortName;
                                                }
                                                
                                                [self didInputPortName];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)modelSelect1AlertClickedButtonAt:(NSUInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    
    ModelIndex modelIndex = [ModelCapability modelIndexAtIndex:buttonIndex - 1];

    _modelName    = [ModelCapability titleAtModelIndex       :modelIndex];
    _macAddress   = _portSettings;                                             // for display.
    _emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
    _selectedModelIndex = modelIndex;
    
    switch (_emulation) {
        case StarIoExtEmulationStarDotImpact:
            _paperSizeIndex = PaperSizeIndexDotImpactThreeInch;
            break;
        case StarIoExtEmulationEscPos:
            _paperSizeIndex = PaperSizeIndexEscPosThreeInch;
            break;
        default:
            _paperSizeIndex = PaperSizeIndexNone;
            break;
    }
    
    if (self.selectedPrinterIndex > 0) {
        _paperSizeIndex = self->_appDelegate.settingManager.settings[0].selectedPaperSize;
    }
    
    if (_paperSizeIndex == PaperSizeIndexNone) {
        [self showAlertWithTitle:@"Select paper size."
                         message:nil
                    buttonTitles:@[@"2\" (384dots)", @"3\" (576dots)", @"4\" (832dots)"]
                         handler:^(int buttonIndex) {
                             [self didSelectPaperSizeWithButtonIndex:buttonIndex];
                         }];
    } else {
        if ([ModelCapability cashDrawerOpenActiveAtModelIndex:modelIndex] == YES) {
            [self showAlertWithTitle:@"Select CashDrawer Open Status."
                             message:nil
                        buttonTitles:@[@"High when Open", @"Low when Open"]
                             handler:^(int buttonIndex) {
                                 [self didSelectCashDrawerOpenActiveHighWithButtonIndex:buttonIndex];
                             }];
        }
        else {
            [self saveParamsWithPortName:_portName
                            portSettings:_portSettings
                               modelName:_modelName
                              macAddress:_macAddress
                               emulation:_emulation
                cashDrawerOpenActiveHigh:YES
                              modelIndex:modelIndex
                          paperSizeIndex:_paperSizeIndex];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)saveParamsWithPortName:(NSString *)portName
                  portSettings:(NSString *)portSettings
                     modelName:(NSString *)modelName
                    macAddress:(NSString *)macAddress
                     emulation:(StarIoExtEmulation)emulation
      cashDrawerOpenActiveHigh:(BOOL)cashDrawerOpenActiveHigh
                    modelIndex:(ModelIndex)modelIndex
                paperSizeIndex:(PaperSizeIndex)paperSizeIndex {
    if (_selectedModelIndex != ModelIndexNone &&
        _paperSizeIndex != PaperSizeIndexNone) {
        NSInteger currentAllReceiptsSetting = _appDelegate.settingManager.settings[_selectedPrinterIndex].allReceiptsSettings;
        
        PrinterSetting *printerSetting = [[PrinterSetting alloc] initWithPortName:portName
                                                                     portSettings:portSettings
                                                                        modelName:modelName
                                                                       macAddress:macAddress
                                                                        emulation:emulation
                                                         cashDrawerOpenActiveHigh:cashDrawerOpenActiveHigh
                                                              allReceiptsSettings:currentAllReceiptsSetting
                                                                selectedPaperSize:paperSizeIndex
                                                               selectedModelIndex:modelIndex];
        
        _appDelegate.settingManager.settings[_selectedPrinterIndex] = printerSetting;
        [_appDelegate.settingManager save];
        
    } else {
        NSAssert(NO, nil);
    }
}

@end
