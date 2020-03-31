//
//  SellersNavigator.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

final class SellersNavigator: Navigator {
	func setup() -> UIViewController {
		let controller = SellersController(nibName: "SellersController", bundle: nil)
		
		navigationController.viewControllers = [controller]
		return controller
	}

	func toAddSeller() {

	}
	
	func toSellerDetails() {

	}
}