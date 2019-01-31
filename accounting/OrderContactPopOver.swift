//
//  OrderContactPopOver.swift
//  accounting
//
//  Created by 邱斯 on 2019/1/31.
//  Copyright © 2019 邱斯. All rights reserved.
//

import UIKit

@objc protocol ContactpopOverReturnDataDelegate {
    func clearData()
}

class OrderContactPopOver: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func con(_ sender: Any) {
       
        print(10)
        delegate?.clearData()
        print(11)
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
}
