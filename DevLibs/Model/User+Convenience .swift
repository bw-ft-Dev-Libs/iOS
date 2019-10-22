//
//  User+Convenience .swift
//  DevLibs
//
//  Created by Austin Potts on 10/22/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import CoreData


extension User {
    
    //MARK: - Initializing Representation of Core Data Model
    var userRepresentation: UserRepresentation? {
        
        guard let username = username,
            let password = password else {return nil}
        
        return UserRepresentation(username: username, password: password)
    }
    
    
    //MARK: - Convenience Initializer
    @discardableResult convenience init(username: String, password: String, context: NSManagedObjectContext){
        
        self.init(context: context)
        
        self.username = username
        self.password = password
    }
    
    //MARK: - Conveneicne Initializer for Core Data Model Representation
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext){

        self.init(username: userRepresentation.username, password: userRepresentation.password, context: context)
        
    }
    
    
}
