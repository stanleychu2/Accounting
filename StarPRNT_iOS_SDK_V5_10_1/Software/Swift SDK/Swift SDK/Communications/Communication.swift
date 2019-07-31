//
//  Communication.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

typealias SendCompletionHandler = (_ result: Bool, _ title: String, _ message: String) -> Void

typealias SendCompletionHandlerWithNullableString = (_ result: Bool, _ title: String?, _ message: String?) -> Void

typealias RequestStatusCompletionHandler = (_ result: Bool, _ title: String, _ message: String, _ connect: Bool) -> Void

class Communication {
    static func sendCommands(_ commands: Data!, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < UInt32(commands.count) {
                let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commands.count) {
                break
            }
            
            port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (EndCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(_ commands: Data!, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (GetParsedStatus)"
//              break
//          }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < UInt32(commands.count) {
                let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commands.count) {
                break
            }
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (GetParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    class func parseDoNotCheckCondition(_ parser: ISCPParser, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let commands: Data = parser.createSendCommands()! as Data
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (GetParsedStatus)"
//              break
//          }
            
            var startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < UInt32(commands.count) {
                let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commands.count) {
                break
            }
            
            startDate = Date()
            
            var receivedData: [UInt8] = [UInt8]()
            
            while true {
                var buffer: [UInt8] = [UInt8](repeating: 0, count: 1024 + 8)
                
                if Date().timeIntervalSince(startDate) >= 1.0 {     // 1000mS!!!
                    title   = "Printer Error"
                    message = "Read port timed out"
                    break
                }
                
                Thread.sleep(forTimeInterval: 0.01)     // Break time.
                
                let readLength: UInt32 = port.read(&buffer, 0, 1024, &error)
                
                if readLength == 0 {
                    continue;
                }
                
                let resizedBuffer = buffer.prefix(Int(readLength)).map{ $0 }
                receivedData.append(contentsOf: resizedBuffer)
                
                var receivedDataSize = Int32(receivedData.count)
                
                if parser.completionHandler!(&receivedData, &receivedDataSize) == .success {
                    title   = "Send Commands"
                    message = "Success"
                    
                    result = true
                    break
                }
            }
            
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    static func sendCommands(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          guard let port: SMPort = SMPort.getPort(portName, "(your original portSettings);l1000)", timeout) else {
            guard let port: SMPort = SMPort.getPort(portName, portSettings, timeout) else {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < UInt32(commands.count) {
                let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commands.count) {
                break
            }
            
            port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (EndCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          guard let port: SMPort = SMPort.getPort(portName, "(your original portSettings);l1000)", timeout) else {
            guard let port: SMPort = SMPort.getPort(portName, portSettings, timeout) else {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (GetParsedStatus)"
//              break
//          }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < UInt32(commands.count) {
                let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commands.count) {
                break
            }
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (GetParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    static func sendCommandsForPrintReDirection(_ commands: Data!,
                                                timeout: UInt32,
                                                completionHandler: SendCompletionHandler?) {
        var result: Bool = false
        
        var message: String = ""
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        var resultString: String = ""
        
        for i in 0..<AppDelegate.settingManager.settings.count {
            let setting = AppDelegate.settingManager.settings[i]!
            
            var error: NSError? = nil

            while true {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              guard let port: SMPort = SMPort.getPort(setting.portName,
//                                                      "(your original portSettings);l1000)",
//                                                      timeout) else {
                guard let port: SMPort = SMPort.getPort(setting.portName,
                                                        setting.portSettings,
                                                        timeout) else {
                    message = "Fail to Open Port"
                    break
                }
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), setting.portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                port.beginCheckedBlock(&printerStatus, 2, &error)
                
                if error != nil {
                    break
                }
                
                if printerStatus.offline == sm_true {
                    message = "Printer is offline (BeginCheckedBlock)"
                    break
                }
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    let written: UInt32 = port.write(commandsArray, total, UInt32(commands.count) - total, &error)
                    
                    if error != nil {
                        break
                    }
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        message = "Write port timed out"
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                
                port.endCheckedBlock(&printerStatus, 2, &error)
                
                if error != nil {
                    break
                }
                
                if printerStatus.offline == sm_true {
                    message = "Printer is offline (EndCheckedBlock)"
                    break
                }
                
                message = "Success"
                
                result = true
                break
            }
            
            if let error = error {
                message = error.localizedDescription
            }
            
            let categoryTitle = (i == 0) ? "[Destination]" : "[Backup]"
            if i > 0 {
                resultString += "\n"
            }
            resultString += """
            \(categoryTitle)
            Port Name: \(setting.portName)
            \(message)
            
            """
            
            if result == true {
                break
            }
        }

        DispatchQueue.main.async {
            completionHandler?(result, "", resultString)
        }
    }
    
    static func connectBluetooth(_ completionHandler: SendCompletionHandlerWithNullableString?) {
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { (error) -> Void in
            var result: Bool = false
            
            var title:   String? = ""
            var message: String? = ""
            
            if let error = error as NSError? {
                NSLog("Error:%@", error.description)
                
                switch error.code {
                case EABluetoothAccessoryPickerError.alreadyConnected.rawValue :
                    title   = "Success"
                    message = ""
                    
                    result = true
                case EABluetoothAccessoryPickerError.resultCancelled.rawValue,
                     EABluetoothAccessoryPickerError.resultFailed.rawValue :
                    title   = nil
                    message = nil
                    
                    result = false
//              case EABluetoothAccessoryPickerErrorCode.ResultNotFound :
                default                                                 :
                    title   = "Fail to Connect"
                    message = ""
                    
                    result = false
                }
            }
            else {
                title = "Success"
                message = ""
                
                result = true
            }
            
            if completionHandler != nil {
                completionHandler!(result, title, message)
            }
        }
    }
    
    static func disconnectBluetooth(_ modelName: String!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        while true {
            guard let port: SMPort = SMPort.getPort(AppDelegate.getPortName(), AppDelegate.getPortSettings(), 10000) else {     // 10000mS!!!
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            if modelName.hasPrefix("TSP143IIIBI") == true {
                let commandArray: [UInt8] = [0x1b, 0x1c, 0x26, 0x49]     // Only TSP143IIIBI
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                port.beginCheckedBlock(&printerStatus, 2, &error)
                
                if error != nil {
                    break
                }
                
                if printerStatus.offline == sm_true {
                    title   = "Printer Error"
                    message = "Printer is offline (BeginCheckedBlock)"
                    break
                }
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commandArray.count) {
                    let written: UInt32 = port.write(commandArray, total, UInt32(commandArray.count) - total, &error)
                    
                    if error != nil {
                        break
                    }
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        title   = "Printer Error"
                        message = "Write port timed out"
                        break
                    }
                }
                
                if total < UInt32(commandArray.count) {
                    break
                }
                
//              port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
//
//              port.endCheckedBlock(&printerStatus, 2, &error)
//
//              if error != nil {
//                  break
//              }
//
//              if printerStatus.offline == sm_true {
//                  title   = "Printer Error"
//                  message = "Printer is offline (EndCheckedBlock)"
//                  break
//              }
            }
            else {
                if port.disconnect() == false {
                    title   = "Fail to Disconnect"
                    message = "Note. Portable Printers is not supported."
                    break
                }
            }
            
            title   = "Success"
            message = ""
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
    
    static func confirmSerialNumber(_ portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        while true {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          guard let port: SMPort = SMPort.getPort(portName, "(your original portSettings);l1000)", timeout) else {
            guard let port: SMPort = SMPort.getPort(portName, portSettings, timeout) else {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            let commandArray: [UInt8] = [0x1b, 0x1d, 0x29, 0x49, 0x01, 0x00, 49]     // <ESC><GS>')''I'pLpHfn
            
            while total < UInt32(commandArray.count) {
                let written: UInt32 = port.write(commandArray,
                                                 total,
                                                 UInt32(commandArray.count) - total,
                                                 &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >=  3.0 {     //  3000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < UInt32(commandArray.count) {
                break
            }
            
            var information: String = ""
            
            var receivedData: [UInt8] = [UInt8]()
            
            while true {
                var buffer: [UInt8] = [UInt8](repeating: 0, count: 1024 + 8)
                
                if Date().timeIntervalSince(startDate) >=  3.0 {     //  3000mS!!!
                    title   = "Printer Error"
                    message = "Can not receive information"
                    break
                }
                
                Thread.sleep(forTimeInterval: 0.01)     // Break time.
                
                let readLength: UInt32 = port.read(&buffer, 0, 1024, &error)
                
                if error != nil {
                    break
                }
                
                if readLength == 0 {
                    continue;
                }
                
                let resizedBuffer = buffer.prefix(Int(readLength)).map{ $0 }
                receivedData.append(contentsOf: resizedBuffer)
                
                if (receivedData.count >= 2) {
                    for i: Int in 0 ..< Int(receivedData.count - 1) {
                        if buffer[i + 0] == 0x0a &&
                            buffer[i + 1] == 0x00 {
                            for j: Int in 0 ..< Int(receivedData.count - 9) {
                                if buffer[j + 0] == 0x1b &&
                                   buffer[j + 1] == 0x1d &&
                                   buffer[j + 2] == 0x29 &&
                                   buffer[j + 3] == 0x49 &&
                                   buffer[j + 6] == 49 {
                                    information = ""
                                    
                                    for k: Int in j + 7 ..< Int(receivedData.count) {
                                        let text: String = String(format: "%c", buffer[k])
                                        
                                        information += text
                                    }
                                    
                                    result = true
                                    break
                                }
                            }
                            
                            break
                        }
                    }
                }
                
                if result == true {
                    break
                }
            }
            
            if result == false {
                break
            }
            
            result = false
            
            // Extract Serial Number Field ("PrSrN=....,")
            let serialNumberPrefix = "PrSrN="
            let optSerialNumber = information.split(separator: ",")
                .filter{ $0.hasPrefix(serialNumberPrefix) }
                .map{ $0.dropFirst(serialNumberPrefix.count) }
                .first
            guard let serialNumber = optSerialNumber else {
                title   = "Printer Error"
                message = "Can not receive tag"
                break
            }
            
            title   = "Product Serial Number"
            message = String(serialNumber)
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        if completionHandler != nil {
            completionHandler!(result, title, message)
        }
        
        return result
    }
}
