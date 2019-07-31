//
//  TextFieldTableViewCell.h
//  ObjectiveC SDK
//
//  Created by *** on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldTableViewCellDelegate <NSObject>

@required

- (BOOL)shouldChangeCharactersIn:(int) tag textValue:(NSString *)textValue range:(NSRange) range replacementString:(NSString *) replacementString;
//- (void)tableView:(UITableView *)tableView shouldChangeCharactersIn:(BOOL)on indexPath:(NSIndexPath *)indexPath;

@end

@interface TextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) id<TextFieldTableViewCellDelegate> delegate;

//- (BOOL)textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string;

- (IBAction)didEndOnExit:(id)sender;

@end
