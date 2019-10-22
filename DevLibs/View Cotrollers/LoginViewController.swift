//
//  LoginViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var loginController: LoginController?
    
    
    //MARK: Button Tapped Outlet Action
    
//    guard let username = usernameTextField.text,
//               let password = passwordTextField.text,
//                 !username.isEmpty,
//                  !password.isEmpty else{return}
//
//           let user = User(username: username, password: password)
    
    
    
    
    //MARK: ViewController SignUp + Sign In
    func signUp(with user: UserRepresentation) {
           loginController?.signUp(with: user, completion: { (error) in
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
           loginController?.signIn(with: user, completion: { (error) in
               if let error = error {
                   NSLog("Error\(error)")
                   
               } else {
                   DispatchQueue.main.async {
                       self.dismiss(animated: true, completion: nil)
                   }
               }
           })
       }
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
