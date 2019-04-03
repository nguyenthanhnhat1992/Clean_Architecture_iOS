//
//  ReponsiAssembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/2/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation

import UIKit

protocol RepositoriesAssembler {
    func resolve() -> UserRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> UserRepositoryType {
        return UserRepository()
    }
}
