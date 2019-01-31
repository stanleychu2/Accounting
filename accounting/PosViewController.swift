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

class PosViewController: UIViewController{
    
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
