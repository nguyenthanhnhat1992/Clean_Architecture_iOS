//
//  LoginNavigator.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit

protocol LoginNavigatorType {
    func toForgotPassword()
    func toRegister(name: String)
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let navigationController: UINavigationController

    func toForgotPassword() {

    }

    func toRegister(name: String) {
        let vc: RegisterViewController = assembler.resolve(name: name)
        navigationController.pushViewController(vc, animated: true)
    }
}
