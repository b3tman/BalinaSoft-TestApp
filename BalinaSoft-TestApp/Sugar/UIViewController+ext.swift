//
//  UIViewController+ext.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 08.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    var nearestNavigationController: UINavigationController? {
        var navController: UINavigationController? = nil
        var viewController: UIViewController? = self
        while viewController != nil && navController == nil {
            navController = viewController?.navigationController
            viewController = viewController?.parent
        }
        return navigationController
    }
    
    func presentAlertController(_ title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { [unowned alertController] _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertController(_ title: String?, message: String?, delay: Double) {
        if delay == 0 {
            self.presentAlertController(title, message: message)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.presentAlertController(title, message: message)
        })
    }
    
    func showShareMenu() {
        let message = "Share options"
        let objectsToShare = [message]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    static func loadFromStoryboard<VC: UIViewController>(with storyboardName: String) -> VC {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.className) as! VC
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
