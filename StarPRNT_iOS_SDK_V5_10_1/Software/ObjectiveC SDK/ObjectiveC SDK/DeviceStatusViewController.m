//
//  DeviceStatusViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "DeviceStatusViewController.h"

#import "AppDelegate.h"

#import <StarIO/SMPort.h>

typedef NS_ENUM(NSUInteger, CellParamIndex) {
    CellParamIndexTitleIndex = 0,
    CellParamIndexDetailIndex,
    CellParamIndexColorIndex
};

@interface DeviceStatusViewController ()

@property (nonatomic) NSMutableArray *statusCellArray;

@property (nonatomic) NSMutableArray *firmwareInfoCellArray;

@property (nonatomic) BOOL didAppear;

- (void)refreshDeviceStatus;

@end

@implementation DeviceStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self appendRefreshButton:@selector(refreshDeviceStatus)];
    
    _statusCellArray = [[NSMutableArray alloc] init];
    
    _firmwareInfoCellArray = [[NSMutableArray alloc] init];
    
    _didAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_didAppear == NO) {
        [self refreshDeviceStatus];
        
        _didAppear = YES;
    }
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
    
    if (_statusCellArray      .count != 0 &&
        _firmwareInfoCellArray.count != 0) {
        return 2;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0) {
        return _statusCellArray.count;
    }
    else {  // section == 1
        return _firmwareInfoCellArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        NSArray *cellParam;
        
        if (indexPath.section == 0) {
            cellParam = _statusCellArray[indexPath.row];
        }
        else {  // indexPath.section == 1
            cellParam = _firmwareInfoCellArray[indexPath.row];
        }
        
        cell.      textLabel.text      = cellParam[CellParamIndexTitleIndex];
        cell.detailTextLabel.text      = cellParam[CellParamIndexDetailIndex];
        cell.detailTextLabel.textColor = cellParam[CellParamIndexColorIndex];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Device Status";
    }
    else {  // section == 1
        return @"Firmware Information";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshDeviceStatus {
    BOOL result = NO;
    
    self.blind = YES;
    
    [_statusCellArray       removeAllObjects];
    [_firmwareInfoCellArray removeAllObjects];
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            NSString *portName = [AppDelegate getPortName];

            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :10000];
            port = [SMPort getPort:portName :[AppDelegate getPortSettings] :10000];     // 10000mS!!!
            
            if (port == nil) {
                break;
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                [_statusCellArray addObject:@[@"Online", @"Offline", [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Online", @"Online",  [UIColor blueColor]]];
            }
            
            if (printerStatus.coverOpen == SM_TRUE) {
                [_statusCellArray addObject:@[@"Cover", @"Open",   [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Cover", @"Closed", [UIColor blueColor]]];
            }
            
            if (printerStatus.receiptPaperEmpty == SM_TRUE) {
                [_statusCellArray addObject:@[@"Paper", @"Empty", [UIColor redColor]]];
            }
            else if (printerStatus.receiptPaperNearEmptyInner == SM_TRUE ||
                     printerStatus.receiptPaperNearEmptyOuter == SM_TRUE) {
                [_statusCellArray addObject:@[@"Paper", @"Near Empty", [UIColor orangeColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Paper", @"Ready",      [UIColor blueColor]]];
            }
            
            if ([AppDelegate getCashDrawerOpenActiveHigh] == YES) {
                if (printerStatus.compulsionSwitch == SM_TRUE) {
                    [_statusCellArray addObject:@[@"Cash Drawer", @"Open",   [UIColor redColor]]];
                }
                else {
                    [_statusCellArray addObject:@[@"Cash Drawer", @"Closed", [UIColor blueColor]]];
                }
            }
            else {
                if (printerStatus.compulsionSwitch == SM_TRUE) {
                    [_statusCellArray addObject:@[@"Cash Drawer", @"Closed", [UIColor blueColor]]];
                }
                else {
                    [_statusCellArray addObject:@[@"Cash Drawer", @"Open",   [UIColor redColor]]];
                }
            }
            
            if (printerStatus.overTemp == SM_TRUE) {
                [_statusCellArray addObject:@[@"Head Temperature", @"High",   [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Head Temperature", @"Normal", [UIColor blueColor]]];
            }
            
            if (printerStatus.unrecoverableError == SM_TRUE) {
                [_statusCellArray addObject:@[@"Non Recoverable Error", @"Occurs", [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Non Recoverable Error", @"Ready",  [UIColor blueColor]]];
            }
            
            if (printerStatus.cutterError == SM_TRUE) {
                [_statusCellArray addObject:@[@"Paper Cutter", @"Error", [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Paper Cutter", @"Ready", [UIColor blueColor]]];
            }
            
            if (printerStatus.headThermistorError == SM_TRUE) {
                [_statusCellArray addObject:@[@"Head Thermistor", @"Error",  [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Head Thermistor", @"Normal", [UIColor blueColor]]];
            }
            
            if (printerStatus.voltageError == SM_TRUE) {
                [_statusCellArray addObject:@[@"Voltage", @"Error",  [UIColor redColor]]];
            }
            else {
                [_statusCellArray addObject:@[@"Voltage", @"Normal", [UIColor blueColor]]];
            }
            
            if (printerStatus.etbAvailable == SM_TRUE) {
                [_statusCellArray addObject:@[@"ETB Counter", [NSString stringWithFormat:@"%d", printerStatus.etbCounter], [UIColor blueColor]]];
            }
            
            if (printerStatus.offline == SM_TRUE) {
                [_firmwareInfoCellArray addObject:@[@"Unable to get F/W info. from an error.", @"", [UIColor redColor]]];
                
                result = YES;
                break;
            }
            else {
                NSDictionary *firmwareInformation = [port getFirmwareInformation];
                
                if (firmwareInformation == nil) {
                    break;
                }
                
                [_firmwareInfoCellArray addObject:@[@"Model Name",       [firmwareInformation objectForKey:@"ModelName"],       [UIColor blueColor]]];
                
                [_firmwareInfoCellArray addObject:@[@"Firmware Version", [firmwareInformation objectForKey:@"FirmwareVersion"], [UIColor blueColor]]];
                
                result = YES;
                break;
            }
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
    
    if (result == NO) {
        [self showSimpleAlertWithTitle:@"Fail to Open Port"
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
    }
    
    [self.tableView reloadData];
    
    self.blind = NO;
}

@end
