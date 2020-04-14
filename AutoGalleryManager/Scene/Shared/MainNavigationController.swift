//
//  MainNavigationController.swift
//
//  Created by Behrad Kazemi on 8/14/18.
//  Copyright © 2018 BEKApps. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
  //MARK: - Initialization
  
  init() {
    super.init(rootViewController: UIViewController())
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
		interactivePopGestureRecognizer?.isEnabled = false
    self.setNavigationBarHidden(false, animated: false)
  }
}
