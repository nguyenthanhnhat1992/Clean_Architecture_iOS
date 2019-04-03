//
//  APIService.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import ObjectMapper
import Alamofire
import RxSwift
import RxAlamofire

func == <K, V>(left: [K: V], right: [K: V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}

typealias JSONDictionary = [String: Any]

final class API {
    static let shared = API()

    func request<T: Mappable>(_ input: APIInputBase) -> Observable<T> {
        return request(input)
            .map { json -> T in
                if let t = T(JSON: json) {
                    return t
                }
                throw APIError.invalidResponseData
            }
    }

}

// MARK: - Support methods
extension API {
    fileprivate func request(_ input: APIInputBase) -> Observable<JSONDictionary> {
        let fakeObject: JSONDictionary = [:]
        return Observable.just(fakeObject)
    }

    fileprivate func process(_ response: (HTTPURLResponse, Data)) throws -> JSONDictionary {
        let (response, data) = response
        let json: JSONDictionary? = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary
        let error: Error
        switch response.statusCode {
        case 200..<300:
            print("👍 [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            return json ?? JSONDictionary()
        case 401:
            error = APIError.expiredToken
        default:
            if let json = json, let responseError = ResponseError(JSON: json) {
                error = APIError.error(response: responseError)
            } else {
                error = APIError.unknown(statusCode: response.statusCode)
            }
            print("❌ [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            if let json = json {
                print(json)
            }
        }
        throw error
    }

    fileprivate func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
        return Observable.deferred {
            if input.requireAccessToken {
                // MARK: get token
                let token = "NHAT FAKE TOKEN"
                var headers = input.headers
                headers["authorizationKey"] = "Bearer \(token)"
                input.headers = headers
                input.accessToken = token
                return Observable.just(input)
            } else {
                return Observable.just(input)
            }
        }
    }
}
