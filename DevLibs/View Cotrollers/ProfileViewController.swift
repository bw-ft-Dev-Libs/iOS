//
//  ProfileViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addLibButton: UIButton!
    @IBOutlet weak var libsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "LoginSegue", sender: self)
        setViews()
        libsTableView.delegate = self
        libsTableView.dataSource = self
    }
    
    // MARK: Private Funcs
    
    private func setViews() {
        profileImageView.maskCircle(anyImage: profileImageView.image ?? UIImage(named: "avatar")!)
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let destinationVC = segue.destination as? LibDetailViewController  else {return}
        } else  if segue.identifier == "" {
            guard let destinationVC = segue.destination as? CreateLibViewController  else {return}
        }
    }
}
    extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
}

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = .scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}
