//
//  Utilities.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import UIKit

func getNewWindowNavigation() -> UINavigationController {
    let win = UIWindow(frame: UIScreen.main.bounds)
    let nav = GET_APP_DELEGATE?.navigationController ?? UINavigationController()
    win.rootViewController = nav
    win.makeKeyAndVisible()
    return nav
}
