//
//  DevLibController.swift
//  DevLibs
//
//  Created by Austin Potts on 10/22/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import CoreData



class DevLibController {
    
    //MARK: Base API URL
    private let baseUrl = URL(string: "https://dev-libs-test.herokuapp.com")!
    
    
    
    //MARK: - Fetching DevLibs from server (GET)
       func fetchLibs(completion: @escaping(Result<[String], NetworkError>)-> Void){
           
//           guard let bearer = bearer else {
//               completion(.failure(.noToken))
//               return
//           }
           
           
           let requestURL = baseUrl.appendingPathComponent("api")
                                   .appendingPathComponent("devLib")
           
           var request = URLRequest(url: requestURL)
           request.httpMethod = HTTPMethod.get.rawValue
           
//           request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authoriaztion.rawValue)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               if let error = error {
                   NSLog("Error: \(error)")
                   completion(.failure(.otherError(error)))
                   return
               }
               
               if let response = response as? HTTPURLResponse,
                   response.statusCode != 200 {
                   completion(.failure(.responseError))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(.noData))
                   return
               }
               
               let decoder = JSONDecoder()
               
               do {
                   
                   let devLibs = try decoder.decode([String].self, from: data)
                   completion(.success(devLibs))
               } catch {
                   NSLog("Error decoding DevLibs: \(error)")
                   completion(.failure(.noDecode))
                   return
               }
               
               }.resume()
       }
       
       
       //MARK: - Add DevLib to Server (PUT)
       func putLib(devLib: DevLibRepresentation, completion: @escaping ()-> Void = { }){
           
           //Core Data needed
           
        let identifier = String(devLib.id)
        
           let requestURL = baseUrl
            .appendingPathComponent(identifier)
               .appendingPathExtension("json")
           
           var request = URLRequest(url: requestURL)
           request.httpMethod = HTTPMethod.put.rawValue
           
           //Conv. Init needed
//           guard let libRepresentation = devLib.libRepresentation else {
//               NSLog("Entry Representation is nil")
//               completion()
//               return
//           }
           
           do {
               request.httpBody = try JSONEncoder().encode(devLib)
           } catch {
               NSLog("Error encoding entry representation: \(error)")
               completion()
               return
           }
           
           URLSession.shared.dataTask(with: request) { (_, _, error) in
               
               if let error = error {
                   NSLog("Error PUTting task: \(error)")
                   completion()
                   return
               }
               
               completion()
               }.resume()
           
           
           
       }
       
       //MARK: - Delete DevLib from Server (DELETE)
       func deleteDevLibFromServer(_ devLib: DevLibRepresentation, completion: @escaping()-> Void = {}) {
           
           
//           guard let identifer = devLib.id else {
//               completion()
//               return
//           }
        let identifier = String(devLib.id)
           
           let requestURL = baseUrl.appendingPathComponent(identifier).appendingPathExtension("json")
           
           var request = URLRequest(url: requestURL)
           request.httpMethod = HTTPMethod.delete.rawValue
           
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let error = error {
                   NSLog("Error deleting Task from server: \(error)")
                   completion()
                   return
               }
               
               completion()
               }.resume()
           
       }
    
    
    
}

