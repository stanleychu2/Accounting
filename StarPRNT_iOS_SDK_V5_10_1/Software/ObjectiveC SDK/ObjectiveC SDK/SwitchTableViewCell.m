//
//  SwitchTableViewCell.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)valueChangedStateSwitch:(id)sender {
    while ([sender isKindOfClass:[UITableView class]] == NO) {
        sender = [sender superview];
    }
    
    NSIndexPath *indexPath = [((UITableView *) sender) indexPathForCell:self];
    
    [_delegate tableView:sender valueChangedStateSwitch:_stateSwitch.on indexPath:indexPath];
}

@end
