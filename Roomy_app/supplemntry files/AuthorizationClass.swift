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
            case .failure( _):
                //self.showAlert(title: "Sign In problem", message: "Enter valid email and password")
                returnedValue = false
            }
        }
        return returnedValue
    }
    static func SignUp(email: String, password: String , returned : @escaping(_ result: Bool,_ message: String)-> Void){
        let requestParameters = ["email":email,
                                 "password" : password ]
        AF.request(APIRouter.signUp(requestParameters)).responseJSON { (response) in
            switch response.result{
            case .success(let Success):
                print(Success)
                returned(true ,Success as! String)
            case .failure(let Failure):
                print(Failure)
                returned(false,Failure as! String)

            }
        }
    }
    static func checkToken()-> Bool {
        var returned = false
        if let token = UserDefaults.standard.string(forKey: "token") {
            AF.request(APIRouter.getAllRooms(["Authorization" : token])).validate().responseJSON { (response) in
                switch response.result{
                case .success( _):
                    returned = true
                case .failure( _):
                    returned = false
                }
            }
        }
        return returned
    }
}
