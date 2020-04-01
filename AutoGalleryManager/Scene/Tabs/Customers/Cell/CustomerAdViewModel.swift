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
	let brandName: String
	let carName: String
	let color: String
	let bodyColored: String
	let yearModel: String
	let descriptionText: String
	let userName: String
	let phoneNumber: String
}

extension CustomerAdViewModel {
	func asViewModel() -> SellerAdViewModel {
		let yearString = "Model".localize() + " \(yearModel)"
		let priceString = "\(price) " + "Million".localize()
		let titleText = title.isEmpty ? "\(brandName) \(carName) \(bodyColored.getTitle()) \(color) \(yearString)" : title
		return SellerAdViewModel(model: self, title: titleText, brandName: brandName, carName: carName, price: priceString, color: color, gearBoxType: isAutomatic ? "Automatic".localize() : "Manual".localize(), bodyColored: bodyColored.getTitle(), yearModel: yearString, descriptionText: descriptionText, userName: userName, phoneNumber: phoneNumber)
	}
}

extension CustomerAdViewModel: AdvertiseConvertable {
	func asAdvertiseViewModel() -> AdvertiseViewModel {
		let title = "Customer"
		let imageName = "placeholder"
		let subtitle = "String"
		let price = "1900"
		return AdvertiseViewModel(title: title, imageName: imageName, subtitle: subtitle, price: price)
	}
	
	func asType() -> AdvertiseViewModelType {
		return .customer(self)
	}
	
}
