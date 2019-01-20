//
//  ProductViewController.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/18.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit
import ZHDropDownMenu

struct Product {
    var name: String
    var type: String
    var pages: Int
    var position: Int
}

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ZHDropDownMenuDelegate {
    
    // 新增 outlet 可以設定樣式和做一些控制利用 contrl 拉到 view controller 裡
    @IBOutlet weak var vegetableMenu: ZHDropDownMenu!
    @IBOutlet weak var newProduct_btn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 2.0
        
        newProduct_btn.layer.cornerRadius = 10
        
        vegetableMenu.options = ["蔬菜", "肉類", "雜項"] //设置下拉列表项数据
//        menu1.menuHeight = 240;//设置最大高度
        vegetableMenu.showBorder = true
        vegetableMenu.editable = false //可编辑
        vegetableMenu.layer.cornerRadius = 5
    
        vegetableMenu.delegate = self //设置代理
    }

    //选择完后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didSelect index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didEdit text: String) {
        print("\(menu) input text \(text)")
    }
    
    var item = ["小番茄  妳好", "高麗菜", "茄子", "空心菜"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    // 每一個 section 有幾個 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count;
    }
    
    // 設定 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = item[indexPath.row]
        
        return cell!
    }
}
