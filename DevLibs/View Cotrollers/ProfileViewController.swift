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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        libsTableView.delegate = self
        libsTableView.dataSource = self
    }
    

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
