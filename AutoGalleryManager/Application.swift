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
    SplashNavigator(navigationController: mainNavigationController).setup()
  }
  
  func setupApplicationConfigurations() {

  }
  
}
