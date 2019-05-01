//
//  DatePicker.swift
//  accounting
//
//  Created by 徐胤桓 on 2019/4/28.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite
import Foundation

@objc protocol DatePopOverReturnDataDelegate {
    func pickDate(contact: String!, startYear: Int, startMonth: Int, startDay: Int, endYear: Int, endMonth: Int, endDay: Int)
}
class DatePicker: UIViewController, UITextFieldDelegate, ContactpopOverReturnDataDelegate {
    
    
    
    @IBOutlet weak var start: UIDatePicker!
    @IBOutlet weak var end: UIDatePicker!
    weak var delegate: DatePopOverReturnDataDelegate?
    var startDate = DateComponents()
    var endDate = DateComponents()
    var name: String = ""
    @IBOutlet weak var display: UILabel!

    @IBAction func finsih(_ sender: Any) {
        if(name != ""){
            startDate = Calendar.current.dateComponents(in: TimeZone.current, from: start.date)
            endDate = Calendar.current.dateComponents(in: TimeZone.current, from: end.date)

            delegate?.pickDate(contact: name, startYear: startDate.year!, startMonth: startDate.month!, startDay: startDate.day!, endYear: endDate.year!, endMonth: endDate.month!, endDay: endDate.day!)
            presentingViewController!.dismiss(animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "請選擇聯絡人\n", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func contactPopOverReturnData(contact: String) {
        print("is")
        name = contact
        display.text = contact

    }
    
    @IBAction func chooseContact(_ sender: Any) {
        performSegue(withIdentifier: "contactPopOverSegue", sender: nil)
    }
    @IBAction func pickStartDate(_ sender: Any) {
        startDate = Calendar.current.dateComponents(in: TimeZone.current, from: start.date)
        
    }
    @IBAction func pickEndDate(_ sender: Any) {
        endDate = Calendar.current.dateComponents(in: TimeZone.current, from: end.date)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "contactPopOverSegue") {
            let controller = segue.destination as? OrderContactPopOver

            // 設定回傳的代理為自己
            controller?.delegate = self
            controller?.choose = name

        }
        
    }
}


