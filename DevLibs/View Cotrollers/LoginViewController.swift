//
//  LoginViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: Private Funcs
    
    private func setViews() {
        
    }
    
    // MARK: IBActions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let destinationVC = segue.destination as? ProfileViewController  else {return}
        }
    }
}
