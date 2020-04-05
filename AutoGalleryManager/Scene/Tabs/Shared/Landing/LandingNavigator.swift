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
		let navigator = DetailsNavigator(navigationController: navigationController)
		let controller = DetailsController(navigator: navigator, controllerType: viewModel)
		navigationController.pushViewController(controller, animated: true)
	}
	
	func toAddNewModel(type: AdvertiseFlatViewModelType){
		let controller = AddNewModelViewController(navigator: self, controllerType: type)
		navigationController.pushViewController(controller, animated: true)
	}
}
