//
//  MapVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 15.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showLeftAction() {
        if let drawer = self.drawer() ,
            let manager = drawer.getManager(direction: .left){
            let value = !manager.isShow
            drawer.showLeftSlider(isShow: value)
        }
    }

}
