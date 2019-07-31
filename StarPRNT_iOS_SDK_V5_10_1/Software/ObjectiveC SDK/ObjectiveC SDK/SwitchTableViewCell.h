//
//  SwitchTableViewCell.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchTableViewCellDelegate <NSObject>

@required

- (void)tableView:(UITableView *)tableView valueChangedStateSwitch:(BOOL)on indexPath:(NSIndexPath *)indexPath;

@end

@interface SwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;

@property (weak, nonatomic) id<SwitchTableViewCellDelegate> delegate;

- (IBAction)valueChangedStateSwitch:(id)sender;

@end
