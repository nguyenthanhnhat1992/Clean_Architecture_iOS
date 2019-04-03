//
//  UserRepository.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit
import RxSwift

struct ValidateMessage {
    static let EMAIL_VALID = "Email valid"
    static let EMAIL_INVALID = "Email invalid"

    static let PASS_VALID = "Password valid"
    static let PASS_INVALID = "Password invalid"
}

protocol UserRepositoryType {
    func login(email: String, password: String) -> Observable<Bool>
    func validateEmail(email: String) -> (Bool, String)
    func validatePassword(password: String) -> (Bool, String)
    func showMessage(message: String)
}

final class UserRepository: UserRepositoryType {
    func validateEmail(email: String) -> (Bool, String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: email)

        var result: (isValid: Bool, message: String) = (isValid, "")
        result.message = isValid ? ValidateMessage.EMAIL_VALID : ValidateMessage.EMAIL_INVALID
        return result
    }

    func validatePassword(password: String) -> (Bool, String) {
        let isValid = password.count > 4

        var result: (isValid: Bool, message: String) = (isValid, "")
        result.message = isValid ? ValidateMessage.PASS_VALID : ValidateMessage.PASS_INVALID
        return result
    }

    func login(email: String, password: String) -> Observable<Bool> {
        let input = API.LoginInput(email: email, password: password)
        return API.shared.login(input).map { output -> Bool in
            guard let isLoginSuccess = output.isLoginSuccess else {
                throw API.APIError.invalidResponseData
            }
            return isLoginSuccess
        }
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        let navi = GET_APP_DELEGATE?.navigationController
        navi?.present(alert, animated: true, completion: nil)
    }
}
