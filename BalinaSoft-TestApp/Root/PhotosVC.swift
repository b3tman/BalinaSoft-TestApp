//
//  PhotosVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 15.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import MMDrawController

class PhotosVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showLeftAction() {
        if let drawer = self.drawer() ,
            let manager = drawer.getManager(direction: .left){
            let value = !manager.isShow
            drawer.showLeftSlider(isShow: value)
        }
    }
}
