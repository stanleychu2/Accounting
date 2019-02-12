//
//  Record.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/19.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import ZHDropDownMenu
import SQLite

//let orderDB = Table("order")

let time = Expression<TimeInterval>("time")
let orderNumber = Expression<String>("orderNumber")
let orderName = Expression<String>("orderName")
let price = Expression<Int>("price")


class recordCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
}


class Record: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct OrderRecord {
        var time: TimeInterval = 0
        var orderNumber: String = ""
        var orderName: String = ""
        var price: Int = 0
    }
    
    @IBOutlet weak var switchDayOrMonth: UISegmentedControl!
    @IBOutlet weak var previousTimer: UIButton!
    @IBOutlet weak var nextTimer: UIButton!
    @IBOutlet weak var orderTable: UITableView!
    
    var allRecord = [OrderRecord]()
    var holdOneRecord = OrderRecord()
    
    let cellReuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // 創建 table 只會在第一次時執行
        try! db?.run(orderDB.create(ifNotExists: true, block: { (table) in
            table.column(orderNumber, primaryKey: true)
            table.column(orderName)
            table.column(time)
            table.column(price)
            
        }))
        
        // 從資料庫中拿出record
        for holdOneRecord in (try? db?.prepare(orderDB))!! {
            allRecord.append(OrderRecord(
                time: holdOneRecord[time],
                orderNumber: holdOneRecord[orderNumber],
                orderName: holdOneRecord[orderName],
                price: holdOneRecord[price]))
        }
        */
        orderTable.delegate = self
        orderTable.dataSource = self
        orderTable.layer.masksToBounds = true
        orderTable.layer.borderColor = UIColor.gray.cgColor
        orderTable.layer.borderWidth = 2.0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return allRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! recordCell
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM.dd"
        cell.date.text = dformatter.string(from: now)
        cell.number.text = "1234"
        cell.name.text = "rshow"
        cell.price.text = "6666"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
