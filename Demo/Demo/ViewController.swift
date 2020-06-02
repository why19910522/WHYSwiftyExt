//
//  ViewController.swift
//  Demo
//
//  Created by 王洪运 on 2020/6/2.
//  Copyright © 2020 WHY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func fontDemo() {
        let label = UILabel()
        label.font = Font.bold.15
    }
    
    func colorDemo() {
        let label = UILabel()
        label.textColor = Color.hex.0xffffff
        label.backgroundColor = Color.hex.0x00ff0050
    }
    
}

