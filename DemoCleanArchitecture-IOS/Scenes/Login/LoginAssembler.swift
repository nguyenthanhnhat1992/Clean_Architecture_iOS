//
//  LoginAssembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import UIKit
import Reusable

protocol LoginAssembler {
    func resolveViewController(navi: UINavigationController) -> LoginViewController
    func resolveViewModel(navi: UINavigationController) -> LoginViewModel
    func resolveNavigator(navi: UINavigationController) -> LoginNavigatorType
    func resolveUseCase() -> LoginUseCaseType
}

extension LoginAssembler {
    func resolveViewController(navi: UINavigationController) -> LoginViewController {
        let vc = LoginViewController.instantiate()
        let vm: LoginViewModel = resolveViewModel(navi: navi)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navi: UINavigationController) -> LoginViewModel {
        return LoginViewModel(
            navigator: resolveNavigator(navi: navi),
            useCase: resolveUseCase()
        )
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolveNavigator(navi: UINavigationController) -> LoginNavigatorType {
        return LoginNavigator(assembler: self, navigationController: navi)
    }

    func resolveUseCase() -> LoginUseCaseType {
        return LoginUseCase(repository: resolve())
    }
}
