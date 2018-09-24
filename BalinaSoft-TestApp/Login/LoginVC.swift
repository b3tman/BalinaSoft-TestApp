//
//  LoginVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FormToolbar

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    
    //MARK: - Properties
    var tapGestureRecognizer: UITapGestureRecognizer?
    private lazy var toolbar: FormToolbar = {
        return FormToolbar(inputs: self.inputs)
    }()
    private var inputs: [FormInput] {
        guard let login = loginTextField, let password = passwordTextField else { return [UITextField()] }
        return [login, password]
    }
    private weak var activeInput: FormInput?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerForKeyboardNotifications()
    }
    
    //MARK: - Private
    private func configure() {
        loginButton?.addShadow(offset: CGSize(width: 0, height: 2), color: .black, radius: 3.0, opacity: 0.5)
        loginTextField?.delegate = self
        passwordTextField?.delegate = self
        toolbar.direction = .upDown
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        if let tapGestureRecognizer = tapGestureRecognizer {
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardInfo = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 16.0, right: 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView?.contentInset = .zero
        scrollView?.scrollIndicatorInsets = .zero
    }
    
    @objc func closeKeyboard() {
        view.endEditing(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: UIButton) {
        guard let login = loginTextField?.text, let password = passwordTextField?.text else { return }
        SERVER_MANAGER.executeRequest(for: loginUser, with: login, and: password) { [weak self] result, isAuthorized in
            if isAuthorized {
                UserDefaults.standard.set(true, forKey: authorizedKey)
                let rootVC = RootVC.loadFromStoryboard(with: RootVC.className)
                self?.present(rootVC, animated: true)
            } else {
                self?.presentAlertController("ERROR", message: "User with this name don't exist")
            }
        }
    }
    

}

extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        toolbar.update()
        activeInput = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        toolbar.goForward()
        return true
    }
}

extension LoginVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Login")
    }
    
}
