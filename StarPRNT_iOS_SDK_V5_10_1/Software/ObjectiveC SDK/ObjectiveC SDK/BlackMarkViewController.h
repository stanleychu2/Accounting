//
//  BlackMarkViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

@interface BlackMarkViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISwitch *detectionSwitch;

@property (weak, nonatomic) IBOutlet UILabel *detectionLabel;

@end
