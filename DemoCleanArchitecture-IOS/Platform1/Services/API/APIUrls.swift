//
//  APIUrls.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit

extension API {
    struct Urls {
        static var domainURL: String = "SERVER_URL"
        static var baseURL: String { return "SERVER_URL/api/v1" }

        static var login: String { return baseURL + "/login" }
    }
}
