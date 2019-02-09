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
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var telephoneLabel: UITextField!
    @IBOutlet weak var cellphoneLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var lineidLabel: UITextField!
    @IBOutlet weak var faxLabel: UITextField!
    @IBOutlet var editTableview: UITableView!
    
    
    
    var contact = Contact()
    var edit: Bool = false
    var index: Int64 = 0
    
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let telephone = Expression<String>("telephone")
    let cellphone = Expression<String>("cellphone")
    let email = Expression<String>("email")
    let lineId = Expression<String>("lineId")
    let fax = Expression<String>("fax")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(contactDB)
        print("\(String(contact.name))")
        print("!!!")
        print(edit)
        nameLabel.text = contact.name
        telephoneLabel.text = contact.telephone
        cellphoneLabel.text = contact.cellphone
        emailLabel.text = contact.email
        lineidLabel.text = contact.lineId
        faxLabel.text = contact.fax
        editTableview.allowsSelection = false;
    }
    
    @IBAction func goback(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if edit{
            print("modify")
            let modify = contactDB.filter(id == index)
            if let count = try? db?.run(modify.update(name <- nameLabel.text ?? "", telephone <- telephoneLabel.text ?? "", cellphone <- cellphoneLabel.text ?? "", email <- emailLabel.text ?? "", lineId <- lineidLabel.text ?? "", fax <- faxLabel.text ?? "")) {
                print("修改 row 的個數：\(String(describing: count))")
            } else {
                print("修改失敗")
            }
        }else{
            print("insert")
            let insert = contactDB.insert(name <- nameLabel.text ?? "", telephone <- telephoneLabel.text ?? "", cellphone <- cellphoneLabel.text ?? "", email <- emailLabel.text ?? "", lineId <- lineidLabel.text ?? "", fax <- faxLabel.text ?? "")
            if let rowId = try? db?.run(insert) {
                print("插入成功：\(String(describing: rowId))")
                contact.id = rowId!
            } else {
                print("插入失敗")
            }
            
        }
    }
    
    
    
}
