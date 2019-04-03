//
//  AppNavigator.swift
//  Azui
//
//  Created by phan.huynh.thien.an on 8/16/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let window: UIWindow

    func toMain() {
//        let mainNavigator = MainNavigator(assembler: assembler, window: window)
//        mainNavigator.toMain()
    }
}
