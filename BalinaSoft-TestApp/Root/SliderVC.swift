//
//  SliderVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 15.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import MMDrawController

class SliderVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tableView: UITableView?
    @IBOutlet var userNameLabel: UILabel?
    
    //MARK: - Properties
    let slidesMenuArray = [(#imageLiteral(resourceName: "photosImage"), "Photos"),(#imageLiteral(resourceName: "mapImage") , "Map")]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel?.text = AUTH_MANAGER.userName
        tableView?.estimatedRowHeight = 80.0
        tableView?.rowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: - Actions
    @IBAction func logOutAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: authorizedKey)
        let initialViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        self.present(initialViewController!, animated: true)
    }

}

extension SliderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let drawer = self.drawer() {
            drawer.showLeftSlider(isShow: false)
            if indexPath.row == 0 {
                drawer.setMainWith(identifier: "Photo")
            } else {
                drawer.setMainWith(identifier: "Map")
            }
        }
    }
}

extension SliderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidesMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as? SliderCell else { return UITableViewCell() }
        cell.menuImage?.image = slidesMenuArray[indexPath.row].0
        cell.menuTextLabel?.text = slidesMenuArray[indexPath.row].1
        
        return cell
    }
}

