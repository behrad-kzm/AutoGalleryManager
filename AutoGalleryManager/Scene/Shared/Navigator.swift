//
//  Navigator.swift
//  BEKApps
//
//  Created by Salar Soleimani on 2020-02-25.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import UIKit
import Hero

class Navigator: NSObject {
	internal let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.isHeroEnabled = true
	}
	
	func back() {
		navigationController.popViewController(animated: true)
	}
	
	func toTabbar() {
			let sellersNavigationController = UINavigationController()
		let sellerNavigator = LandingNavigator(navigationController: navigationController)
		let sellersController = LandingListController(controllerType: .seller)
		sellersController.navigator = sellerNavigator
		sellersNavigationController.viewControllers = [sellersController]
		
			let customersNavigationController = UINavigationController()
		let customersNavigator = LandingNavigator(navigationController: navigationController)
		let customersController = LandingListController(controllerType: .customer)
		customersController.navigator = customersNavigator
		customersNavigationController.viewControllers = [customersController]

		let tabBarViewController = UITabBarController()
		sellersController.tabBarItem = UITabBarItem(title: "Tab_2_Title".localize(), image: UIImage(named: "Tab_2"), tag: 0)
		customersController.tabBarItem = UITabBarItem(title: "Tab_1_Title".localize(), image: UIImage(named: "Tab_1"), tag: 0)
		
		tabBarViewController.setViewControllers([sellersController, customersController], animated: true)
		navigationController.setViewControllers([tabBarViewController], animated: true)
		navigationController.view.layoutSubviews()
	}
	
	func logError(error: Error, navigatorName name: String, message: String = "Empty".localize()){
		print("-------------\nerror inside \(name) Navigator -> \(error) \nmessage: \(message) \n-------------\n")
		DispatchQueue.main.async { [navigationController, error] in
			let errorVC = PopUpCoverViewController(nibName: "PopUpCoverViewController", bundle: nil)
			errorVC.viewModel = error.asPopUpCoverViewModel()
			errorVC.modalPresentationStyle = .overCurrentContext
			errorVC.loadView()
			//      errorVC.isHeroEnabled = true
			//      errorVC.mainView.hero.modifiers = [.fade, .translate(y: 100)]
			if let upperVC = navigationController.viewControllers.last {
				if let presented = upperVC.presentedViewController{
					presented.present(errorVC, animated: true, completion: nil)
					return
				}
				upperVC.present(errorVC, animated: true, completion: nil)
			}
		}
	}
}
