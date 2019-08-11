//
//  AuthorizationClass.swift
//  Roomy_app
//
//  Created by user on 8/10/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Alamofire
class Authorizer {
    static func SignIn(email: String, password: String) -> Bool {
        var returnedValue = false
        AF.request(APIRouter.signIn(["email" : email , "password" : password])).responseJSON { (response) in
            switch response.result{
            case .success(let Success):
                let json = Success as! [String :String]
                let token = json["auth_token"]
                let userDefaults = UserDefaults.standard
                userDefaults.set(token, forKey: "token")
                userDefaults.synchronize()
                returnedValue = true
                //self.performSegue(withIdentifier: "roomsSegue", sender: nil)
            case .failure(let failure):
                //self.showAlert(title: "Sign In problem", message: "Enter valid email and password")
                returnedValue = false
            }
        }
        return returnedValue
    }
    static func SignUp(email: String, password: String) {
        
    }
    static func checkToken()-> Bool {
        if let token = UserDefaults.standard.string(forKey: "token") {
            AF.request(APIRouter.getAllRooms(["Authorization" : token])).validate().responseJSON { (response) in
                switch response.result{
                case .success(let results):
                    return true
                case .failure(let error):
                    return false
                }
            }
        }
        else {
            return false
        }
    }
}
