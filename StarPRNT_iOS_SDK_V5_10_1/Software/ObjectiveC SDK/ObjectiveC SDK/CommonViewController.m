//
//  CommonViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)getBlind {
    return self.navigationItem.hidesBackButton;
}

- (void)setBlind:(BOOL)blind {
    if (blind == YES) {
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        _blindView            .hidden = NO;
        _activityIndicatorView.hidden = NO;
        
        [_activityIndicatorView startAnimating];
        
        [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];     // Update View
    }
    else {
        [_activityIndicatorView stopAnimating];
        
        _blindView            .hidden = YES;
        _activityIndicatorView.hidden = YES;
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
        self.navigationItem.hidesBackButton = NO;
        
//      [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];     // Update View(No need)
    }
}

- (void)appendRefreshButton:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                          target:self
                                                                          action:action];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showSimpleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                     buttonTitle:(NSString *)buttonTitle
                     buttonStyle:(UIAlertActionStyle)buttonStyle
                      completion:(void (^)(UIAlertController *alertController))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle
                                                     style:buttonStyle
                                                   handler:nil];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) {
            completion(alertController);
        }
    });
}

- (void)showAlertWithTitle:(nonnull NSString *)title
                   message:(nullable NSString *)message
              buttonTitles:(nonnull NSArray<NSString *> *)buttonTitles
                   handler:(nullable void (^)(int))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    for (NSUInteger i = 0; i < buttonTitles.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles[i]
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        handler((int)i);
                                                    });
                                                }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
