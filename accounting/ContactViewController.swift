//
//  FirstViewController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/17.
//  Copyright © 2019 邱斯,徐胤桓,陳則明. All rights reserved.
//

import UIKit
import SQLite




struct Contact {
    var id: Int64!
    var company: String = ""
    var name: String = ""
    var telephone: String = ""
    var cellphone: String = ""
    var email: String = ""
    var lineId: String = ""
    var fax: String = ""
    var other: String = ""
}

class ContactCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    
}

class ContactViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageLabel: UILabel!
    
    let contactDB = Table("contact")
    
    var people = [Contact]()
    var contact = Contact()
    var pagesIndex = 0
    
    // table 中有哪一些欄位和型態
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
        
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        collectionViewLayout.headerReferenceSize = CGSize(width: 700, height: 40)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 設定頁碼和最大頁數
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCollection()
        
    }
    func updateCollection(){
        people = [Contact]()
        for contact in (try? db?.prepare(contactDB))!! {
            people.append(Contact(id: contact[id], company: contact[company], name: contact[name], telephone: contact[telephone], cellphone: contact[cellphone], email: contact[email], lineId: contact[lineId], fax: contact[fax], other: contact[other]))
        }
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        collectionView.reloadData()
    }
    
    @IBAction func upPage(_ sender: Any) {
        pagesIndex = pagesIndex > 0 ? pagesIndex - 1 : pagesIndex
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        collectionView.reloadData()
    }
    
    @IBAction func downPage(_ sender: Any) {
        pagesIndex = pagesIndex < (people.count / 36) ? pagesIndex + 1 : pagesIndex
        pageLabel.text = ("\(pagesIndex + 1) / \((people.count - 1) / 36 + 1)")
        collectionView.reloadData()
    }
    
    @IBAction func addContact(_ sender: Any) {
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactCollectionViewCell
        // Configure the cell
        cell.layer.cornerRadius = 3
        cell.cellLabel.text = people[36 * pagesIndex + indexPath.row].company
        cell.backgroundColor = #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditContactTableViewController
        if segue.identifier == "modifyContact" {
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            controller?.contact = people[(indexPath?.row)!]
            controller?.edit = true
            controller?.index = Int64(people[(indexPath?.row)!].id)
            
        }else{
            controller?.edit = false
        }
    }
    
    
    
}

