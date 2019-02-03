//
//  PosViewController.swift
//  accounting
//
//  Created by sam on 2019/1/31.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

class ContactCollectionCell: UICollectionViewCell{
    @IBOutlet weak var cellLabel: UILabel!
    
}

class ProductCollectionCell: UICollectionViewCell{
    @IBOutlet weak var cellLabel: UILabel!
    
}

class PosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
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
    
    var item = [String](repeating: "", count: 25)
    var pagesIndex: Int64 = 1
    var selectedType = "蔬菜"
    var people = ["AAA","BBB","CCC","DDD","EEE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        OrderTableView.layer.borderColor = UIColor.gray.cgColor
        OrderTableView.layer.borderWidth = 2.0
        OrderTableHeader.layer.borderWidth = 0.5
        OrderTableHeader.layer.borderColor = UIColor.gray.cgColor
        ContactCollectionView.layer.borderWidth = 1
        ContactCollectionView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        // Do any additional setup after loading the view.
        
        ContactCollectionView.delegate = self
        ContactCollectionView.dataSource = self
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        
        self.view.addSubview(ContactCollectionView)
        self.view.addSubview(ProductCollectionView)
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
                contactCell.cellLabel.text = people[indexPath.row]
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
    
    @IBAction func previousPage(_ sender: Any) {
        if(pagesIndex > 1) {
            pagesIndex -= 1
            pageLabel.text = "\(pagesIndex) / 4"
            
            //updateCollection()
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if(pagesIndex < 4) {
            pagesIndex += 1
            pageLabel.text = "\(pagesIndex) / 4"
            
            //updateCollection()
        }
    }
    
    @IBAction func chooseVegetable(_ sender: Any) {
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "蔬菜"
        
        //updateCollection()
    }
    
    @IBAction func chooseMeat(_ sender: Any) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "肉類"
        
        //updateCollection()

    }
    
    @IBAction func chooseOthers(_ sender: Any) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        selectedType = "雜項"
        
        //updateCollection()
    }
    
    
    

    
}
