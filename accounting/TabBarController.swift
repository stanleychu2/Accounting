//
//  TabBarController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/18.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

// 取得 sqlite 放置位置
let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

// 連接 db 並宣告一個ㄧ名為 productDB 的 table
let db = try? Connection("\(path)/db.sqlite")




class TabBarController: UITabBarController {
    
    //contact
    let contactDB = Table("contact")
    
    let company = Expression<String>("company")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let telephone = Expression<String>("telephone")
    let cellphone = Expression<String>("cellphone")
    let email = Expression<String>("email")
    let lineId = Expression<String>("lineId")
    let fax = Expression<String>("fax")
    let other = Expression<String>("other")
    
    //product
    let productDB = Table("product")
    // table 中有哪一些欄位和型態
    let type = Expression<String>("type")
    let pages = Expression<Int64>("pages")
    let position = Expression<Int64>("position")
    
    //order
    let orderDB = Table("order")
    // order table 有哪些欄位(某些欄位名稱與 product 共用)
    let contactName = Expression<String>("contactName")
    let productName = Expression<String>("productName")
    let amount = Expression<Int64>("amount")
    let money = Expression<Int64>("money")
    let year = Expression<String>("year")
    let month = Expression<String>("month")
    let day = Expression<String>("day")
    let unit = Expression<String>("unit")
    let serialNum = Expression<String>("serialNum")
    let finish = Expression<Bool>("finish")
    
    //setting
    let settingDB = Table("setting")
    // table 中有哪一些欄位和型態
    let onlyID = Expression<Int64>("onlyID")
    let shopName = Expression<String>("shopName")
    let phoneNumber = Expression<String>("phoneNumber")
    let cellPhoneNumber = Expression<String>("cellPhoneNumber")
    let lineID = Expression<String>("lineID")
    let faxNumber = Expression<String>("faxNumber")
    let address = Expression<String>("address")
    override func viewDidLoad() {
        
        print("資料庫位址 ： \(path)")
        //create contact table
        try! db?.run(contactDB.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(company)
            table.column(name)
            table.column(telephone)
            table.column(cellphone)
            table.column(email)
            table.column(lineId)
            table.column(fax)
            table.column(other)
        }))
        //create product table
        try! db?.run(productDB.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(type)
            table.column(pages)
            table.column(position)
        }))
        
        //create order table
        try! db?.run(orderDB.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(contactName)
            table.column(productName)
            table.column(amount)
            table.column(money)
            table.column(year)
            table.column(month)
            table.column(day)
            table.column(unit)
            table.column(serialNum)
            table.column(finish)
        }))
        
        //create setting table
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
        
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0), NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        // 設定起始頁面
        self.selectedIndex = 0
        //建立資料庫
        
        //contactDB
        
    }
    
}

