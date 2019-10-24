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
    
    var lib: String?
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setViews()
      }
    
    private func setViews() {
        guard let lib = lib else {return}
        libTextView.text = lib
        libTitle.text = "I can do that in a week!"
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let lib = lib else {return}
        
        #warning("Austin, your id peoperty should be optional. It is not given until you actually post to the server.")
       // controller.createLib(lib: lib, id: <#T##Int32#>, categoryID: <#T##Int32#>, context: CoreDataStack.share.mainContext)
    }
}
