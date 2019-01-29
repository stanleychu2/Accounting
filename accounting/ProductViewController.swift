//
//  ProductViewController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/18.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import ZHDropDownMenu
import SQLite

// 取得 sqlite 放置位置
let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
// 連接 db 並宣告一個ㄧ名為 productDB 的 table
let db = try? Connection("\(path)/db.sqlite")

struct Product {
    var id: Int64!
    var name: String = ""
    var type: String = ""
    var pages: Int64 = 0
    var position: Int64 = 0
}

// 一個 cell 裡面該有哪些東西(三個 label)
class myCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPositionLabel: UILabel!
    @IBOutlet weak var productPagesLabel: UILabel!
}

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ZHDropDownMenuDelegate {
    
    // 新增 outlet 可以設定樣式和做一些控制利用 contrl 拉到 view controller 裡
    @IBOutlet weak var pagesControllerLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var tableHeaderAllView: UIView!
    @IBOutlet weak var tableHeaderUpView: UIView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var positionMenu: ZHDropDownMenu!
    @IBOutlet weak var pagesMenu: ZHDropDownMenu!
    @IBOutlet weak var vegetableMenu: ZHDropDownMenu!
    @IBOutlet weak var newProduct_btn: UIButton!
    @IBOutlet weak var tableView: UITableView!

    let productDB = Table("product")
    
    // table 中有哪一些欄位和型態
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let type = Expression<String>("type")
    let pages = Expression<Int64>("pages")
    let position = Expression<Int64>("position")
    
    var item = [Product]()
    var product = Product()
    var selectedRow: IndexPath?
    var pagesIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 創建 table 只會在第一次時執行
        try! db?.run(productDB.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(type)
            table.column(pages)
            table.column(position)
        }))
        
        // 從資料庫中拿出所有 product 放到 item 裡
        for product in (try? db?.prepare(productDB))!! {
            item.append(Product(id: product[id], name: product[name], type: product[type], pages: product[pages], position: product[position]))
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 2.0
        
        newProduct_btn.layer.cornerRadius = 10
        deleteBtn.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        
        tableHeaderAllView.layer.borderWidth = 0.5
        tableHeaderAllView.layer.borderColor = UIColor.gray.cgColor
        
        tableHeaderUpView.layer.borderWidth = 0.5
        tableHeaderUpView.layer.borderColor = UIColor.gray.cgColor
        
        // 設定頁碼和最大頁數
        pagesControllerLabel.text = ("\(pagesIndex + 1) / \((item.count - 1) / 8 + 1)")
        
        vegetableMenu.options = ["蔬菜", "肉類", "雜項"] // 設置下拉式表單選項
        vegetableMenu.showBorder = true
        vegetableMenu.editable = false // 可編輯
        vegetableMenu.layer.cornerRadius = 5
        vegetableMenu.delegate = self // 設置代理
        
        pagesMenu.options = ["1", "2", "3", "4"]
        pagesMenu.showBorder = true
        pagesMenu.layer.cornerRadius = 5
        pagesMenu.delegate = self
        
        positionMenu.options = ["1", "2", "3", "4", "5"]
        positionMenu.showBorder = true
        positionMenu.editable = true
        positionMenu.layer.cornerRadius = 5
        positionMenu.delegate = self
    }

    // 选择完后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didSelect index: Int) {
        print("\(menu) choosed at index \(index)")
        
        switch menu {
        case vegetableMenu:
            product.type = vegetableMenu.options[index]
            print(vegetableMenu.options[index])
        case pagesMenu:
            product.pages = Int64(pagesMenu.options[index])!
            print(pagesMenu.options[index])
        case positionMenu:
            product.position = Int64(pagesMenu.options[index])!
            print(pagesMenu.options[index])
        default:
            print("")
        }
    }
    
    // 编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didEdit text: String) {
        print("\(menu) input text \(text)")
        
        switch menu {
        case vegetableMenu:
            product.type = text
            print(text)
        case pagesMenu:
            product.pages = Int64(text)!
            print(text)
        case positionMenu:
            product.position = Int64(text)!
            print(text)
        default:
            print("")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 每一個 section 有幾個 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempt = item.count - 8 * (pagesIndex + 1)
        
        return (tempt > 0) ? 8 : 8 + tempt
    }
    
    // 設定 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! myCell
        
        cell.productNameLabel.text = item[8 * pagesIndex + indexPath.row].name
        cell.productPagesLabel.text = String(item[8 * pagesIndex + indexPath.row].pages)
        cell.productPositionLabel.text = String(item[8 * pagesIndex + indexPath.row].position)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(item[indexPath.row + 8 * pagesIndex].id)
        print(item[indexPath.row + 8 * pagesIndex])
        updateBtn.isHidden = false
        deleteBtn.isHidden = false
        selectedRow = indexPath
    }
    
    @IBAction func previousPagesBtn(_ sender: Any) {
        pagesIndex = pagesIndex > 0 ? pagesIndex - 1 : pagesIndex
        pagesControllerLabel.text = ("\(pagesIndex + 1) / \((item.count - 1) / 8 + 1)")
        tableView.reloadData()
    }
    
    @IBAction func nextPageBtn(_ sender: Any) {
        pagesIndex = pagesIndex < (item.count / 8) ? pagesIndex + 1 : pagesIndex
        pagesControllerLabel.text = ("\(pagesIndex + 1) / \((item.count - 1) / 8 + 1)")
        tableView.reloadData()
    }
    
    @IBAction func newProduct(_ sender: Any) {
        
        // 當有欄位為空得時候跳出警告訊息 upadte 中也相同
        if(productName.text!.count == 0 || product.type.count == 0 || product.pages == 0 || product.position == 0) {
            let alertController = UIAlertController(title: "不能有欄位為空\n請輸入完成後再次點選\n『新增商品』", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        // 當所選位置已存在商品時跳出警告訊息 update 中也相同
        else if(try! (db?.scalar(productDB.filter(type == product.type && pages == product.pages && position == product.position).count))! > 0 ){
            let alertController = UIAlertController(title: "所選的位置和頁數\n已存在商品請重新選擇", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            product.name = productName.text!
            // 將資料插入資料庫
            let insert = productDB.insert(name <- productName.text!, type <- product.type, pages <- product.pages, position <- product.position)
            if let rowId = try? db?.run(insert) {
                print("插入成功：\(String(describing: rowId))")
                product.id = rowId!
            } else {
                print("插入失敗")
            }
            item.append(product)
            pagesControllerLabel.text = ("\(pagesIndex + 1) / \((item.count - 1) / 8 + 1)")
            if(pagesIndex == (item.count-1) / 8) {
                //  將新元素插入表格正確位置
                let tempt: IndexPath = IndexPath(row: (item.count-1)%8, section: 0)
                tableView.insertRows(at: [tempt], with: .left)
            }
            print("\(product.name)     \(String(product.pages))     \(String(product.position))")
        }
    }
    
    @IBAction func updateProduct(_ sender: Any) {
        if(productName.text!.count == 0 || product.type.count == 0 || product.pages == 0 || product.position == 0) {
            let alertController = UIAlertController(title: "不能有欄位為空\n請輸入完成後再次點選\n『新增商品』", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if(try! (db?.scalar(productDB.filter(type == product.type && pages == product.pages && position == product.position).count))! > 0 && !(item[selectedRow!.row + 8 * pagesIndex].pages == product.pages
            && item[selectedRow!.row + 8 * pagesIndex].position == product.position)){
            let alertController = UIAlertController(title: "所選的位置和頁數\n已存在商品請重新選擇", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            updateBtn.isHidden = true
            deleteBtn.isHidden = true
            item[selectedRow!.row + 8 * pagesIndex].name = productName.text!
            item[selectedRow!.row + 8 * pagesIndex].type = product.type
            item[selectedRow!.row + 8 * pagesIndex].pages = product.pages
            item[selectedRow!.row + 8 * pagesIndex].position = product.position
            let modify = productDB.filter(id == item[selectedRow!.row + 8 * pagesIndex].id)
            if let count = try? db?.run(modify.update(name <- productName.text!, type <- product.type, pages <- product.pages, position <- product.position)) {
                print("修改 row 的個數：\(String(describing: count))")
            } else {
                print("修改失敗")
            }
            // 重新更新 table 中的 cell
            tableView.reloadData()
            tableView.deselectRow(at: selectedRow!, animated: true)
            // 向右滑動出現刪除按鈕 : tableView.setEditing(true, animated: false)
        }
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        updateBtn.isHidden = true
        deleteBtn.isHidden = true
        // 將資料從資料庫中刪除
        let cancel = productDB.filter(id == item[selectedRow!.row + 8 * pagesIndex].id)
        if let count = try? db?.run(cancel.delete()) {
            print("刪除 row 個數為：\(String(describing: count))")
        } else {
            print("刪除失敗")
        }
        // 先修改過 source array 之後在刪除 table 的 cell 不然會造成 crash
        item.remove(at: selectedRow!.row + 8 * pagesIndex)
        pagesControllerLabel.text = ("\(pagesIndex + 1) / \((item.count - 1) / 8 + 1)")
        tableView.deselectRow(at: selectedRow!, animated: true)
        tableView.reloadData()
        // 刪除動畫: 但刪除會造成 row 個數改變產生問題
        // tableView.deleteRows(at: [selectedRow!], with: .fade)
    }
}
