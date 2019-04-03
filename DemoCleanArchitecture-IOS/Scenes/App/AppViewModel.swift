//
//  AppViewModel.swift
//  Azui
//
//  Created by phan.huynh.thien.an on 8/16/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Then
import RxSwift
import RxCocoa

struct AppViewModel: ViewModelType {
    struct Input {
//        let trigger: Driver<Void>
//        let deviceTokenTrigger: Driver<String>
    }
//
    struct Output {
////        let toMain: Driver<Void>
////        let deviceToken: Driver<String>
    }
//
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
////        let toMain = input.trigger
////            .do(onNext: self.navigator.toMain)
////
////        let deviceToken = input.deviceTokenTrigger
////            .map { token -> String in
//////                self.useCase.saveDeviceToken(token)
////                return token
////            }
////
////        return Output(toMain: toMain,
////                      deviceToken: deviceToken)
//    }
//}
//
//extension AppViewModel {
//    final class InputBuilder: Then {
//        var trigger: Driver<Void> = Driver.empty()
//        var deviceTokenTrigger: Driver<String> = Driver.empty()
//    }
//}
//
//extension AppViewModel.Input {
//    init(builder: AppViewModel.InputBuilder) {
//        self.init(trigger: builder.trigger,
//                  deviceTokenTrigger: builder.deviceTokenTrigger)
//    }
//}
