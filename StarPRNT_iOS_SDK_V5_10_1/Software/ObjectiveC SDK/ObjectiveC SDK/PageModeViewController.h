//
//  PageModeViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

@interface PageModeViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
