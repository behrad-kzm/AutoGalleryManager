//
//  CustomersNavigator.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit


final class CustomersNavigator: Navigator {
	func setup() -> UIViewController {
		let controller = CustomersController(nibName: "CustomersController", bundle: nil)
		navigationController.viewControllers = [controller]
		return controller
	}
	
	func toAddCustomer() {

	}
	
	func toCustomerDetails() {

	}
}
