//
//  SplashNavigator.swift
//
//  Created by Behrad Kazemi on 12/29/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

final class SplashNavigator: Navigator {
	func setup() {
		let controller = SplashViewController(nibName: "SplashViewController", bundle: nil)
		controller.viewModel = SplashViewModel(navigator: self)
		navigationController.viewControllers = [controller]
	}

	func toHome() {
//		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		toTabbar()
	}
	
}
