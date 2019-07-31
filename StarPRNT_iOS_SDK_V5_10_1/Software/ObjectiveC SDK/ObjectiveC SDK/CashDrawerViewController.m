//
//  CashDrawerViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CashDrawerViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "CashDrawerFunctions.h"

#import "GlobalQueueManager.h"

@interface CashDrawerViewController ()

@end

@implementation CashDrawerViewController

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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 4;
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
            default :
//          case 0  :
                cell.textLabel.text = @"Channel1 (Check condition.)";
                break;
            case 1 :
                cell.textLabel.text = @"Channel1 (Do not check condition.)";
                break;
            case 2 :
                cell.textLabel.text = @"Channel2 (Check condition.)";
                break;
            case 3 :
                cell.textLabel.text = @"Channel2 (Do not check condition.)";
                break;
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
        title = @"Like a StarIO-SDK Sample";
    }
    else {
        title = @"StarIoExtManager Sample";
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSData *commands;
        
        switch (indexPath.row) {
            default :
//          case 0  :
//          case 1  :
                commands = [CashDrawerFunctions createData:[AppDelegate getEmulation] channel:SCBPeripheralChannelNo1];
                break;
            case 2 :
            case 3 :
                commands = [CashDrawerFunctions createData:[AppDelegate getEmulation] channel:SCBPeripheralChannelNo2];
                break;
        }
        
        self.blind = YES;
        
        NSString  *portName     = [AppDelegate getPortName];
        NSString  *portSettings = [AppDelegate getPortSettings];
        NSInteger  timeout      = 10000;                             // 10000mS!!!

        dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
            switch (indexPath.row) {
                default : {
                    //          case 0  :
                    //          case 2  :
                    [Communication sendCommands:commands
                                       portName:portName
                                   portSettings:portSettings
                                        timeout:timeout
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
                    
                    break;
                }
                case 1 :
                case 3 :
                    [Communication sendCommandsDoNotCheckCondition:commands
                                                          portName:portName
                                                      portSettings:portSettings
                                                           timeout:timeout
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
                    
                    break;
            }
        });
        

    }
    else {
        [AppDelegate setSelectedIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"PushCashDrawerExtViewController" sender:nil];
    }
}

@end
