//
//  LoginUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginUseCaseType {
    func validateEmail(email: String) -> (isValid: Bool, message: String)
    func validatePassword(pass: String) -> (isValid: Bool, message: String)
    func login(emailPhone: String, password: String) -> Observable<Bool>
    func showMessageLogin(message: String)
}

struct LoginUseCase: LoginUseCaseType {
    let repository: UserRepositoryType

    func validateEmail(email: String) -> (isValid: Bool, message: String) {
        return repository.validateEmail(email: email)
    }

    func validatePassword(pass: String) -> (isValid: Bool, message: String) {
        return repository.validatePassword(password: pass)
    }

    func login(emailPhone: String, password: String) -> Observable<Bool> {
        return repository.login(email: emailPhone, password: password)
    }
    
    func showMessageLogin(message: String) {
        repository.showMessage(message: message)
    }

}
