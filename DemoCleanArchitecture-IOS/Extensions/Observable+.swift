//
//  Observa.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/2/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

extension ObservableType {
    // swiftlint:disable:next missing_docs
    public func unwrap<T>() -> Observable<T> where E == T? {

        return self
            .filter { value in
                if case .some = value {
                    return true
                }
                return false
                // swiftlint:disable:next force_unwrapping
            }.map { $0! }
    }
}

extension SharedSequenceConvertibleType {

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }

    func mapToOptional() -> SharedSequence<SharingStrategy, E?> {
        return map { value -> E? in value }
    }

    // swiftlint:disable:next missing_docs
    public func unwrap<T>() -> SharedSequence<SharingStrategy, T> where E == T? {
        return self
            .filter { value in
                if case .some = value {
                    return true
                }
                return false
                // swiftlint:disable:next force_unwrapping
            }.map { $0! }
    }
}

extension ObservableType {

    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    func mapToOptional() -> Observable<E?> {
        return map { value -> E? in value }
    }
}
