//
//  OrderPopOverView.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/28.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit

class OrderPopOverView: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    var productName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = productName
        // Do any additional setup after loading the view.
    }
}
