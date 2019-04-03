//
//  Assembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

protocol Assembler: class,
    RepositoriesAssembler,
    LoginAssembler,
    RegisterAssembler {
}
class DefaultAssembler: Assembler {
    static let shared = DefaultAssembler()
}
