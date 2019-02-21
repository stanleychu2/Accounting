//
//  EditContactTableViewController.swift
//  accounting
//
//  Created by sam on 2019/1/26.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

class EditContactTableViewController: UITableViewController {
    
    @IBOutlet weak var companyLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var telephoneLabel: UITextField!
    @IBOutlet weak var cellphoneLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var lineidLabel: UITextField!
    @IBOutlet weak var faxLabel: UITextField!
    @IBOutlet weak var otherLabel: UITextField!
    @IBOutlet var editTableview: UITableView!
    
    let contactDB = Table("contact")
    
    var contact = Contact()
    var edit: Bool = false
    var index: Int64 = 0
    
    let id = Expression<Int64>("id")
    let company = Expression<String>("company")
    let name = Expression<String>("name")
    let telephone = Expression<String>("telephone")
    let cellphone = Expression<String>("cellphone")
    let email = Expression<String>("email")
    let lineId = Expression<String>("lineId")
    let fax = Expression<String>("fax")
    let other = Expression<String>("other")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        companyLabel.text = contact.company
        nameLabel.text = contact.name
        telephoneLabel.text = contact.telephone
        cellphoneLabel.text = contact.cellphone
        emailLabel.text = contact.email
        lineidLabel.text = contact.lineId
        faxLabel.text = contact.fax
        otherLabel.text = contact.other
        editTableview.allowsSelection = false;
    }
    
    // 點擊空白處縮起鍵盤停止編輯 在這一頁還有一點問題不會消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func goback(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if edit{
            print("modify")
            let modify = contactDB.filter(id == index)
            if let count = try? db?.run(modify.update(company <- companyLabel.text ?? "", name <- nameLabel.text ?? "", telephone <- telephoneLabel.text ?? "", cellphone <- cellphoneLabel.text ?? "", email <- emailLabel.text ?? "", lineId <- lineidLabel.text ?? "", fax <- faxLabel.text ?? "", other <- otherLabel.text ?? "")) {
                print("修改 row 的個數：\(String(describing: count))")
            } else {
                print("修改失敗")
            }
        }else{
            print("insert")
            let insert = contactDB.insert(company <- companyLabel.text ?? "", name <- nameLabel.text ?? "", telephone <- telephoneLabel.text ?? "", cellphone <- cellphoneLabel.text ?? "", email <- emailLabel.text ?? "", lineId <- lineidLabel.text ?? "", fax <- faxLabel.text ?? "", other <- otherLabel.text ?? "")
            if let rowId = try? db?.run(insert) {
                print("插入成功：\(String(describing: rowId))")
                contact.id = rowId!
            } else {
                print("插入失敗")
            }
            
        }
    }
    
    
    
}
