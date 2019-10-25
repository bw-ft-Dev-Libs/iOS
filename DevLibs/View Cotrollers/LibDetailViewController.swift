//
//  LibDetailViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class LibDetailViewController: UIViewController {
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var libTextView: UITextView!
    @IBOutlet weak var libTitle: UILabel!
    @IBOutlet weak var saveLibButton: UIButton!
    
    let controller = DevLibController.shared
    
    var devLib: DevLib?
    
    var lib: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews() {
        if let devLib = devLib {
            libTitle.text = "I can do that in a week!"
            libTextView.text = devLib.lib
            
        } else {
            guard let lib = lib else {return}
            libTextView.text = lib
            libTitle.text = "I can do that in a week!"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let lib = libTextView.text else {return}
        
        // your id peoperty should be optional. It is not given until you actually post to the server.")
        controller.createLib(lib: lib, context: CoreDataStack.share.mainContext)
    }
    
    
    
    
}
