//
//  Application.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-28.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit

final class Application {
  static let shared = Application()

  
  private init() {

  }
  
  func configureMainInterface(in window: UIWindow) {
    let mainNavigationController = MainNavigationController()
    window.rootViewController = mainNavigationController
    window.makeKeyAndVisible()
		let appearance = UITabBarItem.appearance()
		let attributes = [NSAttributedString.Key.font: UIFont.getRegularFont(size: 14)]
		appearance.setTitleTextAttributes(attributes, for: .normal)
		
    SplashNavigator(navigationController: mainNavigationController).setup()
  }
  
  func setupApplicationConfigurations() {

  }
  
}
