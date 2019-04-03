//
//  LoginViewControllerTests.swift
//  DemoCleanArchitecture-IOSTests
//
//  Created by eru on 4/3/19.
//  Copyright © 2019 eru. All rights reserved.
//

@testable import DemoCleanArchitecture_IOS
import XCTest

class LoginViewControllerTests: XCTestCase {
    
    var viewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        viewController = LoginViewController.instantiate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ibOutlet() {
        viewController.loadView()
        XCTAssertNotNil(viewController.emailTextField)
        XCTAssertNotNil(viewController.passwordTextField)
        XCTAssertNotNil(viewController.loginButton)
        XCTAssertNotNil(viewController.forgotPasswordButton)
    }
    
}
