//
//  LoginVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension LoginVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Login")
    }
    
}
