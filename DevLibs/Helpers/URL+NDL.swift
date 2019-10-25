//
//  URL+NDL.swift
//  DevLibs
//
//  Created by Alex Rhodes on 10/25/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = self.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.sync {
                completion(data,error)
            }
        }
        task.resume()
    }
    
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = self.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.sync {
                completion(data,error)
            }
        }
        task.resume()
    }
}
