//
//  POSSPopOverView.swift
//  accounting
//
//  Created by sam on 2019/2/14.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import iOSDropDown
import SQLite

@objc protocol POSSPopOverReturnDataDelegate {
    func updateOrderTableView(name: String, uuid: String)
    func updateContactCollection()
}

class POSSPopOverView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var amountInput: UITextField!
    @IBOutlet weak var unitPriceInput: UITextField!
    @IBOutlet weak var unitInput: DropDownMenu!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    let orderDB = Table("order")
    
    var product: String!
    var contact: String!
    var number: String = ""
    var price: String = ""
    var productId: Int = -1
    var unitString:String = ""
    var uuid: String!
    var selectedInput: UITextField!
    var modify: Bool = true
    var orderProduct = [OrderProduct]()
    weak var delegate: POSSPopOverReturnDataDelegate?
    // order table 有哪些欄位(某些欄位名稱與 product 共用)
    let id = Expression<Int64>("id")
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
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        productNameLabel.text = product
        amountInput.text = number
        unitPriceInput.text = price
        
        if (productId != -1){ // 點選table訂單
            let u = orderDB.filter(id == Int64(productId)).select(unit)
            for p in (try? db?.prepare(u))!! {
               unitInput.text = p[unit]
            }
            totalMoney.text = "$ " + String(Int(amountInput.text!)! * Int(unitPriceInput.text!)!)
            deleteBtn.isHidden = false
        }
        
        self.amountInput.delegate = self
        self.unitPriceInput.delegate = self
        
        amountInput.becomeFirstResponder()
        
        unitInput.optionArray = ["公斤", "台斤", "件"]
        // 當下拉式選單中的東西被選到時執行
        unitInput.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            
            //self.product.type = selectedText
        }
    }
    
    // 點擊空白處縮起鍵盤停止編輯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 禁止用除了旁邊小鍵盤之外的方法更改
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == amountInput){
            selectedInput = amountInput
        }
        else if(textField == unitPriceInput){
            selectedInput = unitPriceInput
        }
        
        return false
    }

    @IBAction func typeNumber(_ sender: UIButton) {
        //  一開始使用者都沒有選 input 元件的話便會造成 selectedInput 為空
        if(selectedInput != nil) {
            switch sender.tag {
                
                case 0:
                    selectedInput.text! += "0"
                case 1:
                    selectedInput.text! += "1"
                case 2:
                    selectedInput.text! += "2"
                case 3:
                    selectedInput.text! += "3"
                case 4:
                    selectedInput.text! += "4"
                case 5:
                    selectedInput.text! += "5"
                case 6:
                    selectedInput.text! += "6"
                case 7:
                    selectedInput.text! += "7"
                case 8:
                    selectedInput.text! += "8"
                case 9:
                    selectedInput.text! += "9"
                case 10:
                    selectedInput.text! = ""
                case 11:
                    if(selectedInput.text!.count > 0) {
                        selectedInput.text = String(selectedInput.text!.prefix(selectedInput.text!.count - 1))
                    }
                default:
                    print("error no such number button")
            }
            
            if(amountInput.text != "" && unitPriceInput.text != "") {
                totalMoney.text = "$ " + String(Int(amountInput.text!)! * Int(unitPriceInput.text!)!)
            }
            else {
                totalMoney.text = "$ 0"
            }
        }
    }
    
    @IBAction func updateOrder(_ sender: Any) {
        
        if(amountInput.text == "" || unitPriceInput.text == "" || unitInput.text == "") {
            let alertController = UIAlertController(title: "不能有欄位為空\n請輸入完成後再次點選", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else {

            let now = Date()
            let calendar = Calendar.current
            
            let _year = String(calendar.component(.year, from: now))
            let _month = String(calendar.component(.month, from: now))
            let _day = String(calendar.component(.day, from: now))
            
            if(modify){
                print("modify")
                let modify = orderDB.filter(id == Int64(productId))
                print(modify)
                if let count = try? db?.run(modify.update(amount <- Int64(amountInput.text!) ?? 0, money <- Int64(unitPriceInput.text!) ?? 0, year <- _year, day <- _day, month <- _month, unit <- unitInput.text ?? "", serialNum <- uuid, finish <- false)) {
                    print("修改 row 的個數：\(String(describing: count))")
                } else {
                    print("修改失敗")
                }
                delegate?.updateOrderTableView(name: contact, uuid: uuid)
                presentingViewController!.dismiss(animated: true, completion: nil)
            }else{
                print("insert")
                let insert = orderDB.insert(contactName <- contact, productName <- product, amount <- Int64(amountInput.text!) ?? 0, money <- Int64(unitPriceInput.text!) ?? 0, year <- _year, day <- _day, month <- _month, unit <- unitInput.text ?? "", serialNum <- uuid, finish <- false)
                if let rowId = try? db?.run(insert) {
                    print("插入成功：\(String(describing: rowId))")
                } else {
                    print("插入失敗")
                }
                //更新orderTableView
                delegate?.updateOrderTableView(name: contact, uuid: uuid)
                presentingViewController!.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func deleteOrder(_ sender: Any) {
        
        let cancel = orderDB.filter(id == Int64(productId))
        if let count = try? db?.run(cancel.delete()) {
            print("刪除 row 個數為：\(String(describing: count))")
        } else {
            print("刪除失敗")
        }
        //更新orderTableView
        delegate?.updateOrderTableView(name: contact, uuid: uuid)
        delegate?.updateContactCollection()
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
}
