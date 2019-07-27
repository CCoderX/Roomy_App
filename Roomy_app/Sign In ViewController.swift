//
//  Sign In ViewController.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import  Alamofire
class Sign_In_ViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 15
        if let token = UserDefaults.standard.string(forKey: "token"){
            AF.request(APIRouter.getAllRooms(["Authorization" : token])).validate().responseJSON { (response) in
                switch response.result{
                case .success(let results):
//                    let firstRoom = results as? [String:Any]
//                    self.showAlert(title: "logged in", message:"")
//                    print(results)
//                    roomsParser.getRooms()
                    self.performSegue(withIdentifier: "roomsSegue", sender: nil)
                case .failure(let error):
//                    self.showAlert(title: "not logged in", message: "")
                    print(error , token)
                }
            }
        }
        
    }
    
    func showAlert(title :String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            if !email.isEmpty && !password.isEmpty
            {
                AF.request(APIRouter.signIn(["email" : email , "password" : password])).responseJSON { (response) in
                    switch response.result{
                    case .success(let Success):
                        let json = Success as! [String :String]
                        let token = json["auth_token"]
                        print(token)
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(token, forKey: "token")
                        userDefaults.synchronize()
                        self.performSegue(withIdentifier: "roomsSegue", sender: nil)
                    case .failure(let failure):
                        self.showAlert(title: "Sign In problem", message: "Enter valid email and password")
                    }
                }
            }
            else{
                showAlert(title: "Missing Data", message: "Enter Email and password")
            }
        }
        else{
            showAlert(title: "Missing Data", message: "Enter Email and password")
        }
    }
    
    
}
