//
//  PrinterInfo+Builder.m
//  ObjectiveC SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

#import "PrinterInfo+Builder.h"

@implementation PrinterInfo(Builder)

+ (instancetype)printerInfoWithModelIndex:(ModelIndex)modelIndex {
    PrinterInfo *printerInfo = nil;
    
    switch (modelIndex) {
        case ModelIndexMPOP:
            printerInfo = [self MPOPInfo];
            break;
        case ModelIndexMCPrint2:
            printerInfo = [self MCP20Info];
            break;
        case ModelIndexMCPrint3:
            printerInfo = [self MCP30Info];
            break;
        case ModelIndexFVP10:
            printerInfo = [self FVP10Info];
            break;
        case ModelIndexTSP100:
            printerInfo = [self TSP100Info];
            break;
        case ModelIndexTSP650II:
            printerInfo = [self TSP650IIInfo];
            break;
        case ModelIndexTSP700II:
            printerInfo = [self TSP700IIInfo];
            break;
        case ModelIndexTSP800II:
            printerInfo = [self TSP800IIInfo];
            break;
        case ModelIndexSM_S210I:
        case ModelIndexSM_S220I:
        case ModelIndexSM_S230I:
        case ModelIndexSM_T300I:
        case ModelIndexSM_T400I:
        case ModelIndexSM_S210I_StarPRNT:
        case ModelIndexSM_S220I_StarPRNT:
        case ModelIndexSM_S230I_StarPRNT:
        case ModelIndexSM_T300I_StarPRNT:
        case ModelIndexSM_T400I_StarPRNT:
            printerInfo = [self commonPortablePrinterInfoWithModelIndex:modelIndex];
            break;
        case ModelIndexBSC10:
            printerInfo = [self BSC10Info];
            break;
        case ModelIndexSP700:
            printerInfo = [self SP700Info];
            break;
        case ModelIndexSM_L200:
            printerInfo = [self SM_L200Info];
            break;
        case ModelIndexSM_L300:
            printerInfo = [self SM_L300Info];
            break;
        case ModelIndexNone:
            break;
        default:
            NSAssert(NO, @"Unexpected Model Index");
    }
    
    return printerInfo;
}

+ (PrinterInfo *)MCP20Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"mC-Print2"
                                                        emulation:StarIoExtEmulationStarPRNT
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"MCP20 (STR-001)",
                                                                    @"MCP21 (STR-001)",
                                                                    @"MCP21"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:YES
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:YES
                                           supportCustomerDisplay:YES
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:YES
                                       supportDisconnectBluetooth:NO];
                                

    return printerInfo;
}

+ (PrinterInfo *)MCP30Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"mC-Print3"
                                                        emulation:StarIoExtEmulationStarPRNT
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"MCP31 (STR-001)",
                                                                    @"MCP31"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:YES
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:YES
                                           supportCustomerDisplay:YES
                                             supportMelodySpeaker:YES
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:YES
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

+ (PrinterInfo *)MPOPInfo {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"mPOP"
                                                        emulation:StarIoExtEmulationStarPRNT
                                             cashDrawerOpenActive:NO
                                                     portSettings:@""
                                                   modelNameArray:@[@"POP10"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:YES
                                           supportCustomerDisplay:YES
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:YES
                                       supportDisconnectBluetooth:YES];
    return printerInfo;
}

+ (PrinterInfo *)FVP10Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"FVP10"
                                                        emulation:StarIoExtEmulationStarLine
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"FVP10 (STR_T-001)"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:YES
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:YES
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:YES];
    return printerInfo;
}

+ (PrinterInfo *)TSP100Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"TSP100"
                                                        emulation:StarIoExtEmulationStarGraphic
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"TSP113", @"TSP143"]
                                               supportTextReceipt:NO
                                                      supportUTF8:NO
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:NO
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:YES
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

+ (PrinterInfo *)TSP650IIInfo {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"TSP650II"
                                                        emulation:StarIoExtEmulationStarLine
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"TSP654II (STR_T-001)",
                                                                    @"TSP654 (STR_T-001)",
                                                                    @"TSP651 (STR_T-001)"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:YES
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:YES];
    return printerInfo;
}

+ (PrinterInfo *)TSP700IIInfo {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"TSP700II"
                                                        emulation:StarIoExtEmulationStarLine
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"TSP743II (STR_T-001)",
                                                                    @"TSP743 (STR_T-001)"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:YES
                                                  supportPageMode:NO
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:YES];

    return printerInfo;
}

+ (PrinterInfo *)TSP800IIInfo {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"TSP800II"
                                                        emulation:StarIoExtEmulationStarLine
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray: @[@"TSP847II (STR_T-001)",
                                                                     @"TSP847 (STR_T-001)"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:YES
                                                  supportPageMode:NO
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:YES];
    return printerInfo;
}

+ (PrinterInfo *)commonPortablePrinterInfoWithModelIndex:(ModelIndex)modelIndex {

    StarIoExtEmulation emulation;
    NSString *portSettings = nil;

    switch (modelIndex) {
        case ModelIndexSM_S210I:
        case ModelIndexSM_S220I:
        case ModelIndexSM_S230I:
        case ModelIndexSM_T300I:
        case ModelIndexSM_T400I:
            emulation = StarIoExtEmulationEscPosMobile;
            portSettings = @"mini";
            break;
        case ModelIndexSM_S210I_StarPRNT:
        case ModelIndexSM_S220I_StarPRNT:
        case ModelIndexSM_S230I_StarPRNT:
        case ModelIndexSM_T300I_StarPRNT:
        case ModelIndexSM_T400I_StarPRNT:
            emulation = StarIoExtEmulationStarPRNT;
            portSettings = @"portable";
            break;
        default:
            NSAssert(NO, @"Unexpected model index.");
            return nil;
    }

    NSString *title = nil;
    NSArray<NSString *> *modelNameArray = nil;

    switch (modelIndex) {
        case ModelIndexSM_S210I:
            title = @"SM-S210i";
            modelNameArray = @[@"SM-S210i"];
            break;
        case ModelIndexSM_S220I:
            title = @"SM-S220i";
            modelNameArray = @[@"SM-S220i"];
            break;
        case ModelIndexSM_S230I:
            title = @"SM-S230i";
            modelNameArray = @[@"SM-S230i"];
            break;
        case ModelIndexSM_T300I:
            title = @"SM-T300i/T300";
            modelNameArray = @[@"SM-T300i"];
            break;
        case ModelIndexSM_T400I:
            title = @"SM-T400i";
            modelNameArray = @[@"SM-T400i"];
            break;
        case ModelIndexSM_S210I_StarPRNT:
            title = @"SM-S210i StarPRNT";
            modelNameArray = @[@"SM-S210i StarPRNT"];
            break;
        case ModelIndexSM_S220I_StarPRNT:
            title = @"SM-S220i StarPRNT";
            modelNameArray = @[@"SM-S220i StarPRNT"];
            break;
        case ModelIndexSM_S230I_StarPRNT:
            title = @"SM-S230i StarPRNT";
            modelNameArray = @[@"SM-S230i StarPRNT"];
            break;
        case ModelIndexSM_T300I_StarPRNT:
            title = @"SM-T300i/T300 StarPRNT";
            modelNameArray = @[@"SM-T300i StarPRNT"];
            break;
        case ModelIndexSM_T400I_StarPRNT:
            title = @"SM-T400i StarPRNT";
            modelNameArray = @[@"SM-T400i StarPRNT"];
            break;
        default:
            NSAssert(NO, @"Unexpected model index.");
    }
    
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:title
                                                        emulation:emulation
                                             cashDrawerOpenActive:NO
                                                     portSettings:portSettings
                                                   modelNameArray:modelNameArray
                                               supportTextReceipt:YES
                                                      supportUTF8:NO
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:NO
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

+ (PrinterInfo *)BSC10Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"BSC10"
                                                        emulation:StarIoExtEmulationEscPos
                                             cashDrawerOpenActive:YES
                                                     portSettings:@"escpos"
                                                   modelNameArray:@[@"BSC10"]
                                               supportTextReceipt:YES
                                                      supportUTF8:NO
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:NO
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

+ (PrinterInfo *)SP700Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"SP700"
                                                        emulation:StarIoExtEmulationStarDotImpact
                                             cashDrawerOpenActive:YES
                                                     portSettings:@""
                                                   modelNameArray:@[@"SP712 (STR-001)",
                                                                    @"SP717 (STR-001)",
                                                                    @"SP742 (STR-001)",
                                                                    @"SP747 (STR-001)"]
                                               supportTextReceipt:YES
                                                      supportUTF8:YES
                                             supportRasterReceipt:NO
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:YES
                                                  supportPageMode:NO
                                                supportCashDrawer:YES
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:NO
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:YES];
    return printerInfo;
}

+ (PrinterInfo *)SM_L200Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"SM-L200"
                                                        emulation:StarIoExtEmulationStarPRNT
                                             cashDrawerOpenActive:NO
                                                     portSettings:@"Portable"
                                                   modelNameArray:@[@"SM-L200"]
                                               supportTextReceipt:YES
                                                      supportUTF8:NO
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:NO
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

+ (PrinterInfo *)SM_L300Info {
    PrinterInfo *printerInfo = [[PrinterInfo alloc] initWithTitle:@"SM-L300"
                                                        emulation:StarIoExtEmulationStarPRNTL
                                             cashDrawerOpenActive:NO
                                                     portSettings:@"Portable"
                                                   modelNameArray:@[@"SM-L300"]
                                               supportTextReceipt:YES
                                                      supportUTF8:NO
                                             supportRasterReceipt:YES
                                                       supportCJK:NO
                                                 supportBlackMark:YES
                                        supportBlackMarkDetection:NO
                                                  supportPageMode:YES
                                                supportCashDrawer:NO
                                             supportBarcodeReader:NO
                                           supportCustomerDisplay:NO
                                             supportMelodySpeaker:NO
                                               supportAllReceipts:YES
                                       supportProductSerialNumber:NO
                                       supportDisconnectBluetooth:NO];
    return printerInfo;
}

@end
