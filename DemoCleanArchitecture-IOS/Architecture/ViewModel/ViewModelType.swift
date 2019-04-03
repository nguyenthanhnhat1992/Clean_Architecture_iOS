//
//  ViewModelType.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
