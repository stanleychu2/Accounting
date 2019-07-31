//
//  CombinationViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CombinationViewController.h"

#import "AppDelegate.h"

#import "ILocalizeReceipts.h"

@interface CombinationViewController ()

@end

@implementation CombinationViewController

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
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage]
                                                                         paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        switch (indexPath.row) {
            default :
//          case 0  :
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
        }
        
        cell.detailTextLabel.text = @"";
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"StarIoExtManager Sample";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [AppDelegate setSelectedIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"PushCombinationExtViewController" sender:nil];
}

@end
