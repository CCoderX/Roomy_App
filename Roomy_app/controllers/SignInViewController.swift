//
//  Sign In ViewController.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import  Alamofire
class SignInViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 15
        if Authorizer.checkToken() {
            self.performSegue(withIdentifier: "roomsSegue", sender: nil)
        }
        else {
            print("invalid token")
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
