//
//  DevLibRepresentation.swift
//  DevLibs
//
//  Created by Austin Potts on 10/22/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


//MARK: - DevLib Core Data Model Representation
struct DevLibRepresentation: Codable {
    
    let lib: String
    let id: Int32
    let categoryID: Int32
    
}
