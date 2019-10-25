//
//  DevLibsTests.swift
//  DevLibsTests
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import XCTest
@testable import DevLibs

class DevLibsTests: XCTestCase {
    
    
    var bearer: Bearer?
    
    // Test for token
    // Test Register/Login

    func testLogin() {
        
        let mock = MockDataLoader()
        mock.data = validBearerJSON
        
        let controller = LoginController(dataLoader: mock)
        let resultsExpectation = expectation(description: "wait for results")
        
        let user = UserRepresentation(username: "demo1", password: "demo1")
        controller.signIn(with: user) { (error, bearer) in
            self.bearer = bearer
            resultsExpectation.fulfill()
        }
       
        wait(for: [resultsExpectation], timeout: 2)
        
        XCTAssertNotNil(bearer)
        XCTAssertTrue(bearer?.username == "demo1")
    }

}
