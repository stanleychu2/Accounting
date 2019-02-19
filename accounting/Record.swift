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

let orderDB = Table("order")

class recordCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
}


class Record: UIViewController, UITableViewDelegate, UITableViewDataSource, ContactpopOverReturnDataDelegate, UIPopoverPresentationControllerDelegate, UpdateRecordDelegate {

    let id = Expression<Int64>("id")
    let contactName = Expression<String>("contactName")
    let amount = Expression<Int64>("amount")
    let money = Expression<Int64>("money")

    //let date = Expression<Date>("date")
    let year = Expression<String>("year")
    let month = Expression<String>("month")
    let day = Expression<String>("day")
    
    let unit = Expression<String>("unit")
    let serialNum = Expression<String>("serialNum")
    let finish = Expression<Bool>("finish")
    
    struct OrderRecord {
        var time: DateComponents = DateComponents()
        var orderNumber: String = ""
        var orderName: String = ""
        var price: Int = 0
    }
    
    let dformatter = DateFormatter()
    
    @IBOutlet weak var selectDate: UILabel!
    @IBOutlet weak var switchDayOrMonth: UISegmentedControl!
    @IBOutlet weak var previousTimer: UIButton!
    @IBOutlet weak var nextTimer: UIButton!
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    var switchDay: Bool = true
    var fromSwitch: Bool = true
    var total: Int = 0
    
    var increaseDay = 0
    var increaseMonth = 0
    var decreaseDay = 0
    var decreaseMonth = 0
    
    var filterDate = orderDB
    
    var newDateComponent = DateComponents()
    var calendar = Calendar.current
    var _date = Date()
    var timeHold : DateComponents = DateComponents()
    
    var allRecord = [OrderRecord]()
    var holdOneRecord = OrderRecord()
    
    let cellReuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dformatter.dateFormat = "YYYY.MM.dd"
        
        loadDB()
        
        orderTable.delegate = self
        orderTable.dataSource = self
        orderTable.layer.masksToBounds = true
        orderTable.layer.borderColor = UIColor.gray.cgColor
        orderTable.layer.borderWidth = 2.0
        
        
        totalPrice.text = String(total)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! recordCell
        
        let month: Int = allRecord[indexPath.row].time.month!
        let day: Int = allRecord[indexPath.row].time.day!
        let orderNum6 = allRecord[indexPath.row].orderNumber.prefix(6)
        cell.date.text = String(month) + "." + String(day)
        cell.number.text = String(orderNum6)
        cell.name.text = allRecord[indexPath.row].orderName
        cell.price.text = String(allRecord[indexPath.row].price)
        
        //計算總價
        let holdPrice: Int = allRecord[indexPath.row].price
        total += holdPrice
        
        totalPrice.text = String(total)
        
        return cell
    }
    
    @IBAction func chooseContact(_ sender: UIButton) {
        performSegue(withIdentifier: "recordPopOverSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func contactPopOverReturnData(contact: String){
        total = 0
        totalPrice.text = "0"
        
        while(allRecord.count > 0){
            allRecord.popLast()
        }
        
        let filterName = orderDB.filter(contactName == contact /*&& finish == true*/)
        for holdOneRecord in (try? db?.prepare(filterName))!! {
            timeHold.year = Int(holdOneRecord[year])
            timeHold.month = Int(holdOneRecord[month])
            timeHold.day = Int(holdOneRecord[day])
            allRecord.append(OrderRecord(
                time: timeHold,
                orderNumber: holdOneRecord[serialNum],
                orderName: holdOneRecord[contactName],
                price: Int(holdOneRecord[amount] * holdOneRecord[money])))
        }
        
        self.orderTable.reloadData()
    }
    func loadDB(){
        // 從資料庫中拿出record
        //顯示當日
        let _year = String(calendar.component(.year, from: _date))
        let _month = String(calendar.component(.month, from: _date))
        let _day = String(calendar.component(.day, from: _date))
        
        
        filterDate = orderDB.filter(year == _year && month == _month && day == _day /*&& finish == true*/)
        //拿出當日資料
        for holdOneRecord in (try? db?.prepare(filterDate))!! {
            timeHold.year = Int(holdOneRecord[year])
            timeHold.month = Int(holdOneRecord[month])
            timeHold.day = Int(holdOneRecord[day])
            allRecord.append(OrderRecord(
                time: timeHold,
                orderNumber: holdOneRecord[serialNum],
                orderName: holdOneRecord[contactName],
                price: Int(holdOneRecord[amount] * holdOneRecord[money])))
        }

        combineSameOrderNumber()
        
        selectDate.text = _year + "." + _month + "." + _day
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "recordPopOverSegue") {
            let controller = segue.destination as? OrderContactPopOver
            
            // 設定回傳的代理為自己
            controller?.delegate = self
        }
       
    }
    
    func update() {
        total = 0
        
        let _year = String(calendar.component(.year, from: _date))
        let _month = String(calendar.component(.month, from: _date))
        let _day = String(calendar.component(.day, from: _date))
        
        print(_year)
        print(_month)
        print(_day)
        
        //顯示整日紀錄或整月紀錄
        if(dformatter.dateFormat == "YYYY.MM.dd"){
            selectDate.text = _year + "." + _month + "." + _day
            
            filterDate = orderDB.filter(year == _year && month == _month && day == _day /*&& finish == true*/)
            
            
        }
        else if(dformatter.dateFormat == "YYYY.MM"){
            filterDate = orderDB.filter(year == _year && month == _month /*&& finish == true*/)
            selectDate.text = _year + "." + _month
            
            
        }
        var element = 0
        print("before start, element = " + String(element))
        for holdOneRecord in (try? db?.prepare(filterDate))!! {
            timeHold.year = Int(holdOneRecord[year])
            timeHold.month = Int(holdOneRecord[month])
            timeHold.day = Int(holdOneRecord[day])
            if(element >= allRecord.count){
                print("if")
                allRecord.append(OrderRecord(
                    time: timeHold,
                    orderNumber: holdOneRecord[serialNum],
                    orderName: holdOneRecord[contactName],
                    price: Int(holdOneRecord[amount] * holdOneRecord[money])))
                
            }
            else if (element < allRecord.count){
                print("else")
                allRecord[element] = (OrderRecord(
                    time: timeHold,
                    orderNumber: holdOneRecord[serialNum],
                    orderName: holdOneRecord[contactName],
                    price: Int(holdOneRecord[amount] * holdOneRecord[money])))
            }
            element += 1
        }
        
        while(allRecord.count > element){
            allRecord.popLast()
            print("pop")
        }
        
        combineSameOrderNumber()
        
        self.orderTable.reloadData()
        
    }
    
    @IBAction func switchDayOrMonth(_ sender: Any) {
        let now = Date()
        if(switchDay == true){
            switchDay = false
            dformatter.dateFormat = "YYYY.MM"
        }
        else{
            switchDay = true
            dformatter.dateFormat = "YYYY.MM.dd"
        }
        fromSwitch = true
        selectDate.text = dformatter.string(from: now)
        
        update()
    }
    @IBAction func next(_ sender: Any) {
        if(switchDay == true){
            increaseDay += 1
        }
        else{
            increaseMonth += 1
        }
        newDateComponent.day = increaseDay + decreaseDay
        newDateComponent.month = increaseMonth + decreaseMonth
        _date = calendar.date(byAdding: newDateComponent, to: Date())!
        
        totalPrice.text = "0"
        fromSwitch = false
        update()
    }
    @IBAction func previous(_ sender: Any) {
        if(switchDay == true){
            decreaseDay -= 1
        }
        else{
            decreaseMonth -= 1
        }
        newDateComponent.day = increaseDay + decreaseDay
        newDateComponent.month = increaseMonth + decreaseMonth
        _date = calendar.date(byAdding: newDateComponent, to: Date())!
        totalPrice.text = "0"
        fromSwitch = false
        update()
    }
    
    func combineSameOrderNumber(){
        for i in 0 ... allRecord.count {
            //print(allRecord.count)
            for j in 0 ... allRecord.count {
                if( j <= i){
                    continue
                }
                else if(i >= allRecord.count || j >= allRecord.count){
                    break
                }
                if(allRecord[i].orderNumber == allRecord[j].orderNumber){
                    print(allRecord[i].orderNumber)
                    allRecord[i].price += allRecord[j].price
                    allRecord.remove(at: j)
                    
                }
            }
        }
    }
    //POS按下確認出單時
    func notifyUpdate() {
        update()
    }
    
    func clearData() {
        print("clear data")
    }
}
