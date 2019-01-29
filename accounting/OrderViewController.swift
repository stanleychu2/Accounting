//
//  SecondViewController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/17.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import SQLite

class collectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCellLabel: UILabel!
}

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var meatBtn: UIButton!
    @IBOutlet weak var vegetableBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeader: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    let productDB = Table("product")
    
    // table 中有哪一些欄位和型態
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let type = Expression<String>("type")
    let pages = Expression<Int64>("pages")
    let position = Expression<Int64>("position")
    
    var item = [String](repeating: "", count: 25)
    
    // ["青椒", "小白菜", "空心菜", "大陸妹", "A 菜",
    // "山蘇", "芥蘭菜", "菜心", "大黃瓜", "四季豆",
    // "皇帝豆", "苦瓜", "地瓜葉", "芋頭", "莧菜",
    // "絲瓜", "青江菜", "金針菇", "茼蒿", "萵苣",
    // "龍鬚菜", "", "", "", ""]
    
    var selectedType = "蔬菜"
    var timer: Timer!
    var pagesIndex: Int64 = 1
    // 只有第一次會進入畫面的時候執行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
            print("name: \(product[name])")
        }
        
        var now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd     HH:mm:ss"
        var time = formatter.string(from: now)
        timeLabel.text = time
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        
        tableView.layer.masksToBounds = true
        // table 的 seperator 上下左右不要有邊界
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 2.0
        
        tableHeader.layer.borderWidth = 0.5
        tableHeader.layer.borderColor = UIColor.gray.cgColor
        
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        
        // 每一秒更新一次畫面上的時間
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            now = Date()
            time = formatter.string(from: now)
            
            self.timeLabel.text = time
//            print(time)
        }
    }
    
    // 每次進入畫面都會執行
    override func viewDidAppear(_ animated: Bool) {
        // timer 繼續計時
        timer.fireDate = Date.distantPast
        updateCollection()
    }
    
    // 畫面已經離開螢幕所做的事
    override func viewDidDisappear(_ animated: Bool) {
        // 停止每秒更新一次時間
        timer.fireDate = Date.distantFuture
        //  timer.invalidate() 直接摧毀 timer 的這個功能不能再開始
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
//        <#code#>
//    }
    
    // 傳遞資料到不同的頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "orderPopOverSegue") {
            let controller = segue.destination as? OrderPopOverView
            
            controller?.productName = item[(collectionView.indexPathsForSelectedItems?[0].row)!]
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        
        //  cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.backgroundColor = (item[indexPath.row] == "") ? UIColor.gray : #colorLiteral(red: 0.9024838209, green: 0.6174634099, blue: 0.1791247427, alpha: 1)
        
        cell.collectionCellLabel.textColor = UIColor.white
        cell.collectionCellLabel.text = item[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(item[indexPath.row] != "") {
            performSegue(withIdentifier: "orderPopOverSegue", sender: nil)
        }
        //  collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // 當 type 或是 pages 改變時更新 collection 的內容
    func updateCollection() {
        
        item = [String](repeating: "", count: 25)
        let dbResult = productDB.filter(type == selectedType && pages == pagesIndex)
        for product in (try? db?.prepare(dbResult))!! {
            item[Int(product[position]) - 1] = product[name]
        }
        collectionView.reloadData()
    }
    
    @IBAction func previousPagesBtn(_ sender: UIButton) {
        if(pagesIndex > 1) {
            pagesIndex -= 1
            pagesLabel.text = "\(pagesIndex) / 4"
            
            updateCollection()
        }
    }
    
    @IBAction func nextPagesBtn(_ sender: UIButton) {
        if(pagesIndex < 4) {
            pagesIndex += 1
            pagesLabel.text = "\(pagesIndex) / 4"
            
            updateCollection()
        }
    }
    
    @IBAction func chooseVegetable(_ sender: UIButton) {
        vegetableBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "蔬菜"
        
        updateCollection()
    }
    
    @IBAction func chooseMeat(_ sender: UIButton) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        otherBtn.backgroundColor = UIColor.lightGray
        selectedType = "肉類"
        
        updateCollection()
    }
    
    @IBAction func chooseOther(_ sender: UIButton) {
        vegetableBtn.backgroundColor = UIColor.lightGray
        meatBtn.backgroundColor = UIColor.lightGray
        otherBtn.backgroundColor = #colorLiteral(red: 0.663232584, green: 0, blue: 0.4050840328, alpha: 1)
        selectedType = "雜項"
        
        updateCollection()
    }
    
}
