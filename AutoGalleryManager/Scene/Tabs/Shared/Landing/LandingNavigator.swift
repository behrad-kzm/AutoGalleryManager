//
//  LandingNavigator.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

final class LandingNavigator: Navigator {

	func toDetails(viewModel: AdvertiseViewModelType) {
		let controller = DetailsController(navigator: self, controllerType: viewModel)
		navigationController.pushViewController(controller, animated: true)
	}
}
