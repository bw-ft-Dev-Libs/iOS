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
    
    
    var isLogin: Bool = true
    var loginController = LoginController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    //MARK: ViewController SignUp + Sign In
    func signUp(with user: UserRepresentation) {
           loginController.signUp(with: user, completion: { (error) in
               if let error = error{
                   NSLog("Error signing up \(error)")
               } else {
                   let alert = UIAlertController(title: "Sign Up Success", message: "Sign in now please", preferredStyle: .alert)
                   
                   let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                   
                   alert.addAction(okAction)
                   
                   
               }
               
           })
           
       }
       
       func signIn(with user: UserRepresentation){
           loginController.signIn(with: user, completion: { (error) in
               if let error = error {
                   NSLog("Error\(error)")
                   
               } else {
                   DispatchQueue.main.async {
                       self.dismiss(animated: true, completion: nil)
                   }
               }
           })
       }
       

   
    // MARK: Private Funcs
    
    private func setViews() {
        
    }
    

    
    //MARK:  Login Button Tapped Outlet Action
    @IBAction func loginButtonTapped(_ sender: UIButton) {

        
        guard let username = usernameTextField.text,
                   let password = passwordTextField.text,
                     !username.isEmpty,
                      !password.isEmpty else{return}
    
        let user = UserRepresentation(username: username, password: password)
        
        isLogin = !isLogin
        
        if isLogin == true {
            signIn(with: user)
        } else {
            signUp(with: user)
        }
        
        
        
    }
    
    //MARK: Register Button Tapped Outlet Action
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        
        guard let username = usernameTextField.text,
                       !username.isEmpty,
             let password = passwordTextField.text,
                       !password.isEmpty else { return }
        
        let user = UserRepresentation(username: username, password: password)
        
        loginController.signUp(with: user) { (error) in
            if let error = error {
                NSLog("Error logging in: \(error)")
            }
        }
        
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let destinationVC = segue.destination as? ProfileViewController  else {return}
        }
    }
}
