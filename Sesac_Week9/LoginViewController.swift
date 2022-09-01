//
//  LoginViewController.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //바인딩
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .red : .yellow
        }
    }
    
    @IBAction func nameTextFieldTapped(_ sender: UITextField) {
        
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    @IBAction func passwordTextFieldTapped(_ sender: UITextField) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    @IBAction func emailTextFieldTapped(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    @IBAction func tapLoginButton(_ sender: UIButton) {
        viewModel.signIn {
            //화면전환 코드 등
        }
    }
}
