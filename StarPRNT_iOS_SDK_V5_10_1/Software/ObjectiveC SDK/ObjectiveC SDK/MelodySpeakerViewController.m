//
//  MelodySpeakerViewController.m
//  ObjectiveC SDK
//
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

#import "MelodySpeakerViewController.h"
#import "MelodySpeakerFunctions.h"

#import "SoundFileViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import <StarIO_Extension/StarIoExt.h>

#import <StarIO/SMPort.h>

#import <StarIO_Extension/SMSoundSetting.h>

typedef NS_ENUM(NSInteger, VolumeSetting) {
    VolumeSettingDefault = 0,
    VolumeSettingOff,
    VolumeSettingMin,
    VolumeSettingMax,
    VolumeSettingManual
};

static const NSInteger DEFAULT_SOUND_STORAGE_AREA = -1;

@interface MelodySpeakerViewController ()

@property (nonatomic) SMCBSoundStorageArea selectedSoundStorageArea;

@property (nonatomic) NSInteger selectedSoundNumber;

@property (nonatomic) NSString *selectedSoundFilePath;

@property (nonatomic) VolumeSetting selectedVolumeSetting;

@property (nonatomic) NSUInteger selectedVolume;

@property (nonatomic) StarIoExtMelodySpeakerModel melodySpeakerModel;

@property (nonatomic) NSDictionary *volumeTitleDictionary;

- (void)reloadView;

- (void)sendCommandsToPrinter:(NSInteger)segmentIndex;

@end

@implementation MelodySpeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ModelIndex modelIndex = AppDelegate.getSelectedModelIndex;
    
    PrinterInfo *printerInfo = [ModelCapability printerInfoAtModelIndex:modelIndex];
    
    if ([printerInfo.title isEqualToString:@"mC-Print3"]) {
        _melodySpeakerModel = StarIoExtMelodySpeakerModelMCS10;
    } else {
        _melodySpeakerModel = StarIoExtMelodySpeakerModelFVP10;
    }
    
    _selectedSoundStorageArea = DEFAULT_SOUND_STORAGE_AREA;
    
    _selectedVolume = 12;
    
    _volumeTitleDictionary = @{@(VolumeSettingDefault):@"Default",
                               @(VolumeSettingOff)    :@"Off",
                               @(VolumeSettingMin)    :@"Min",
                               @(VolumeSettingMax)    :@"Max",
                               @(VolumeSettingManual) :@"Manual"};
    
    [_soundFileButton setTitle:@"(Unselected)"
                      forState:UIControlStateNormal];
    
    [_volumeLabel setText:[NSString stringWithFormat:@"%lu", _selectedVolume]];
    
    _playButton.backgroundColor   = UIColor.cyanColor;
    _playButton.layer.borderColor = UIColor.blueColor.CGColor;
    _playButton.layer.borderWidth = 1.0;
    
    [_soundStorageAreaButton setTitle:@"Default"
                             forState:UIControlStateNormal];
    
    switch (_melodySpeakerModel) {
        default:
        case StarIoExtMelodySpeakerModelMCS10:
            _soundNumberField.text = @"0";
            break;
        case StarIoExtMelodySpeakerModelFVP10:
            _soundNumberField.text = @"1";
            
            [_volumeSettingButton setEnabled:NO];
            break;
    }
    
    UIToolbar *toolbar = [UIToolbar new];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(closeKeyboard)];
    
    toolbar.items = @[space, done];
    [toolbar sizeToFit];

    _soundNumberField.inputAccessoryView = toolbar;
    
    [self reloadView];
}

- (void)closeKeyboard {
    [_soundNumberField endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changedSoundType:(id)sender {
    [self reloadView];
}

- (IBAction)changedVolume:(id)sender {
    NSUInteger newValue = (NSUInteger)_volumeSlider.value;
    
    _selectedVolume = newValue;
    
    _volumeLabel.text = [NSString stringWithFormat:@"%lu", newValue];
}

- (void)reloadView {
    switch (_soundTypeSegment.selectedSegmentIndex) {
        case 0:
            [_soundStorageAreaView setHidden:NO];
            [_soundFileView setHidden:YES];
            break;
        case 1:
            [_soundStorageAreaView setHidden:YES];
            [_soundFileView setHidden:NO];
            break;
    }
}

- (IBAction)showAreaSelectAlert:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select sound storage area."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Defalut"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.soundStorageAreaButton setTitle:@"Defalut"
                                                                             forState:UIControlStateNormal];
                                                
                                                self.selectedSoundStorageArea = DEFAULT_SOUND_STORAGE_AREA;
                                                
                                                [self.soundNumberField setEnabled:NO];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Area1"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.soundStorageAreaButton setTitle:@"Area1"
                                                                             forState:UIControlStateNormal];
                                                
                                                self.selectedSoundStorageArea = SMCBSoundStorageArea1;
                                                
                                                [self.soundNumberField setEnabled:YES];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Area2"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.soundStorageAreaButton setTitle:@"Area2"
                                                                             forState:UIControlStateNormal];
                                                
                                                self.selectedSoundStorageArea = SMCBSoundStorageArea2;
                                                
                                                [self.soundNumberField setEnabled:YES];
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)showVolumeSettingAlert:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select volume."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray *volumeSettingArray = @[@(VolumeSettingDefault),
                                    @(VolumeSettingOff),
                                    @(VolumeSettingMin),
                                    @(VolumeSettingMax),
                                    @(VolumeSettingManual)];
    
    for (NSNumber *volume in volumeSettingArray) {
        NSString *title = [_volumeTitleDictionary objectForKey:volume];
        
        [alert addAction:[UIAlertAction actionWithTitle:title
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    self.selectedVolumeSetting = [volume integerValue];
                                                    
                                                    [self.volumeSettingButton setTitle:title
                                                                              forState:UIControlStateNormal];
                                                    
                                                    [self.volumeSlider setHidden:self.selectedVolumeSetting != VolumeSettingManual];
                                                    [self.volumeLabel  setHidden:self.selectedVolumeSetting != VolumeSettingManual];
                                                }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SoundFileViewController *destination = segue.destinationViewController;
    
    [destination setDidSelectSoundFileHandler:^(NSString *filePath) {
        self.selectedSoundFilePath = filePath;
        
        NSString *fileName = [[filePath lastPathComponent] stringByRemovingPercentEncoding];
        
        [self.soundFileButton setTitle:fileName
                              forState:UIControlStateNormal];
    }];
}

- (IBAction)playSound {
    [_soundNumberField resignFirstResponder];
    
    [self sendCommandsToPrinter:_soundTypeSegment.selectedSegmentIndex];
}

- (void)sendCommandsToPrinter:(NSInteger)segmentIndex {
    if (segmentIndex == 1 && _selectedSoundFilePath == nil) {  // Received Data
        [self showSimpleAlertWithTitle:@"Sound file is not selected."
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleDefault
                            completion:nil];
        return;
    }
    
    self.blind = YES;
    
    SMPort *port = nil;
    
    @try {
        NSString *portName = [AppDelegate getPortName];

        // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
        // (Refer Readme for details)
//      port = [SMPort getPort:portName :@"(your original portSettings);l1000)" :10000];
        port = [SMPort getPort:portName :[AppDelegate getPortSettings] :10000];     // 10000mS!!!
        
        if (port != nil) {
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            NSOperatingSystemVersion version = {11, 0, 0};
            BOOL isOSVer11OrLater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
            if ((isOSVer11OrLater) && ([portName.uppercaseString hasPrefix:@"BT:"])) {
                [NSThread sleepForTimeInterval:0.2];
            }
            
            if (_melodySpeakerModel == StarIoExtMelodySpeakerModelMCS10) {
                NSError *error = nil;
                
                ISCPConnectParser *parser = [StarIoExt createMelodySpeakerConnectParser:_melodySpeakerModel
                                                                                  error:&error];
                
                [Communication parseDoNotCheckCondition:parser
                                                   port:port
                                      completionHandler:^(BOOL result, NSString *title, NSString *message) {
                                          if (result == YES) {
                                              if (parser.connect == YES) {
                                                  NSData *commands = nil;
                                                  
                                                  if (segmentIndex == 0) {    // Registered Sound
                                                      commands = [self createRegisteredSoundCommand];
                                                  } else {                    // Received Data
                                                      commands = [self createReceivedDataCommand];
                                                  }
                                                  
                                                  if (commands == nil) {
                                                      [self releasePort:port];
                                                      return;
                                                  }
                                                  
                                                  [Communication sendCommands:commands
                                                                         port:port
                                                            completionHandler:^(BOOL result, NSString *title, NSString *message) {
                                                                [self showSimpleAlertWithTitle:title
                                                                                       message:message
                                                                                   buttonTitle:@"OK"
                                                                                   buttonStyle:UIAlertActionStyleCancel
                                                                                    completion:nil];
                                                                
                                                                [self releasePort:port];
                                                            }];
                                              }
                                              else {
                                                  [self showSimpleAlertWithTitle:@"Failure"
                                                                         message:@"MelodySpeaker Disconnect."
                                                                     buttonTitle:@"OK"
                                                                     buttonStyle:UIAlertActionStyleCancel
                                                                      completion:nil];
                                                  
                                                  [self releasePort:port];
                                              }
                                          }
                                          else {
                                              [self showSimpleAlertWithTitle:@"Failure"
                                                                     message:@"Printer Impossible."
                                                                 buttonTitle:@"OK"
                                                                 buttonStyle:UIAlertActionStyleCancel
                                                                  completion:nil];
                                              
                                              [self releasePort:port];
                                          }
                                      }];
            } else {
                NSData *commands = nil;
                
                if (segmentIndex == 0) {    // Registered Sound
                    commands = [self createRegisteredSoundCommand];
                } else {                    // Received Data
                    commands = [self createReceivedDataCommand];
                }
                
                if (commands == nil) {
                    [self releasePort:port];
                    return;
                }
                
                [Communication sendCommands:commands
                                       port:port
                          completionHandler:^(BOOL result, NSString *title, NSString *message) {
                              [self showSimpleAlertWithTitle:title
                                                     message:message
                                                 buttonTitle:@"OK"
                                                 buttonStyle:UIAlertActionStyleCancel
                                                  completion:nil];
                              
                              [self releasePort:port];
                          }];
            }
        } else {
            [self showSimpleAlertWithTitle:@"Fail to Open Port"
                                   message:@""
                               buttonTitle:@"OK"
                               buttonStyle:UIAlertActionStyleCancel
                                completion:nil];
            
            [self releasePort:port];
        }
    }
    @catch (PortException *exc) {
        [self showSimpleAlertWithTitle:@"Fail to Open Port"
                               message:@""
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        
        [self releasePort:port];
    }
}

- (void)releasePort:(SMPort *)port {    
    if (port != nil) {
        [SMPort releasePort:port];
        
        port = nil;
    }
    
    self.blind = NO;
}

- (NSData *)createRegisteredSoundCommand {
    BOOL specifySound;
    SMCBSoundStorageArea soundStorageArea = _selectedSoundStorageArea;
    
    specifySound = soundStorageArea != DEFAULT_SOUND_STORAGE_AREA;
    
    NSError *numberError = nil;
    
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"(^[+|-]?[0-9]+$)"
                                                                            options:0
                                                                              error:&numberError];
    if (regexp == nil) {
        return nil;
    }
    
    NSRange rangeOfFirstMatch = [regexp rangeOfFirstMatchInString:_soundNumberField.text
                                                          options:0
                                                            range:NSMakeRange(0, _soundNumberField.text.length)];
    
    if (NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        [self showSimpleAlertWithTitle:[NSString stringWithFormat:@"Sound Number \"%@\" is an invalid value.", _soundNumberField.text]
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        return nil;
    }
    
    NSInteger soundNumber = [_soundNumberField.text intValue];
    
    BOOL specifyVolume = NO;
    NSInteger volume = 0;
    
    switch (_selectedVolumeSetting) {
        case VolumeSettingDefault:
            // Not specify volume.
            break;
        case VolumeSettingOff:
            volume = SMSoundSettingVolumeOff;
            specifyVolume = YES;
            break;
        case VolumeSettingMin:
            volume = SMSoundSettingVolumeMin;
            specifyVolume = YES;
            break;
        case VolumeSettingMax:
            volume = SMSoundSettingVolumeMax;
            specifyVolume = YES;
            break;
        case VolumeSettingManual:
            volume = _selectedVolume;
            specifyVolume = YES;
            break;
    }
    
    NSError *commandError = nil;
    
    NSData *data = [MelodySpeakerFunctions createPlayingRegisteredSound:_melodySpeakerModel
                                                           specifySound:specifySound
                                                       soundStorageArea:soundStorageArea
                                                            soundNumber:soundNumber
                                                          specifyVolume:specifyVolume
                                                                 volume:volume
                                                                  error:&commandError];

    if (commandError != nil) {
        [self showSimpleAlertWithTitle:commandError.localizedDescription
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        return nil;
    }
    
    return data;
}

- (NSData *)createReceivedDataCommand {
    NSString *filePath = _selectedSoundFilePath;
    
    BOOL specifyVolume = NO;
    NSInteger volume = 0;
    
    switch (_selectedVolumeSetting) {
        case VolumeSettingDefault:
            // Not specify volume.
            break;
        case VolumeSettingOff:
            volume = SMSoundSettingVolumeOff;
            specifyVolume = YES;
            break;
        case VolumeSettingMin:
            volume = SMSoundSettingVolumeMin;
            specifyVolume = YES;
            break;
        case VolumeSettingMax:
            volume = SMSoundSettingVolumeMax;
            specifyVolume = YES;
            break;
        case VolumeSettingManual:
            volume = _selectedVolume;
            specifyVolume = YES;
            break;
    }
    
    NSError *error = nil;
    
    NSData *data = [MelodySpeakerFunctions createPlayingReceivedData:_melodySpeakerModel
                                                            filePath:filePath
                                                       specifyVolume:specifyVolume
                                                              volume:volume
                                                               error:&error];
    
    if (error != nil) {
        [self showSimpleAlertWithTitle:error.localizedDescription
                               message:nil
                           buttonTitle:@"OK"
                           buttonStyle:UIAlertActionStyleCancel
                            completion:nil];
        return nil;
    }
    
    return data;
}

@end
