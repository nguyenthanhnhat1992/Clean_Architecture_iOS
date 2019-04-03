//
//  LoginViewController.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.

import Foundation
import UIKit
import Reusable

protocol RegisterAssembler {
    func resolve(name: String) -> RegisterViewController
    func resolve(name: String) -> RegisterViewModel
    func resolve() -> RegisterNavigatorType
    func resolve() -> RegisterUseCaseType
}

extension RegisterAssembler {
    func resolve(name: String) -> RegisterViewController {
        let vc = RegisterViewController.instantiate()
        let vm: RegisterViewModel = resolve(name: name)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(name: String) -> RegisterViewModel {
        return RegisterViewModel(name: name)
    }
}

extension RegisterAssembler where Self: DefaultAssembler {
    func resolve() -> RegisterNavigatorType {
        return RegisterNavigator()
    }

    func resolve() -> RegisterUseCaseType {
        return RegisterUseCase()
    }
}
