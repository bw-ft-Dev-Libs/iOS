//
//  NDL.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/25/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    
    func loadData(from request: URLRequest, completion: @escaping( Data?, Error?) -> Void)
    
    func loadData(from url: URL, completion: @escaping( Data?, Error?) -> Void)
    
}
