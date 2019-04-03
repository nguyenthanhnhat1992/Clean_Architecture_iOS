//
//  LoginViewController.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxSwiftExt
import NSObject_Rx

class LoginViewController: UIViewController, BindableType {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    @IBOutlet weak var forgotPasswordButton: UIButton!

    var viewModel: LoginViewModel!
    
    fileprivate let showMessagePublishSubject = PublishSubject<String>()

    private var isValidEmailBinder: Binder<(isValid: Bool, message: String)> {
        return Binder(self) { vc, result in
            vc.emailLabel.text = result.message
            vc.emailLabel.textColor = result.isValid ? .black : .red
        }
    }

    private var isValidPasswordBinder: Binder<(isValid: Bool, message: String)> {
        return Binder(self) { vc, result in
            vc.passwordLabel.text = result.message
            vc.passwordLabel.textColor = result.isValid ? .black : .red
        }
    }
    
    private var isLoginBinder: Binder<Bool> {
        return Binder(self) { vc, isLoginSuccess in
            print(isLoginSuccess)
            if isLoginSuccess {
                vc.showMessagePublishSubject.onNext("Login Success")
            }
        }
    }
    
    private var loginError: Binder<Error> {
        return Binder(self) { vc, error in
            if let error = error as? API.APIError {
                vc.showMessagePublishSubject.onNext(String(describing: error))
            } else {
                vc.showMessagePublishSubject.onNext(error.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {
        let loginTrigger = loginButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()

        let forgotPasswordTrigger = forgotPasswordButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()

        let registerTrigger = registerButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()

        let builder = LoginViewModel.InputBuilder().then {
            $0.email = emailTextField.rx.text.orEmpty.asDriver()
            $0.password = passwordTextField.rx.text.orEmpty.asDriver()
            $0.loginTrigger = loginTrigger
            $0.forgotPasswordTrigger = forgotPasswordTrigger
            $0.registerTrigger = registerTrigger
            $0.showMessage = showMessagePublishSubject.asDriverOnErrorJustComplete()
        }

        let input = LoginViewModel.Input(builder: builder)
        let output = viewModel.transform(input)

        output.login
            .drive(isLoginBinder)
            .disposed(by: rx.disposeBag)

        output.emailPhoneValidation
            .drive(isValidEmailBinder)
            .disposed(by: rx.disposeBag)

        output.passwordValidation
            .drive(isValidPasswordBinder)
            .disposed(by: rx.disposeBag)

        output.loginEnable.do(onNext: { isEnable in
            self.loginButton.alpha = isEnable ? 1.0 : 0.4
        }).drive(loginButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)

        output.toRegister
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.toForgotPassword
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(loginError)
            .disposed(by: rx.disposeBag)
        
        output.showMessage
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
