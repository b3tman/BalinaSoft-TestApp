//
//  RegisterVC.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FormToolbar

class RegisterVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var signUpButton: UIButton?
    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var enterPasswordTextField: UITextField?
    @IBOutlet var confirmPasswordTextField: UITextField?
    
    @IBOutlet var errorLabel: UILabel? {
        didSet {
            errorLabel?.isHidden = true
        }
    }
    
    //MARK: - Properties
    var tapGestureRecognizer: UITapGestureRecognizer?
    private lazy var toolbar: FormToolbar = {
        return FormToolbar(inputs: self.inputs)
    }()
    private var inputs: [FormInput] {
        guard let register = loginTextField, let enterPassword = enterPasswordTextField, let confirmPassword = confirmPasswordTextField else { return [UITextField()] }
        return [register, enterPassword, confirmPassword]
    }
    private weak var activeInput: FormInput?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerForKeyboardNotifications()
    }
    
    private func configure() {
        signUpButton?.addShadow(offset: CGSize(width: 0, height: 2), color: .black, radius: 3.0, opacity: 0.5)
        loginTextField?.delegate = self
        enterPasswordTextField?.delegate = self
        confirmPasswordTextField?.delegate = self
        toolbar.direction = .upDown
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        if let tapGestureRecognizer = tapGestureRecognizer {
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardInfo = userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue
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
    @IBAction func signUpAction(_ sender: UIButton) {
        guard let login = loginTextField?.text, let password = confirmPasswordTextField?.text else { return }
        SERVER_MANAGER.executeRequest(for: registerUser, with: login, and: password) { [weak self] result, isAuthorized in
            if isAuthorized {
                self?.errorLabel?.isHidden = true
                UserDefaults.standard.set(true, forKey: authorizedKey)
                let rootVC = RootVC.loadFromStoryboard(with: RootVC.className)
                self?.present(rootVC, animated: true)
            } else {
                self?.errorLabel?.isHidden = false
                self?.errorLabel?.text = result
            }
        }
    }
    
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        toolbar.update()
        activeInput = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        toolbar.goForward()
        return true
    }
}

extension RegisterVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Register")
    }
}
