//
//  UserRepresentation.swift
//  DevLibs
//
//  Created by Austin Potts on 10/22/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

struct Results: Codable {
    let token: String
}
//MARK: - User Core Data Model Representation
struct UserRepresentation: Codable {
    
    let username: String
    let password: String
    
}
