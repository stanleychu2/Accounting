//
//  DeviceStatusViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class DeviceStatusViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    enum CellParamIndex: Int {
        case titleIndex = 0
        case detailIndex
        case colorIndex
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var statusCellArray: NSMutableArray!
    
    var firmwareInfoCellArray: NSMutableArray!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.appendRefreshButton(#selector(DeviceStatusViewController.refreshDeviceStatus))
        
        self.statusCellArray = NSMutableArray()
        
        self.firmwareInfoCellArray = NSMutableArray()
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            self.refreshDeviceStatus()
            
            self.didAppear = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.statusCellArray.count       != 0 &&
            self.firmwareInfoCellArray.count != 0) {
            return 2
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.statusCellArray.count
        }
        else {  // section == 1
            return self.firmwareInfoCellArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            var cellParam: [AnyObject]
            
            if (indexPath.section == 0) {
                cellParam = self.statusCellArray[indexPath.row] as! [AnyObject]
            }
            else {  // indexPath.section == 1
                cellParam = self.firmwareInfoCellArray[indexPath.row] as! [AnyObject]
            }
            
            cell      .textLabel!.text      = cellParam[CellParamIndex.titleIndex.rawValue] as? String
            cell.detailTextLabel!.text      = cellParam[CellParamIndex.detailIndex.rawValue] as? String
            cell.detailTextLabel!.textColor = (cellParam[CellParamIndex.colorIndex.rawValue] as! UIColor)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Device Status"
        }
        else {  // section == 1
            return "Firmware Information"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func refreshDeviceStatus() {
        var result: Bool = false
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.statusCellArray.removeAllObjects()
        
        self.firmwareInfoCellArray.removeAllObjects()
        
        var error: NSError?
        
        while true {
            let portName = AppDelegate.getPortName()

            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          guard let port: SMPort = SMPort.getPort(portName, "(your original portSettings);l1000)", 10000) else {
            guard let port: SMPort = SMPort.getPort(portName, AppDelegate.getPortSettings(), 10000) else {     // 10000mS!!!
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
            
            if printerStatus.offline == sm_true {
                self.statusCellArray.add(["Online", "Offline", UIColor.red])
            }
            else {
                self.statusCellArray.add(["Online",  "Online",  UIColor.blue])
            }
            
            if printerStatus.coverOpen == sm_true {
                self.statusCellArray.add(["Cover", "Open",   UIColor.red])
            }
            else {
                self.statusCellArray.add(["Cover", "Closed", UIColor.blue])
            }
            
            if printerStatus.receiptPaperEmpty == sm_true {
                self.statusCellArray.add(["Paper", "Empty", UIColor.red])
            }
            else if printerStatus.receiptPaperNearEmptyInner == sm_true ||
                    printerStatus.receiptPaperNearEmptyOuter == sm_true {
                self.statusCellArray.add(["Paper", "Near Empty", UIColor.orange])
            }
            else {
                self.statusCellArray.add(["Paper", "Ready",      UIColor.blue])
            }
            
            if AppDelegate.getCashDrawerOpenActiveHigh() == true {
                if printerStatus.compulsionSwitch == sm_true {
                    self.statusCellArray.add(["Cash Drawer", "Open",   UIColor.red])
                }
                else {
                    self.statusCellArray.add(["Cash Drawer", "Closed", UIColor.blue])
                }
            }
            else {
                if printerStatus.compulsionSwitch == sm_true {
                    self.statusCellArray.add(["Cash Drawer", "Closed", UIColor.blue])
                }
                else {
                    self.statusCellArray.add(["Cash Drawer", "Open",   UIColor.red])
                }
            }
            
            if printerStatus.overTemp == sm_true {
                self.statusCellArray.add(["Head Temperature", "High",   UIColor.red])
            }
            else {
                self.statusCellArray.add(["Head Temperature", "Normal", UIColor.blue])
            }
            
            if printerStatus.unrecoverableError == sm_true {
                self.statusCellArray.add(["Non Recoverable Error", "Occurs", UIColor.red])
            }
            else {
                self.statusCellArray.add(["Non Recoverable Error", "Ready",  UIColor.blue])
            }
            
            if printerStatus.cutterError == sm_true {
                self.statusCellArray.add(["Paper Cutter", "Error", UIColor.red])
            }
            else {
                self.statusCellArray.add(["Paper Cutter", "Ready", UIColor.blue])
            }
            
            if printerStatus.headThermistorError == sm_true {
                self.statusCellArray.add(["Head Thermistor", "Error",  UIColor.red])
            }
            else {
                self.statusCellArray.add(["Head Thermistor", "Normal", UIColor.blue])
            }
            
            if printerStatus.voltageError == sm_true {
                self.statusCellArray.add(["Voltage", "Error",  UIColor.red])
            }
            else {
                self.statusCellArray.add(["Voltage", "Normal", UIColor.blue])
            }
            
            if printerStatus.etbAvailable == sm_true {
                self.statusCellArray.add(["ETB Counter", String(format: "%d", printerStatus.etbCounter), UIColor.blue])
            }
            
            if printerStatus.offline == sm_true {
                self.firmwareInfoCellArray.add(["Unable to get F/W info. from an error.", "", UIColor.red])
                
                result = true
                break
            }
            else {
                let dictionary: Dictionary = port.getFirmwareInformation(&error)
                
                if error != nil {
                    break
                }
                
                let modelName:       String = dictionary["ModelName"]       as! String
                let firmwareVersion: String = dictionary["FirmwareVersion"] as! String
                
                self.firmwareInfoCellArray.add(["Model Name",       modelName,       UIColor.blue])
                self.firmwareInfoCellArray.add(["Firmware Version", firmwareVersion, UIColor.blue])
                
                result = true
                break
            }
        }
        
        if result == false {
            self.showSimpleAlert(title: "Fail to Open Port",
                                 message: "",
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel)
        }
        
        self.tableView.reloadData()
    }
}
