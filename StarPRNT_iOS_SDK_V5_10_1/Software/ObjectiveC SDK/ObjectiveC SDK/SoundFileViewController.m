//
//  SoundFileViewController.m
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "SoundFileViewController.h"

@interface SoundFileViewController ()

@property (nonatomic) NSMutableArray *soundFileArray;

- (void)loadSoundFiles;

@end

@implementation SoundFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _soundFileArray = [NSMutableArray new];
    
    [self loadSoundFiles];
}

- (void)loadSoundFiles {
    NSArray<NSURL *> *documentsDirs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                             inDomains:NSUserDomainMask];
    
    NSURL *documentsDir = [documentsDirs firstObject];
    
    if (documentsDir == nil) {
        return;
    }
    
    NSError *error = nil;
    
    NSArray<NSURL *> *fileUrls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:documentsDir
                                                               includingPropertiesForKeys:nil
                                                                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                                    error:&error];
    
    if (error != nil) {
        _soundFileArray = [@[] mutableCopy];
        return;
    }
    
    for (NSURL *url in fileUrls) {
        if ([[[url absoluteString] pathExtension] isEqualToString:@"wav"] == YES) {
            [_soundFileArray addObject:[url absoluteString]];
        }
    }    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _soundFileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = [[[_soundFileArray objectAtIndex:indexPath.row] lastPathComponent] stringByRemovingPercentEncoding];
                           
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    _didSelectSoundFileHandler([_soundFileArray objectAtIndex:indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
