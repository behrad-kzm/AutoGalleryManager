//
//  CustomerAdViewModel.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
struct CustomerAdViewModel {
	let model: CustomerDomainModel
	let title: String
	let carName: String
	let date: String
	let priceRange: String
	let bodyColored: String
	let yearModel: String
	let descriptionText: String
	let userName: String
	let phoneNumber: String
}

extension CustomerDomainModel {
	func asViewModel() -> CustomerAdViewModel {
		let yearString = "Model".localize() + " \(year)"
		let priceString = "\(priceRange) " + "Million".localize()
		let dateString = "تستس دیروز"
		let titleText = title.isEmpty ? "\(carName) \(bodyColored.getTitle()) \(yearString)" : title
		return CustomerAdViewModel(model: self, title: titleText, carName: carName, date: dateString, priceRange: priceString, bodyColored: bodyColored.getTitle(), yearModel: yearString, descriptionText: descriptionText, userName: userName, phoneNumber: phoneNumber)
	}
}

extension CustomerAdViewModel: AdvertiseConvertable {
	func asAdvertiseViewModel() -> AdvertiseViewModel {
		let imageName = "Placeholder"
		let subtitle = "\(userName) "
		return AdvertiseViewModel(title: title, imageName: imageName, subtitle: subtitle, price: priceRange)
	}
	
	func asType() -> AdvertiseViewModelType {
		return .customer(self)
	}
	
}
