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
let fax = Expression<String>("fax")
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        print("\(path)")
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0), NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        // 設定起始頁面
        self.selectedIndex = 0
    }
    
}

