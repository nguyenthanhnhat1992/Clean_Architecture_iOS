//
//  AppDelegate.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit

let GET_APP_DELEGATE = UIApplication.shared.delegate as? AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navigationController = initNavi()
        return true
    }

    func initNavi() -> UINavigationController {
        let navigationVc = UINavigationController()
        let loginVc: UIViewController = DefaultAssembler.shared.resolveViewController(navi: navigationVc)
        navigationVc.viewControllers = [loginVc]
        self.window?.rootViewController = navigationVc
        return navigationVc
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
