//
//  BarcodeReaderExtViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

#import <StarIO_Extension/StarIoExtManager.h>

@interface BarcodeReaderExtViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource, StarIoExtManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
