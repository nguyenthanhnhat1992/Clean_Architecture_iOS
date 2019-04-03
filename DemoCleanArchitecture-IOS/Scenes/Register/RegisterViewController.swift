//
//  RegisterViewController.swift
//  DemoCleanArchitecture-IOS
//
//  Created by eru on 4/2/19.
//  Copyright © 2019 eru. All rights reserved.
//

import UIKit
import Reusable

class RegisterViewController: UIViewController, BindableType {

    var viewModel: RegisterViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {

    }
}

extension RegisterViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.register
}
