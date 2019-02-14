//
//  PosViewController.swift
//  accounting
//
//  Created by sam on 2019/1/31.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

struct contactForOrder{
    var name: String = ""
    var id: String = ""
}

class ContactCollectionCell: UICollectionViewCell{
    @IBOutlet weak var cellLabel: UILabel!
    
}

class ProductCollectionCell: UICollectionViewCell{
    @IBOutlet weak var cellLabel: UILabel!
    
}

class ProducttableCell: UITableViewCell{
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
}

class POSSViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, POSSPopOverReturnDataDelegate{
    
    
    @IBOutlet weak var totalMoneyView: UIView!
    @IBOutlet weak var ContactCollectionView: UICollectionView!
    @IBOutlet weak var ContactCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    @IBOutlet weak var ProductCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var OrderTableView: UITableView!
    @IBOutlet weak var OrderTableHeader: UIView!
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var vegetableBtn: UIButton!
    @IBOutlet weak var meatBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var sumMoneyLabel: UILabel!
    
    let productDB = Table("product")
    let orderDB = Table("order")
    
    var item = [String](repeating: "", count: 25)
    var pagesIndex: Int64 = 1
    var selectedType = "蔬菜"
    var people = [contactForOrder]()
    var orderProduct = [OrderProduct]()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
            //            print("name: \(product[name])")
        }
        let distinct = orderDB.group(serialNum)
        for order in (try? db?.prepare(distinct))!! {
            people.append(contactForOrder(name: order[contactName], id: order[serialNum]))
            //print(order[serialNum])
        }
        
        totalMoneyView.layer.borderWidth = 2
        totalMoneyView.layer.borderColor = UIColor.lightGray.cgColor
        
        OrderTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        OrderTableView.layer.borderColor = UIColor.lightGray.cgColor
        OrderTableView.layer.borderWidth = 2
        OrderTableHeader.layer.borderWidth = 3
        OrderTableHeader.layer.borderColor = UIColor.lightGray.cgColor
        ContactCollectionView.layer.borderWidth = 1
        ContactCollectionView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        totalMoneyView.layer.borderWidth = 2
        totalMoneyView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
        OrderTableView.delegate = self
        OrderTableView.dataSource = self
        ContactCollectionView.delegate = self
        ContactCollectionView.dataSource = self
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        
        self.view.addSubview(ContactCollectionView)
        self.view.addSubview(ProductCollectionView)

        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "POSSPopOverSegue") {
            let controller = segue.destination as? POSSPopOverView
            
            // 設定回傳的代理為自己
            controller?.delegate = self
            //傳遞商品名稱
            controller?.product = item[(ProductCollectionView.indexPathsForSelectedItems?[0].row)!]
            //傳遞交易聯絡人名字
            controller?.contact = people[(ContactCollectionView.indexPathsForSelectedItems?[0].row)!].name
            //傳遞交易序號
            controller?.uuid = people[(ContactCollectionView.indexPathsForSelectedItems?[0].row)!].id
            
        }
        else {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateContactCollection()
        updateProductCollection()
    }
    
    func updateContactCollection(){
        people = [contactForOrder]()
        let distinct = orderDB.group(serialNum)
        for order in (try? db?.prepare(distinct))!! {
            people.append(contactForOrder(name: order[contactName], id: order[serialNum]))
            //print(order[serialNum])
        }
        ContactCollectionView.reloadData()
    }
    
    func updateProductCollection() {
        
        item = [String](repeating: "", count: 25)
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
        }
        ProductCollectionView.reloadData()
    }
    //更新訂單table 需要給參數：聯絡人名字 交易序號
    func updateOrderTableView(name: String, uuid: String) {
        
        orderProduct = [OrderProduct]()
        let dbResult = orderDB.filter(contactName == name && serialNum == uuid)
        for order in (try? db?.prepare(dbResult))!! {
            orderProduct.append(OrderProduct(name: order[productName], amount: Int(order[amount]), unitPrice: Int(order[money])))
        }
        OrderTableView.reloadData()
        print("reload POS orderTableview")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.ContactCollectionView{
            return 1
        }
        else{ //collectionView == self.ProductCollectionView
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ContactCollectionView{
            return people.count
        }
        else{ //collectionView == self.ProductCollectionView
            return item.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ContactCollectionView{
            let contactCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactCell", for: indexPath) as! ContactCollectionCell
            contactCell.layer.cornerRadius = 5
            contactCell.layer.borderColor = UIColor.black.cgColor
            contactCell.backgroundColor = #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
            
            contactCell.cellLabel.textColor = UIColor.white
            contactCell.cellLabel.text = people[indexPath.row].name
            return contactCell
        }
        else{
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionCell
            productCell.layer.cornerRadius = 5
            productCell.layer.borderColor = UIColor.black.cgColor
            productCell.backgroundColor = (item[indexPath.row] == "") ? UIColor.gray : #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
            
            productCell.cellLabel.textColor = UIColor.white
            productCell.cellLabel.text = item[indexPath.row]
            return productCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.ContactCollectionView{
            
            let n = people[indexPath.row].name
            let id = people[indexPath.row].id
            updateOrderTableView(name: n, uuid: id)
        }
        else{ //collectionView == self.ProductCollectionView
            if(item[indexPath.row] != "") {
                print(item[indexPath.row])
                performSegue(withIdentifier: "POSSPopOverSegue", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderProduct.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProducttableCell
    
        cell.productNameLabel.text = orderProduct[indexPath.row].name
        cell.amountLabel.text = String(orderProduct[indexPath.row].amount)
        cell.totalLabel.text = String(orderProduct[indexPath.row].amount * orderProduct[indexPath.row].unitPrice)
        cell.priceLabel.text = String(orderProduct[indexPath.row].unitPrice)
        return cell
    }
 
    @IBAction func previousPage(_ sender: Any) {
        if(pagesIndex > 1) {
            pagesIndex -= 1
            pageLabel.text = "\(pagesIndex) / 4"
            
            updateProductCollection()
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if(pagesIndex < 4) {
            pagesIndex += 1
            pageLabel.text = "\(pagesIndex) / 4"
            
            updateProductCollection()
        }
    }
    
    @IBAction func chooseVegetable(_ sender: Any) {
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "蔬菜"
        
        updateProductCollection()
    }
    
    @IBAction func chooseMeat(_ sender: Any) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "肉類"
        
        updateProductCollection()
    }
    
    @IBAction func chooseOthers(_ sender: Any) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        selectedType = "雜項"
        
        updateProductCollection()
    }
}
