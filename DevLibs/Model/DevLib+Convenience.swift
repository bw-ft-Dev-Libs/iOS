//
//  DevLib+Convenience.swift
//  DevLibs
//
//  Created by Austin Potts on 10/22/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import CoreData


extension DevLib {
    
    //MARK: - Initializing Core Data Model Representation
    var devLibRepresentation: DevLibRepresentation? {
        guard let lib = lib
            else {return nil}
        
        return DevLibRepresentation(lib: lib, id: id, categoryID: categoryID)
    }
    
    //MARK: - Convenience Initializer
    @discardableResult convenience init(lib: String, id: Int32? = nil , categoryID: Int32? = nil , context: NSManagedObjectContext = CoreDataStack.share.mainContext) {
        
        self.init(context: context)
        
        self.lib = lib
        
        if let id = id,
            let categoryID = categoryID {
            self.id = id
            self.categoryID = categoryID
        }
        
    }
    
    //MARK: - Convenience Initializer for Core Data Model Representation
    @discardableResult convenience init?(devLibRepresentation: DevLibRepresentation, context: NSManagedObjectContext) {
        
        self.init(lib: devLibRepresentation.lib, id: devLibRepresentation.id, categoryID: devLibRepresentation.categoryID, context: context)
        
    }
    
    
    
}
