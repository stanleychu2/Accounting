//
//  BluetoothSettingViewController.h
//  ObjectiveC SDK
//
//  Created by *** on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import "SwitchTableViewCell.h"

#import "TextFieldTableViewCell.h"

@interface BluetoothSettingViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource, SwitchTableViewCellDelegate, TextFieldTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@end
