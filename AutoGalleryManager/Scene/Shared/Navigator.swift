//
//  Navigator.swift
//  BEKApps
//
//  Created by Salar Soleimani on 2020-02-25.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import UIKit
//import Hero

class Navigator: NSObject {
    internal let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
	func toTabbar(withDefaultPresentedController handler: ((UIViewController) -> Void)? = nil) {
		//Initiate your viewControllers
		let sellersNavigationController = UINavigationController()
		sellersNavigationController.navigationBar.prefersLargeTitles = true
		sellersNavigationController.setNavigationBarHidden(false, animated: false)
		let sellersNavigator = SellersNavigator(navigationController: sellersNavigationController)
		let sellersVC = sellersNavigator.setup()
    sellersVC.title = "Tab_2_Title".localize()
		
		let customersNavigationController = UINavigationController()
		customersNavigationController.navigationBar.prefersLargeTitles = true
		customersNavigationController.setNavigationBarHidden(false, animated: false)
		let customersNavigator = CustomersNavigator(navigationController: customersNavigationController)
		let customerVC = customersNavigator.setup()
    customerVC.title = "Tab_1_Title".localize()

		let tabBarViewController = UITabBarController()
		

		customerVC.tabBarItem = UITabBarItem(title: "Tab_1_Title".localize(), image: UIImage(named: "Tab_1"), tag: 0)
		sellersVC.tabBarItem = UITabBarItem(title: "Tab_2_Title".localize(), image: UIImage(named: "Tab_2"), tag: 0)
		

		tabBarViewController.setViewControllers([customerVC, sellersVC], animated: true)
		
		navigationController.setViewControllers([tabBarViewController], animated: true)
		if let safe = handler  {
			safe(customerVC)
		}
	}
  func logError(error: Error, navigatorName name: String, message: String = "Empty"){
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
