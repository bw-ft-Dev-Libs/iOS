//
//  DevLibsUITests.swift
//  DevLibsUITests
//
//  Created by Alex Rhodes on 10/21/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import XCTest
import DevLibs

class DevLibsUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testValidLoginSuccess() {
        let app = XCUIApplication()

        let validPassword = "demo1"
        let validUsername = "demo1"
        
        
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText(validUsername)
        XCTAssert(usernameTextField.exists)
        
        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        XCTAssert(passwordTextField.exists)
        
        
        app.buttons["LOGIN"].tap()
                
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
}
