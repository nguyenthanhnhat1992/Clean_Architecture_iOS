//
//  LoginUseCaseMock.swift
//  DemoCleanArchitecture-IOSTests
//
//  Created by eru on 4/3/19.
//  Copyright © 2019 eru. All rights reserved.
//

@testable import DemoCleanArchitecture_IOS
import RxSwift

final class LoginUseCaseMock: LoginUseCaseType {
    var validateEmail_called = false
    let validateEmail_Result = (false, "")
    func validateEmail(email: String) -> (isValid: Bool, message: String) {
        validateEmail_called = true
        return validateEmail_Result
    }
    
    var validatePassword_called = false
    let validatePassword_Result = (false, "")
    func validatePassword(pass: String) -> (isValid: Bool, message: String) {
        validatePassword_called = true
        return validatePassword_Result
    }
    
    var login_called = false
    var loginResult = Observable.just(false)
    func login(emailPhone: String, password: String) -> Observable<Bool> {
        login_called = true
        return loginResult
    }
    
    var showMessageLogin_called = false
    func showMessageLogin(message: String) {
        showMessageLogin_called = true
    }
    
    
    
}
