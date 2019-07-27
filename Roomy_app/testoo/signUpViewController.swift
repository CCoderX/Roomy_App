//
//  signUpViewController.swift
//  Roomy_app
//
//  Created by user on 7/27/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Alamofire
class signUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 15
        backButton.layer.cornerRadius = 10
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        if let email =  emailTextField.text , let password = passwordTextField.text ,let passwordConfirm = passwordConfirmTextField.text {
            if !email.isEmpty && !password.isEmpty && passwordConfirm.isEmpty{
                if passwordConfirm == password{
                    let requestParameters = ["email":email,
                                             "password" : password ]
                    AF.request(APIRouter.signUp(requestParameters)).responseJSON { (response) in
                        switch response.result{
                        case .success(let Success):
                            print(Success)
                            self.dismiss(animated: true, completion: nil)
                        case .failure(let Failure):
                            print(Failure)
                        }
                    }
                    
                }
            }
        }
    }

}
