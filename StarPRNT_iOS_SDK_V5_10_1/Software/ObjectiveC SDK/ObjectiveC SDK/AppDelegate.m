//
//  AppDelegate.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic) LanguageIndex selectedLanguage;

- (void)loadParam;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:1.0];     // 1000mS!!!
    
    _selectedIndex     = 0;
    _selectedLanguage  = LanguageIndexEnglish;
    
    _settingManager = [SettingManager new];
    
    [self loadParam];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loadParam {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [delegate.settingManager load];
}

+ (NSString *)getPortName {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].portName;
}

+ (void)setPortName:(NSString *)portName {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].portName = portName;
    [delegate.settingManager save];
}

+ (NSString *)getPortSettings {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].portSettings;
}

+ (void)setPortSettings:(NSString *)portSettings {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].portSettings = portSettings;
    [delegate.settingManager save];
}

+ (NSString *)getModelName {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].modelName;
}

+ (void)setModelName:(NSString *)modelName {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    delegate.settingManager.settings[0].modelName = modelName;
    [delegate.settingManager save];
}

+ (NSString *)getMacAddress {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].macAddress;
}

+ (void)setMacAddress:(NSString *)macAddress {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].macAddress = macAddress;
    [delegate.settingManager save];
}

+ (StarIoExtEmulation)getEmulation {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].emulation;
}

+ (void)setEmulation:(StarIoExtEmulation)emulation {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].emulation = emulation;
    [delegate.settingManager save];
}

+ (BOOL)getCashDrawerOpenActiveHigh {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].cashDrawerOpenActiveHigh;
}

+ (void)setCashDrawerOpenActiveHigh:(BOOL)activeHigh {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].cashDrawerOpenActiveHigh = activeHigh;
    [delegate.settingManager save];
}

+ (NSInteger)getAllReceiptsSettings {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].allReceiptsSettings;
}

+ (void)setAllReceiptsSettings:(NSInteger)allReceiptsSettings {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].allReceiptsSettings = allReceiptsSettings;
    [delegate.settingManager save];
}

+ (NSInteger)getSelectedIndex {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.selectedIndex;
}

+ (void)setSelectedIndex:(NSInteger)index {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.selectedIndex = index;
}

+ (LanguageIndex)getSelectedLanguage {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.selectedLanguage;
}

+ (void)setSelectedLanguage:(LanguageIndex)index {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.selectedLanguage = index;
}

+ (PaperSizeIndex)getSelectedPaperSize {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].selectedPaperSize;
}

+ (void)setSelectedPaperSize:(PaperSizeIndex)index {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].selectedPaperSize = index;
    [delegate.settingManager save];
}

+ (ModelIndex)getSelectedModelIndex {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    return delegate.settingManager.settings[0].selectedModelIndex;
}

+ (void)setSelectedModelIndex:(ModelIndex)modelIndex {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    delegate.settingManager.settings[0].selectedModelIndex = modelIndex;
    [delegate.settingManager save];
}

@end
