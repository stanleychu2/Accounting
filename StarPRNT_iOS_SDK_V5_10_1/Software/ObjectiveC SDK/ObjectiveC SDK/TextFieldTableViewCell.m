//
//  TextFieldTableViewCell.m
//  ObjectiveC SDK
//
//  Created by *** on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [_textField setDelegate:self];
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
   
- (BOOL)textField: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string {
    NSString *textValue = _textField.text;
    
    return [_delegate shouldChangeCharactersIn:(int)self.tag textValue:textValue range:range replacementString:string];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (IBAction)didEndOnExit:(id)sender {

}

@end
