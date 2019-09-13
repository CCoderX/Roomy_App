//
//  Sign In ViewController.swift
//  Roomy_app
//
//  Created by user on 7/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import  Alamofire
protocol SignInView {
    func showAlert(title : String , message : String)
    func navigateToHome()
}
protocol SignInPresenter {
    func SignIn(email : String? ,password : String?)
    func checkToken()->Bool
    
}
class SignInPresenterImplementation : SignInPresenter {
    
    var view : SignInView
    init(view : SignInView) {
        self.view = view
    }
    
    
    func checkToken() -> Bool {
        return Authorizer.checkToken()
    }
    
    func SignIn(email : String? ,password : String?) {
        if let mail = email, let pass = password{
            if !mail.isEmpty && !pass.isEmpty
            {
                if !Authorizer.SignIn(email: mail, password: pass) {
                    view.navigateToHome()
                }
                    
                else {
                    view.showAlert(title: "Incorrect Data", message: "Enter valid Email and password")
                }
            }
            else{
                view.showAlert(title: "Missing Data", message: "Enter Email and password")
            }
        }
        
        
    }
}
class SignInViewController: UIViewController ,SignInView {
    
    var presenter : SignInPresenter?
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignInPresenterImplementation(view: self)
        signInButton.layer.cornerRadius = 15
        
    }
    deinit {
        presenter = nil
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        presenter?.SignIn(email: emailTextField.text, password: passwordTextField.text)
    }
    
    func navigateToHome() {
        performSegue(withIdentifier: "roomsSegue", sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}


