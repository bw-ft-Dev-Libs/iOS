//
//  LoginViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import CoreData



class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var registerLoginLabel: UILabel!
    
    
    var isLogin: Bool = true
    var loginController = LoginController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    
    
    //MARK: Method SignUp + Sign In
    
    func signUp(with user: UserRepresentation) {
        loginController.signUp(with: user, completion: { (error) in
    
            if let error = error{
                NSLog("Error signing up \(error)")
            }
            
            self.signIn(with: user)
            
        })
        
    }
    
    func signIn(with user: UserRepresentation){
        loginController.signIn(with: user, completion: { (error, _)  in
            
            if let error = error {
                NSLog("Error: \(error)")
                
                
            } else {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    
    
    // MARK: Private Funcs
    
    private func setViews() {
        passwordTextField.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 30
        loginButton.layer.shadowColor = UIColor.white.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        loginButton.layer.shadowOpacity = 0.1
        loginButton.layer.shadowRadius = 0.0
        loginButton.layer.masksToBounds = false
       
    }
    
    
    
    //MARK:  IBActions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty else{return}
        
        let user = UserRepresentation(username: username, password: password)
        
        
        
        if isLogin == true {
            signIn(with: user)
        } else {
            signUp(with: user)
        }
        
        
        
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        
        isLogin = !isLogin
        
        if isLogin == true {
            loginButton.setTitle("LOGIN", for: .normal)
            registerLoginLabel.text = "If you have not registered, please click"
        } else {
            loginButton.setTitle("REGISTER", for: .normal)
            registerLoginLabel.text = "If you would like to login, please click"
        }
    }
}
