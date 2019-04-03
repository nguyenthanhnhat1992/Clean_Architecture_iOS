//
//  API+Login.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RxCocoa

extension API {
    func login(_ input: LoginInput) -> Observable<LoginOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class LoginInput: APIInput {
        init(email: String, password: String) {
            let params: JSONDictionary = [
                "user": [
                    "email": email,
                    "password": password
                ]
            ]

            super.init(urlString: API.Urls.login, parameters: params, requestType: .post, requireAccessToken: false)
        }
    }

    final class LoginOutput: APIOutput {
        private(set) var isLoginSuccess: Bool?

        override func mapping(map: Map) {
            super.mapping(map: map)
            isLoginSuccess <- map["isLoginSuccess"]
            //MARK: HARD CODE CALL LOGIN SUCCESS
            isLoginSuccess = true
        }
    }
}
