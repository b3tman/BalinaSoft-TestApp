//
//  AuthManager.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 09.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation

let AUTH_MANAGER = AuthManager.shared

class AuthManager: NSObject {
    
    static let shared: AuthManager = AuthManager()
    
    var userName: String?
    var sessionToken: String? {
        get {
            return UserDefaults.standard.value(forKey: "sessionToken") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sessionToken")
            UserDefaults.standard.synchronize()
        }
    }
    
}
