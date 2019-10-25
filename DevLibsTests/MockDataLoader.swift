//
//  MockDataLoader.swift
//  DevLibsTests
//
//  Created by Alex Rhodes on 10/25/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
@testable import DevLibs

class MockDataLoader: NetworkDataLoader {
    
    var request: URLRequest?
    var data: Data?
    var error: Error?
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: url)
        
        self.request = request
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
}
