//
//  AllReceiptsViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import "SwitchTableViewCell.h"

@interface AllReceiptsViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource, SwitchTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
