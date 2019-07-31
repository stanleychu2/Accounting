//
//  CommonViewController.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController

@property (nullable, weak, nonatomic) IBOutlet UIView * blindView;

@property (nullable, weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic) BOOL blind;

- (void)appendRefreshButton:(nullable SEL)action;

- (void)showSimpleAlertWithTitle:(nonnull NSString *)title
                         message:(nullable NSString *)message
                     buttonTitle:(nonnull NSString *)buttonTitle
                     buttonStyle:(UIAlertActionStyle)buttonStyle
                      completion:(nullable void (^)(UIAlertController * _Nullable alertController))completion;

- (void)showAlertWithTitle:(nonnull NSString *)title
                   message:(nullable NSString *)message
              buttonTitles:(nonnull NSArray<NSString *> *)buttonTitles
                   handler:(nullable void (^)(int))handler;

@end
