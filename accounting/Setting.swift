//
//  Setting.swift
//  accounting
//
//  Created by 徐胤桓 on 2019/1/24.
//  Copyright © 2019年 邱斯. All rights reserved.
//
import UIKit
import ZHDropDownMenu
import SQLite

// 連接 db 並宣告一個ㄧ名為 productDB 的 table
let settingDB = Table("setting")

// table 中有哪一些欄位和型態
let onlyID = Expression<Int64>("onlyID")
let shopName = Expression<String>("shopName")
let phoneNumber = Expression<String>("phoneNumber")
let cellPhoneNumber = Expression<String>("cellPhoneNumber")
let email = Expression<String>("email")
let lineID = Expression<String>("lineID")
let faxNumber = Expression<String>("faxNumber")
let address = Expression<String>("address")


class settingCell: UITableViewCell {
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var index: UILabel!
}

struct shop {
    var id: Int = 0
    var shopName: String = ""
    var phoneNumber: String = ""
    var cellPhoneNumber: String = ""
    var email: String = ""
    var lineID: String = ""
    var faxNumber: String = ""
    var address: String = ""
}

class Setting: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    var shopSetting = shop()
    var info = ["商家名稱","市話","行動電話","聯絡信箱","LINE ID","傳真號碼","地址"]
    
    let cellReuseIdentifier = "Cell"
    
    @IBOutlet weak var userSettingTable: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 創建 table 只會在第一次時執行
        try! db?.run(settingDB.create(ifNotExists: true, block: { (table) in
            table.column(onlyID, primaryKey: true)
            table.column(shopName)
            table.column(phoneNumber)
            table.column(cellPhoneNumber)
            table.column(email)
            table.column(lineID)
            table.column(faxNumber)
            table.column(address)
        }))
        
        // 從資料庫中拿出setting
        for setting in (try? db?.prepare(settingDB))!! {
            shopSetting = shop(id: Int(setting[onlyID]), shopName: setting[shopName], phoneNumber: setting[phoneNumber], cellPhoneNumber: setting[cellPhoneNumber], email: setting[email], lineID: setting[lineID], faxNumber: setting[faxNumber], address: setting[address])
        }
        
        userSettingTable.allowsSelection = false
        saveButton.layer.cornerRadius = 10
        userSettingTable.delegate = self
        userSettingTable.dataSource = self
        userSettingTable.layer.masksToBounds = true
        userSettingTable.layer.borderColor = UIColor.gray.cgColor
        userSettingTable.layer.borderWidth = 2.0
    }
    
    // 點擊空白處縮起鍵盤停止編輯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        // 將資料插入資料庫
        for i in 0...6{
            let indexPath = IndexPath(row: i, section: 0)
            let cell = userSettingTable.cellForRow(at: indexPath) as! settingCell
            print(cell.value.text! + "!")
            if(i == 0){
                shopSetting.shopName = cell.value.text!
            }
            if(i == 1){
                shopSetting.phoneNumber = cell.value.text!
            }
            if(i == 2){
                shopSetting.cellPhoneNumber = cell.value.text!
            }
            if(i == 3){
                shopSetting.email = cell.value.text!
            }
            if(i == 4){
                shopSetting.lineID = cell.value.text!
            }
            if(i == 5){
                shopSetting.faxNumber = cell.value.text!
            }
            if(i == 6){
                shopSetting.address = cell.value.text!
            }
        }
        //若存在資料則更新
        if (shopSetting.id == 1){
            let update = settingDB.filter(onlyID == 1)
            if let rowId = try? db?.run(update.update(shopName <- shopSetting.shopName, phoneNumber <- shopSetting.phoneNumber, cellPhoneNumber <- shopSetting.cellPhoneNumber, email <- shopSetting.email, lineID <- shopSetting.lineID, faxNumber <- shopSetting.faxNumber, address <- shopSetting.address)){
                shopSetting.id = rowId!
                print("更新成功：\(String(describing: rowId))")
            } else {
                print("更新失敗")
            }
        }
            //若table為空，插入第一筆資料
        else{
            let insert = settingDB.insert(shopName <- shopSetting.shopName, phoneNumber <- shopSetting.phoneNumber, cellPhoneNumber <- shopSetting.cellPhoneNumber, email <- shopSetting.email, lineID <- shopSetting.lineID, faxNumber <- shopSetting.faxNumber, address <- shopSetting.address)
            if let rowId = try? db?.run(insert) {
                print("插入成功：\(String(describing: rowId))")
                shopSetting.id = Int(rowId!)
            } else {
                print("插入失敗")
            }
        }
        
    }
    
    
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! settingCell
        
        if(indexPath.row == 0){
            cell.value.text! = shopSetting.shopName
        }
        if(indexPath.row == 1){
            cell.value.text! = shopSetting.phoneNumber
        }
        if(indexPath.row == 2){
            cell.value.text! = shopSetting.cellPhoneNumber
        }
        if(indexPath.row == 3){
            cell.value.text! = shopSetting.email
        }
        if(indexPath.row == 4){
            cell.value.text! = shopSetting.lineID
        }
        if(indexPath.row == 5){
            cell.value.text! = shopSetting.faxNumber
        }
        if(indexPath.row == 6){
            cell.value.text! = shopSetting.address
        }
        
        cell.index.text = self.info[indexPath.row]
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
