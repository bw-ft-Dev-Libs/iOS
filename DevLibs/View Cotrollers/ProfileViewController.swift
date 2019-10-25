//
//  ProfileViewController.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addLibButton: UIButton!
    @IBOutlet weak var libsTableView: UITableView!
    
    //MARK: Properties
    
    
    let token: String? = KeychainWrapper.standard.string(forKey: "bearer")
    
    let loggedIn = UserDefaults.standard.bool(forKey: "LoggedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        libsTableView.delegate = self
        libsTableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.usernameLabel.text = "Welcome back, \(KeychainWrapper.standard.string(forKey: "username") ?? "")!"

    }
    
     @IBAction func unwindToInfo(_ unwindSegue: UIStoryboardSegue) {}
    

    //MARK: - Fetch Results Controller
    
    lazy var fetchResultController: NSFetchedResultsController<DevLib> = {
        
        //Create Fetch request
        let fetchRequest: NSFetchRequest<DevLib> = DevLib.fetchRequest()
        
        //Sort the fetched results
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lib", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.share.mainContext, sectionNameKeyPath: "lib", cacheName: nil)
        
        frc.delegate = self
        
        do{
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        
        return frc
        
    }()
    
    // MARK: Private Funcs
    
    private func setViews() {
        
        
        DispatchQueue.main.async {
            
            self.usernameLabel.text = "Welcome back, \(KeychainWrapper.standard.string(forKey: "username") ?? "")!"
            
            if self.loggedIn == false {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
        }
        profileImageView.maskCircle(anyImage: profileImageView.image ?? UIImage(named: "woman")!)
        
        addLibButton.layer.cornerRadius = 14
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LibDetailSegue" {
            guard let destinationVC = segue.destination as? LibDetailViewController,
                let indexPath = libsTableView.indexPathForSelectedRow  else {return}
            destinationVC.devLib = fetchResultController.object(at: indexPath)
        }
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibCell", for: indexPath)
        
        let lib = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = lib.lib
        cell.textLabel?.textColor = .white
        return cell
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


extension ProfileViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        libsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        libsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else{return}
            libsTableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .delete:
            guard let indexPath = indexPath else{return}
            libsTableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else{return}
            libsTableView.moveRow(at: indexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else{return}
            libsTableView.reloadRows(at: [indexPath], with: .automatic)
            
        @unknown default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let sectionSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            libsTableView.insertSections(sectionSet, with: .automatic)
            
        case .delete:
            libsTableView.deleteSections(sectionSet, with: .automatic)
            
        default: return
        }
        
    }
    
}
