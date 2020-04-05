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
	
	func toTabbar(withDefaultPresentedController handler: ((UIViewController) -> Void)? = nil) {
		let sellersNavigationController = LandingListController(navigator: LandingNavigator(navigationController: navigationController), controllerType: .seller)
		let customersNavigationController = LandingListController(navigator: LandingNavigator(navigationController: navigationController), controllerType: .customer)
		let tabBarViewController = UITabBarController()
		sellersNavigationController.tabBarItem = UITabBarItem(title: "Tab_2_Title".localize(), image: UIImage(named: "Tab_2"), tag: 0)
		customersNavigationController.tabBarItem = UITabBarItem(title: "Tab_1_Title".localize(), image: UIImage(named: "Tab_1"), tag: 0)
		tabBarViewController.setViewControllers([customersNavigationController, sellersNavigationController].compactMap{$0.makeNavigationController()}, animated: true)
		navigationController.setViewControllers([tabBarViewController], animated: true)
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
