//
//  APIError.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

extension API {
    enum APIError: Error, CustomStringConvertible {
        case noStatusCode
        case invalidResponseData
        case unknown(statusCode: Int)
        case error(response: ResponseError)
        case invalidToken
        case expiredToken
        case customError(localizeDescription: String)

        var description: String {
            switch self {
            case let .unknown(code):
                return "api.error.unknown" + "\(code)"
            case .invalidResponseData:
                return "api error invalid Response Data"
            case let .error(response):
                return response.message ?? "api.error.unknown"
            case .invalidToken:
                return "api.error.invalidToken"
            case let .customError(localizeDescription):
                return localizeDescription
            default:
                return String(describing: self)
            }
        }

        var field: ErrorField {
            switch self {
            case .unknown:
                return .others
            case .invalidResponseData:
                return .others
            case let .error(response):
                return response.field ?? .others
            case .invalidToken:
                return .others
            case .customError:
                return .others
            default:
                return .others
            }
        }

        var code: Int {
            switch self {
            case let .error(response):
                return response.code ?? 0
            default:
                return 0
            }
        }
    }

    final class ResponseError: APIOutput {

    }
}
