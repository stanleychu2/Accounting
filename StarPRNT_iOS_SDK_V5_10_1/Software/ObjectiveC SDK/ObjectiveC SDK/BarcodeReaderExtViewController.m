//
//  BarcodeReaderExtViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "BarcodeReaderExtViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "GlobalQueueManager.h"

typedef NS_ENUM(NSInteger, CellParamIndex) {
    CellParamIndexBarcodeData = 0
};

@interface BarcodeReaderExtViewController ()

@property (nonatomic) NSMutableArray *cellArray;

@property (nonatomic) StarIoExtManager *starIoExtManager;

- (void)applicationWillResignActive;
- (void)applicationDidBecomeActive;

- (void)refreshBarcodeReader;

- (void)beginAnimationCommantLabel;

@end

@implementation BarcodeReaderExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _commentLabel.text = @"";
    
    _commentLabel.adjustsFontSizeToFitWidth = YES;
    
    [self appendRefreshButton:@selector(refreshBarcodeReader)];
    
    _cellArray = [[NSMutableArray alloc] init];
    
    _starIoExtManager = [[StarIoExtManager alloc] initWithType:StarIoExtManagerTypeOnlyBarcodeReader
                                                      portName:[AppDelegate getPortName]
                                                  portSettings:[AppDelegate getPortSettings]
                                               ioTimeoutMillis:10000];                                   // 10000mS!!!
    
    _starIoExtManager.cashDrawerOpenActiveHigh = [AppDelegate getCashDrawerOpenActiveHigh];
    
    _starIoExtManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)  name:UIApplicationDidBecomeActiveNotification  object:nil];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.blind = YES;
            
            [self->_starIoExtManager disconnect];
            
            if ([self->_starIoExtManager connect] == NO) {
                [self showSimpleAlertWithTitle:@"Fail to Open Port."
                                       message:@""
                                   buttonTitle:@"OK"
                                   buttonStyle:UIAlertActionStyleCancel
                                    completion:^(UIAlertController *alertController) {
                                        self->_commentLabel.text = [NSString stringWithFormat:@"%@\n%@",
                                                                    @"Check the device. (Power and Bluetooth pairing)",
                                                                    @"Then touch up the Refresh button."];
                                        
                                        self->_commentLabel.textColor = [UIColor redColor];
                                        
                                        [self beginAnimationCommantLabel];
                                    }];
            }
            
            [self->_tableView reloadData];
            
            self.blind = NO;
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self->_starIoExtManager disconnect];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification  object:nil];
}

- (void)applicationDidBecomeActive {
    [self beginAnimationCommantLabel];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshBarcodeReader];
        });
    });
}

- (void)applicationWillResignActive {
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        [self->_starIoExtManager disconnect];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return _cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cellParam = _cellArray[indexPath.row];
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        cell.      textLabel.text = cellParam[CellParamIndexBarcodeData];
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Contents";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshBarcodeReader {
    self.blind = YES;
    
    [_cellArray removeAllObjects];
    
    [_starIoExtManager disconnect];
    
    if ([_starIoExtManager connect] == NO) {
        [self showSimpleAlertWithTitle:@"Fail to Open Port."
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:^(UIAlertController *alertController) {
                                self->_commentLabel.text = [NSString stringWithFormat:@"%@\n%@",
                                                            @"Check the device. (Power and Bluetooth pairing)",
                                                            @"Then touch up the Refresh button."];
                                
                                self->_commentLabel.textColor = [UIColor redColor];
                                
                                [self beginAnimationCommantLabel];
                            }];
    }

    
    [_tableView reloadData];
    
    self.blind = NO;
}

- (void)didBarcodeDataReceive:(StarIoExtManager *)manager data:(NSData *)data {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    if (str == nil) {
        return;
    }
    
    NSMutableArray *lines = [NSMutableArray new];
    
    [str enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
        [lines addObject:line];
    }];
    
    for (NSString *bcrStr in lines) {
        if (_cellArray.count > 30) {     // Max.30Line
            [_cellArray removeObjectAtIndex:0];
            
            [self.tableView reloadData];
        }
        
        [_cellArray addObject:@[bcrStr]];
    }
    
    [_tableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_cellArray.count - 1 inSection:0];

    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didBarcodeReaderImpossible:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Barcode Reader Impossible.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didBarcodeReaderConnect:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Barcode Reader Connect.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didBarcodeReaderDisconnect:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Barcode Reader Disconnect.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didAccessoryConnectSuccess:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Success.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didAccessoryConnectFailure:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Failure.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didAccessoryDisconnect:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Disconnect.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didStatusUpdate:(StarIoExtManager *)manager status:(NSString *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
//  _commentLabel.text = status;
//
//  _commentLabel.textColor = [UIColor greenColor];
//
//  [self beginAnimationCommantLabel];
}

- (void)beginAnimationCommantLabel {
    [UIView beginAnimations:nil context:nil];
    
    _commentLabel.alpha = 0.0;
    
    [UIView setAnimationDelay             :0.0];                            // 0mS!!!
    [UIView setAnimationDuration          :0.6];                            // 600mS!!!
    [UIView setAnimationRepeatCount       :UINT32_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve             :UIViewAnimationCurveEaseIn];
    
    _commentLabel.alpha = 1.0;
    
    [UIView commitAnimations];
}

@end
