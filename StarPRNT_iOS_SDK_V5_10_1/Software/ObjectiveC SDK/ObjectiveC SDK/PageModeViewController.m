//
//  PageModeViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "PageModeViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "PrinterFunctions.h"

#import "ILocalizeReceipts.h"

#import "GlobalQueueManager.h"

@interface PageModeViewController ()

@end

@implementation PageModeViewController

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
    
    return 1;
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
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        switch (indexPath.row) {
            default :
//          case 0  :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Label (Rotation0)",   localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 1 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Label (Rotation90)",  localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 2 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Label (Rotation180)", localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 3 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Label (Rotation270)", localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
        }
        
        cell.detailTextLabel.text = @"";
        
        cell      .textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Like a StarIO-SDK Sample";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSData *commands;
    
    StarIoExtEmulation emulation = [AppDelegate getEmulation];
    
    ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
    
    int width = [AppDelegate getSelectedPaperSize];
    
    int height = 30 * 8;     // 30mm!!!
    
    CGRect                     rect;
    SCBBitmapConverterRotation rotation;
    
    switch (indexPath.row) {
        default :
//      case 0  :
            rect = CGRectMake(0, 0, width, height);
            
            rotation = SCBBitmapConverterRotationNormal;
            break;
        case 1 :
////        rect = CGRectMake(0, 0, width,  height);
//          rect = CGRectMake(0, 0, height, width);
            rect = CGRectMake(0, 0, width,  width);
            
            rotation = SCBBitmapConverterRotationRight90;
            break;
        case 2 :
            rect = CGRectMake(0, 0, width, height);
            
            rotation = SCBBitmapConverterRotationRotate180;
            break;
        case 3 :
//          rect = CGRectMake(0, 0, width,  height);
            rect = CGRectMake(0, 0, height, width);
            
            rotation = SCBBitmapConverterRotationLeft90;
            break;
    }
    
    commands = [PrinterFunctions createTextPageModeData:emulation localizeReceipts:localizeReceipts rect:rect rotation:rotation utf8:NO];
    
    self.blind = YES;
    
    NSString  *portName     = [AppDelegate getPortName];
    NSString  *portSettings = [AppDelegate getPortSettings];
    NSInteger  timeout      = 10000;                             // 10000mS!!!
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
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
    });
}

@end
