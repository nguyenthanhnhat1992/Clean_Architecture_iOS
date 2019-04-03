//
//  LoginViewModel.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Then

struct LoginViewModel: ViewModelType {
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType

    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let loginTrigger: Driver<Void>
        let forgotPasswordTrigger: Driver<Void>
        let registerTrigger: Driver<Void>
        let showMessage: Driver<String>
    }

    struct Output {
        let emailPhoneValidation: Driver<(isValid: Bool, message: String)>
        let passwordValidation: Driver<(isValid: Bool, message: String)>
        let loginEnable: Driver<Bool>
        let login: Driver<Bool>
        let toForgotPassword: Driver<Void>
        let toRegister: Driver<Void>
        let error: Driver<Error>
        let showMessage: Driver<Void>
    }

    func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {
        let errorTracker = ErrorTracker()
        
        let emailPhoneValidation = input.email
            .map {
                self.useCase.validateEmail(email: $0)
            }

        let passwordValidation = input.password
            .map {
                self.useCase.validatePassword(pass: $0)
            }

        let loginEnable = Driver
            .combineLatest(emailPhoneValidation, passwordValidation) {
                $0.isValid && $1.isValid
            }

        let emailPassword = Driver.combineLatest(input.email, input.password)

        let login = input.loginTrigger
            .withLatestFrom(loginEnable)
//            .filter { $0 }
            .withLatestFrom(emailPassword)
            .flatMapLatest {
                self.useCase
                    .login(emailPhone: $0.0, password: $0.1)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }

        let toForgotPassword = input.forgotPasswordTrigger
            .do(onNext: { _ in
                self.navigator.toForgotPassword()
            })
            .mapToVoid()

        let toRegister = input.registerTrigger
            .do(onNext: { _ in
                self.navigator.toRegister(name: "nhat")
            })
            .mapToVoid()
        
        let showMessage = input.showMessage
            .do(onNext: { message in
                self.useCase.showMessageLogin(message: message)
            }).mapToVoid()

        return Output(emailPhoneValidation: emailPhoneValidation,
                      passwordValidation: passwordValidation,
                      loginEnable: loginEnable,
                      login: login,
                      toForgotPassword: toForgotPassword,
                      toRegister: toRegister,
                      error: errorTracker.asDriver(),
                      showMessage: showMessage)
    
    }
}

extension LoginViewModel {
    final class InputBuilder: Then {
        var email: Driver<String> = Driver.empty()
        var password: Driver<String> = Driver.empty()
        var loginTrigger: Driver<Void> = Driver.empty()
        var forgotPasswordTrigger: Driver<Void> = Driver.empty()
        var registerTrigger: Driver<Void> = Driver.empty()
        var showMessage: Driver<String> = Driver.empty()
    }
}

extension LoginViewModel.Input {
    init(builder: LoginViewModel.InputBuilder) {
        self.init(email: builder.email,
                  password: builder.password,
                  loginTrigger: builder.loginTrigger,
                  forgotPasswordTrigger: builder.forgotPasswordTrigger,
                  registerTrigger: builder.registerTrigger,
                  showMessage: builder.showMessage)
    }
}
