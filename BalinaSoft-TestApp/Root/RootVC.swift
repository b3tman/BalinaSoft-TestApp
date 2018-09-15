//
//  RootVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import MMDrawController

class RootVC: MMDrawerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setMainWith(identifier: "Photo")
        super.setLeftWith(identifier: "Slider", mode: .frontWidthRate(r: 0.8))
    }
    
    
    
    
}
