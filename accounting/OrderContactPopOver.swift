//
//  OrderContactPopOver.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/31.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

// 宣告回傳協定
@objc protocol ContactpopOverReturnDataDelegate {
    func contactPopOverReturnData(contact: String)
    func clearData()
}

class OrderContactCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var cellLabel: UILabel!
    
}

class OrderContactPopOver: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageLabel: UILabel!
    
    var people = [Contact]()
    var contact = Contact()
    var pagesIndex = 0
    // table 中有哪一些欄位和型態
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let telephone = Expression<String>("telephone")
    let cellphone = Expression<String>("cellphone")
    let email = Expression<String>("email")
    let lineId = Expression<String>("lineId")
    let fax = Expression<String>("fax")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for contact in (try? db?.prepare(contactDB))!! {
            people.append(Contact(id: contact[id], name: contact[name], telephone: contact[telephone], cellphone: contact[cellphone], email: contact[email], lineId: contact[lineId], fax: contact[fax]))
        }
        // Do any additional setup after loading the view.
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 設定頁碼和最大頁數
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tempt = people.count - 36 * (pagesIndex + 1)
        
        return (tempt > 0) ? 36 : 36 + tempt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderContactCollectionViewCell
        
        // Configure the cell
        cell.layer.cornerRadius = 3
        cell.cellLabel.text = people[36 * pagesIndex + indexPath.row].name
        cell.backgroundColor = #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! OrderContactCollectionViewCell
        // 回傳時執行 orderViewController 的 contactPopOverReturnData func
        delegate?.contactPopOverReturnData(contact: String(cell.cellLabel.text!))
        // 回傳時執行 orderViewController 的 clearData func
        delegate?.clearData()
        presentingViewController!.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func previousPage(_ sender: Any) {
        pagesIndex = pagesIndex > 0 ? pagesIndex - 1 : pagesIndex
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        collectionView.reloadData()
    }
    
    @IBAction func nextPage(_ sender: Any) {
        pagesIndex = pagesIndex < (people.count / 36) ? pagesIndex + 1 : pagesIndex
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        collectionView.reloadData()
    }
    
    
    weak var delegate: ContactpopOverReturnDataDelegate?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
