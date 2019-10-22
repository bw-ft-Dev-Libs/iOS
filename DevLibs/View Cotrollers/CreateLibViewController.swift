//
//  CreateLibViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class CreateLibViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var wordTypeView: UIView!
    @IBOutlet weak var wordTypeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: Properties
    
    var duration: Double { return 1 }
    
    var isDoneWithLib: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    // MARK: Private Funcs
    
    private func moveOff(view: UIView) {
        view.center.y -= 400
    }
    
    private func moveOn(view: UIView) {
        view.center.y += 400
    }
    
    private func setViews() {
        
        wordTypeView.layer.cornerRadius = 6
        saveButton.isHidden = true
        saveButton.layer.cornerRadius = 6
        
        nextButton.layer.cornerRadius = 6
   
        wordTypeView.center = CGPoint(x: view.frame.width/2, y: -view.frame.height/2)
        
        UIView.animate(withDuration: duration, delay: 0, options: .autoreverse, animations: {
            self.moveOn(view: self.wordTypeView)})
        
    }
    // MARK: IBActions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if isDoneWithLib == false {
            UIView.animate(withDuration: duration, delay: 0, options: .autoreverse, animations: {
                self.moveOff(view: self.wordTypeView)
            }) { (_) in
                self.moveOn(view: self.wordTypeView)
            }
        } else {
            performSegue(withIdentifier: "NewLibDetailSegue", sender: self)
        }
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewLibDetailSegue" {
            guard let destinationVC = segue.destination as? LibDetailViewController  else {return}
        }
    }
}
