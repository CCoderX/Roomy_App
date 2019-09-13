//
//  signUpViewController.swift
//  Roomy_app
//
//  Created by user on 7/27/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Alamofire
protocol SignUp: class{
    func signUp(email : String? , password : String?,passwordConfirm: String?)
}
class SignUpImplementation : SignUp {
    weak var view : SignUpView?
    init (view : SignUpView) {
        self.view = view
    }
    func signUp(email: String?, password: String? ,passwordConfirm: String?) {

        if let mail =  email , let pass = password ,let passConfirm = passwordConfirm {
            if !mail.isEmpty && !pass.isEmpty && !passConfirm.isEmpty{
                if passwordConfirm == password{
                    Authorizer.SignUp(email: mail, password: pass) { (result, message) in
                        if result {
                            self.view?.removeView()
                            return
                        }
                        else {
                            self.view?.showAlert(title: "Error", message: message)
                        }
                    }
                    
                }
            }
            view?.showAlert(title: "Incomplete Fields", message: "Complete All Fields")
        }
    }
}
protocol SignUpView :class{
    func removeView()
    func showAlert(title :String,message: String)
}

class SignUpViewController: UIViewController ,SignUpView {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var presenter: SignUp?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignUpImplementation(view: self)
        signUpButton.layer.cornerRadius = 15
        backButton.layer.cornerRadius = 10
    }
    func removeView() {
        dismiss(animated: true, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @IBAction func returnPressed(_ sender: Any) {
        removeView()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        presenter!.signUp(email: emailTextField.text, password: passwordTextField.text,passwordConfirm: passwordConfirmTextField.text)
        
    }

}
