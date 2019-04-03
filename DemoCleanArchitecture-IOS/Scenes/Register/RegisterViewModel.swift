//
//  LoginViewController.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.

import Then
import RxSwift
import RxCocoa

struct RegisterViewModel: ViewModelType {
    var name: String
    
    struct Input {
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
