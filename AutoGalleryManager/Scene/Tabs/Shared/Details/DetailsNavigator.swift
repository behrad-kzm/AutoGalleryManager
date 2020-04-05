//
//  DetailsNavigator.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/4/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

final class DetailsNavigator: Navigator {

	func toAddNewModel(type: AdvertiseViewModelType){
		let controller = AddNewModelViewController(navigator: self, controllerType: type)
		navigationController.pushViewController(controller, animated: true)
	}
}
