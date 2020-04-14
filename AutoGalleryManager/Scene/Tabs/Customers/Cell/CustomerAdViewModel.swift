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
	let brandName: String
}

extension CustomerDomainModel {
	func asViewModel() -> CustomerAdViewModel {
		let yearString = " \(year)"
		let dateString = creationDate.asShamsiString().toFaDigits
		
		let titles = [carName, yearString].filter { (item) -> Bool in
			return !item.isEmpty
		}
		var titleText = ""
		titles.forEach { (item) in
			titleText = String.localizedStringWithFormat("%@ %@", item , titleText)
		}
		return CustomerAdViewModel(model: self, id: id, favorite: favorite, title: titleText, carName: carName, date: dateString, priceFrom: priceFrom.asPrice, priceTo: priceTo.asPrice, bodyColored: bodyColored.getTitle(), yearModel: yearString, descriptionText: descriptionText, contactDescription: contactDescription, userName: userName, phoneNumber: phoneNumber, brandName: brandName)
	}
}


extension CustomerAdViewModel: AdvertiseConvertable {
	func asAdvertiseViewModel() -> AdvertiseViewModel {
		let imageName = "Placeholder"
		let subtitle = "\(userName) "
		let priceString = " از " + " \(priceFrom) " + " تا " + " \(priceTo) " + "Million".localize()
		return AdvertiseViewModel(title: title, imageName: imageName, subtitle: subtitle, price: priceString, dateString: date)
	}
	
	func asType() -> AdvertiseViewModelType {
		return .customer(self)
	}
	
}
