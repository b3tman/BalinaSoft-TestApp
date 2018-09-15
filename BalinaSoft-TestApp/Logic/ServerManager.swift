//
//  ServerManager.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 11.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let SERVER_MANAGER = ServerManager.sharedInstanse

typealias Completion = (_ result: String?, _ isAuthorized: Bool) -> Void

class ServerManager: NSObject {
    
    static let sharedInstanse: ServerManager = ServerManager()
    
    func executeRequest(for action: String, with login: String, and password: String, completion: @escaping Completion) {
        let parameters = ["login": login,
                       "password": password]
        
        Alamofire.request(serverURL + action, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                if let data = JSON(data).dictionary?["data"] {
                    AUTH_MANAGER.userName = data["login"].stringValue
                    AUTH_MANAGER.sessionToken = data["token"].stringValue
                    completion(nil, true)
                } else if let error = JSON(data).dictionary?["valid"] {
                    let errorMessage = self.detectErrors(data: error)
                    completion(errorMessage, false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func detectErrors(data: JSON) -> String? {
        var errorString = ""
        guard let responseArray = data.array else { return nil }
        for value in responseArray {
            errorString += value["field"].stringValue + " " + value["message"].stringValue + " "
        }
        return errorString
    }
    
}
