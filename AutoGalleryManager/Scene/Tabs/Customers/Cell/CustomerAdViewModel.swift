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
	let id: String?
	let favorite: Bool
	let title: String
	let carName: String
	let date: String
	let priceFrom: String
	let priceTo: String
	let bodyColored: String
	let yearModel: String
	let descriptionText: String
	let contactDescription: String
	let userName: String
	let phoneNumber: String
}

extension CustomerDomainModel {
	func asViewModel() -> CustomerAdViewModel {
		let yearString = "Model".localize() + " \(year)"
		let dateString = "دقایقی پیش"
		let titleText = title.isEmpty ? "\(carName) \(bodyColored.getTitle()) \(yearString)" : title
		return CustomerAdViewModel(model: self, id: id, favorite: favorite, title: titleText, carName: carName, date: dateString, priceFrom: String(priceFrom), priceTo: String(priceTo), bodyColored: bodyColored.getTitle(), yearModel: yearString, descriptionText: descriptionText, contactDescription: contactDescription, userName: userName, phoneNumber: phoneNumber)
	}
}

extension CustomerAdViewModel: AdvertiseConvertable {
	func asAdvertiseViewModel() -> AdvertiseViewModel {
		let imageName = "Placeholder"
		let subtitle = "\(userName) "
		let priceString = " از " + " \(priceFrom) " + "Million".localize() + " تا " + " \(priceTo) " + "Million".localize()
		return AdvertiseViewModel(title: title, imageName: imageName, subtitle: subtitle, price: priceString)
	}
	
	func asType() -> AdvertiseViewModelType {
		return .customer(self)
	}
	
}
