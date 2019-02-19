//
//  OrderPopOverView.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/28.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

@objc protocol popOverReturnDataDelegate {
    func popOverReturnData(productName: String, amount: Int, unitPrice: Int)
}

class OrderPopOverView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var orderAmountInput: UITextField!
    @IBOutlet weak var unitPriceInput: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var productName: String!
    var selectedInput: UITextField!
    weak var delegate: popOverReturnDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = productName
        
        self.orderAmountInput.delegate = self
        self.unitPriceInput.delegate = self
        
        // 使 orderAmountInput 一進畫面時處於一個可編輯(Focus)的狀態
        orderAmountInput.becomeFirstResponder()
    }
    
    // 點擊空白處縮起鍵盤停止編輯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 禁止用除了旁邊小鍵盤之外的方法更改
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
    
    // 偵測目前選到的是哪一個 input 元件
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == orderAmountInput){
            selectedInput = orderAmountInput
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
            
            if(orderAmountInput.text != "" && unitPriceInput.text != "") {
                totalPriceLabel.text = "$ " + String(Int(orderAmountInput.text!)! * Int(unitPriceInput.text!)!)
            }
            else {
                totalPriceLabel.text = "$ 0"
            }
        }
    }
    
    @IBAction func newOrder(_ sender: UIButton) {
        
        if(orderAmountInput.text == "" || unitPriceInput.text == "") {
            let alertController = UIAlertController(title: "不能有欄位為空\n請輸入完成後再次點選", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            // 回傳時執行 orderViewController 的 popOverReturnData func
            delegate?.popOverReturnData(productName: productName, amount: Int(orderAmountInput.text!)!, unitPrice: Int(unitPriceInput.text!)!)
            // 點擊按鈕之後關閉 popOver 的動畫
            presentingViewController!.dismiss(animated: true, completion: nil)
        }
    }
}
