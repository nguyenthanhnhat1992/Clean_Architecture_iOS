//
//  APIInputBase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Alamofire

class APIInput: APIInputBase {
    override init(urlString: String, parameters: [String: Any]?,
                  requestType: HTTPMethod, requireAccessToken: Bool,
                  useCache: Bool = false) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   requestType: requestType,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]

        self.user = nil
        self.password = nil
    }
}
