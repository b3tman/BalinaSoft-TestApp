//
//  LoginVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 08.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        configureVC()
        super.viewDidLoad()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let loginVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: LoginVC.className)
        let registerVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: RegisterVC.className)
        
        return [loginVC,registerVC]
    }
    
    //MARK: - Private
    private func configureVC() {
        settings.style.buttonBarBackgroundColor = UIColor.init(hexString: "#8bc34a")
        settings.style.buttonBarItemBackgroundColor = UIColor.init(hexString: "#8bc34a")
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 17)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 5
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarMinimumInteritemSpacing = 0
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(white: 1.0, alpha: 0.5)
            newCell?.label.textColor = .white
    }
    }
}
