//
//  LoginViewModelTests.swift
//  DemoCleanArchitecture-IOSTests
//
//  Created by eru on 4/3/19.
//  Copyright © 2019 eru. All rights reserved.
//

@testable import DemoCleanArchitecture_IOS
import XCTest
import RxSwift
import RxCocoa
import Foundation
//import RxBlocking

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var useCase: LoginUseCaseMock!
    var navigator: LoginNavigatorMock!

    private var disposeBag: DisposeBag!

    private var input: LoginViewModel.Input!
    private var output: LoginViewModel.Output!

    let loginTrigger = PublishSubject<Void>()
    let registerTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = LoginNavigatorMock()
        useCase = LoginUseCaseMock()
        viewModel = LoginViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        let builder = LoginViewModel.InputBuilder().then {
            $0.loginTrigger = loginTrigger.asDriverOnErrorJustComplete()
            $0.email = Driver.just("test@gmail.com")
            $0.password = Driver.just("pass")
            $0.registerTrigger = registerTrigger.asDriverOnErrorJustComplete()
        }
        
        input = LoginViewModel.Input(builder: builder)
        output = viewModel.transform(input)
        
        output.login
            .drive()
            .disposed(by: disposeBag)
        
        output.toRegister
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_registerTrigger() {
        registerTrigger.onNext(())
        XCTAssert(navigator.toRegister_Called)
    }
    
    func test_LoginTrigger() {
        loginTrigger.onNext(())
        XCTAssert(useCase.login_called)
    }

    
}
