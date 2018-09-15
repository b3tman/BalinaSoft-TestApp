//
//  RootVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: authorizedKey)
        let initialViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        self.present(initialViewController!, animated: true)
    }
    
    @IBAction func printToken(_ sender: UIButton) {
        print(AUTH_MANAGER.sessionToken!)
    }
    
    
}
