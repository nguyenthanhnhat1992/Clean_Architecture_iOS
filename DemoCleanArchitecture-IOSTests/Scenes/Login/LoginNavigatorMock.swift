//
//  LoginNavigatorMock.swift
//  DemoCleanArchitecture-IOSTests
//
//  Created by eru on 4/3/19.
//  Copyright © 2019 eru. All rights reserved.
//

@testable import DemoCleanArchitecture_IOS
import UIKit

final class LoginNavigatorMock: LoginNavigatorType {
    
    var toLogin_Called = false
    var toForgotPassword_Called = false
    var toRegister_Called = false
    
    func toLogin() {
        toLogin_Called = true
    }
    
    func toForgotPassword() {
        toForgotPassword_Called = true
    }
    
    func toRegister(name: String) {
        toRegister_Called = true
    }
}
