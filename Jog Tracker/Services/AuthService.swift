//
//  AuthService.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    private let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: "isLoggedIn")
        }
        set {
            defaults.set(newValue, forKey: "isLoggedIn")
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: "authToken") as! String
        }
        set {
            defaults.set(newValue, forKey: "authToken")
        }
    }
    
    func loginUser(uuid: String, completion: @escaping (_ success: Bool) -> ()) {
        let body = [
            "uuid": uuid
        ]
        
        Alamofire.request("https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin", method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data else {
                completion(false)
                return
            }
            do {
                let json = try JSON(data: data)
                let response = json["response"]
                self.authToken = response["access_token"].stringValue
                self.isLoggedIn = true
                completion(true)
            } catch (let exception) {
                completion(false)
                debugPrint(exception)
            }
        }
    }
    
}
