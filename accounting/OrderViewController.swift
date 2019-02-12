//
//  SecondViewController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/17.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

struct OrderProduct {
    
    var name: String = ""
    var amount: Int!
    var unitPrice: Int!
   
}

class collectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCellLabel: UILabel!
}

class orderProductCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate, popOverReturnDataDelegate, UITableViewDelegate, UITableViewDataSource, ContactpopOverReturnDataDelegate {
    
    @IBOutlet weak var totalMoneyView: UIView!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var meatBtn: UIButton!
    @IBOutlet weak var vegetableBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeader: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var moneySumLabel: UILabel!
    
    let productDB = Table("product")
    let orderDB = Table("order")
    let contactDB = Table("contact")
    // product table 中有哪一些欄位和型態
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let type = Expression<String>("type")
    let pages = Expression<Int64>("pages")
    let position = Expression<Int64>("position")
    
    // order table 有哪些欄位(某些欄位名稱與 product 共用)
    let contactName = Expression<String>("contactName")
    let productName = Expression<String>("productName")
    let amount = Expression<Int64>("amount")
    let money = Expression<Int64>("money")
    let date = Expression<Date>("date")
    let unit = Expression<String>("unit")
    let serialNum = Expression<String>("serialNum")
    // 聯絡人欄位一開始為空『確認訂單』之後才有值
    let contact = Expression<String?>("contact")
    
    var item = [String](repeating: "", count: 25)
    var orderProduct = [OrderProduct]()
    
    // ["青椒", "小白菜", "空心菜", "大陸妹", "A 菜",
    // "山蘇", "芥蘭菜", "菜心", "大黃瓜", "四季豆",
    // "皇帝豆", "苦瓜", "地瓜葉", "芋頭", "莧菜",
    // "絲瓜", "青江菜", "金針菇", "茼蒿", "萵苣",
    // "龍鬚菜", "", "", "", ""]
    
    var selectedType = "蔬菜"
    var timer: Timer!
    var pagesIndex: Int64 = 1
    
    // 只有第一次會進入畫面的時候執行
    override func viewDidLoad() {
        super.viewDidLoad()
        //建立order table
        try! db?.run(orderDB.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(contactName)
            table.column(productName)
            table.column(amount)
            table.column(money)
            table.column(date)
            table.column(unit)
            table.column(serialNum)
        }))
        
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
//            print("name: \(product[name])")
        }
        
        var now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd     HH:mm:ss"
        var time = formatter.string(from: now)
        timeLabel.text = time
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        // table 的 seperator 上下左右不要有邊界
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 2.0
        
        tableHeader.layer.borderWidth = 0.5
        tableHeader.layer.borderColor = UIColor.gray.cgColor
        
        totalMoneyView.layer.borderWidth = 2
        totalMoneyView.layer.borderColor = UIColor.gray.cgColor
        
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        
        // 每一秒更新一次畫面上的時間
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            now = Date()
            time = formatter.string(from: now)
            
            self.timeLabel.text = time
//            print(time)
        }
    }
    
    // 每次進入畫面都會執行
    override func viewDidAppear(_ animated: Bool) {
        // timer 繼續計時
        timer.fireDate = Date.distantPast
        updateCollection()
    }
    
    // 畫面已經離開螢幕所做的事
    override func viewDidDisappear(_ animated: Bool) {
        // 停止每秒更新一次時間
        timer.fireDate = Date.distantFuture
        //  timer.invalidate() 直接摧毀 timer 的這個功能不能再開始
    }
    
    // 傳遞資料到不同的頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "orderPopOverSegue") {
            let controller = segue.destination as? OrderPopOverView
            
            // 設定回傳的代理為自己
            controller?.delegate = self
            controller?.productName = item[(collectionView.indexPathsForSelectedItems?[0].row)!]
        }
        else if(segue.identifier == "confirmOrderPopOverSegue") {
            let controller = segue.destination as? OrderContactPopOver
            
            // 設定回傳的代理為自己
            controller?.delegate = self
        }
    }
    
    func clearData() {
        print("clear data")
        
        orderProduct = [OrderProduct]()
        moneySumLabel.text = "$ 0"
        tableView.reloadData()
    }
    
    // popOver 回傳資料執行的 func
    func popOverReturnData(productName: String, amount: Int, unitPrice: Int) {
        print("name: \(productName) amount: \(amount) unitPrice: \(unitPrice)")
        
        orderProduct.append(OrderProduct(name: productName, amount: amount, unitPrice: unitPrice))
        let tempt: IndexPath = IndexPath(row: orderProduct.count - 1, section: 0)
        let index = moneySumLabel.text!.index(moneySumLabel.text!.endIndex, offsetBy: -1 * (moneySumLabel.text!.count - 2))
        let moneySumSubstring = String(moneySumLabel.text![index...])
        tableView.insertRows(at: [tempt], with: .left)
        moneySumLabel.text = "$ " + String(amount * unitPrice + Int(moneySumSubstring)!)
    }
    
    // contactPopOver 回傳資料執行的func
    func contactPopOverReturnData(contact: String){
        
        let now = Date()
        print("contact: \(contact)")
        let uuid = UUID().uuidString
        print(uuid)
        for o in orderProduct{
            print("name: \(o.name) amount: \(o.amount ?? 0)")
            print("insert")
            print(now)
            let insert = orderDB.insert(contactName <- contact, productName <- o.name, amount <- Int64(o.amount ?? 0), money <- Int64(o.unitPrice ?? 0), date <- now, unit <- "", serialNum <- uuid)
            if let rowId = try? db?.run(insert) {
                print("插入成功：\(String(describing: rowId))")
            } else {
                print("插入失敗")
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        
        //  cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.backgroundColor = (item[indexPath.row] == "") ? UIColor.gray : #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
        
        cell.collectionCellLabel.textColor = UIColor.white
        cell.collectionCellLabel.text = item[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(item[indexPath.row] != "") {
            performSegue(withIdentifier: "orderPopOverSegue", sender: nil)
        }
        //  collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // 當 type 或是 pages 改變時更新 collection 的內容
    func updateCollection() {
        
        item = [String](repeating: "", count: 25)
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
        }
        collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderProductCell") as! orderProductCell
        
        cell.productNameLabel.text = orderProduct[indexPath.row].name
        cell.amountLabel.text = String(orderProduct[indexPath.row].amount)
        cell.totalLabel.text = String(orderProduct[indexPath.row].amount * orderProduct[indexPath.row].unitPrice)
        cell.priceLabel.text = String(orderProduct[indexPath.row].unitPrice)
        return cell
    }
    
    @IBAction func previousPagesBtn(_ sender: UIButton) {
        if(pagesIndex > 1) {
            pagesIndex -= 1
            pagesLabel.text = "\(pagesIndex) / 4"
            
            updateCollection()
        }
    }
    
    @IBAction func nextPagesBtn(_ sender: UIButton) {
        if(pagesIndex < 4) {
            pagesIndex += 1
            pagesLabel.text = "\(pagesIndex) / 4"
            
            updateCollection()
        }
    }
    
    @IBAction func chooseVegetable(_ sender: UIButton) {
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "蔬菜"
        
        updateCollection()
    }
    
    @IBAction func chooseMeat(_ sender: UIButton) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "肉類"
        
        updateCollection()
    }
    
    @IBAction func chooseOther(_ sender: UIButton) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        selectedType = "雜項"
        
        updateCollection()
    }
    
    @IBAction func clearOrderProduct(_ sender: UIButton) {
        orderProduct = [OrderProduct]()
        moneySumLabel.text = "$ 0"
        tableView.reloadData()
    }
    
    @IBAction func confirmOrder(_ sender: UIButton) {
        performSegue(withIdentifier: "confirmOrderPopOverSegue", sender: nil)
    }
    
}
