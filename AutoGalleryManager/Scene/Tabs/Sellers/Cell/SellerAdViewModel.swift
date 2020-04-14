//
//  SellerAdViewModel.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
struct SellerAdViewModel {
	let model: SellerDomainModel
	let title: String
	let brandName: String
	let carName: String
	let price: String
	let color: String
	let innerColor: String
	let id: String?
	let favorite: Bool
	let bodyColored: String
	let yearModel: String
	let descriptionText: String
	let userName: String
	let phoneNumber: String
	let kilometer: Int64
	let contactDescription: String
	let creationDateString: String
}
extension SellerDomainModel {
	func asViewModel() -> SellerAdViewModel {
		let yearString = String(yearModel)
		let priceString = "\(price.asPrice) " + "Million".localize()
		let titles = [brandName, carName, yearString].filter { (item) -> Bool in
			return !item.isEmpty
		}
		
		var titleText = ""
		titles.forEach { (item) in
			
			titleText = titleText.isEmpty ? item : String.localizedStringWithFormat("%@ ، %@", item , titleText)
		}
		
		return SellerAdViewModel(model: self, title: titleText, brandName: brandName, carName: carName, price: priceString, color: color, innerColor: innerColor, id: id, favorite: favorite, bodyColored: bodyColored.getTitle(), yearModel: yearString, descriptionText: descriptionText, userName: userName, phoneNumber: phoneNumber, kilometer: kilometer, contactDescription: contactDescription, creationDateString: creationDate.asShamsiString().toFaDigits)
	}
}
extension SellerAdViewModel: AdvertiseConvertable {
	func asAdvertiseViewModel() -> AdvertiseViewModel {
		let imageName = "Placeholder"
		let subtitle = "\(userName) "
		return AdvertiseViewModel(title: title, imageName: imageName, subtitle: subtitle, price: price, dateString: creationDateString)
	}
	func asType() -> AdvertiseViewModelType {
		return .seller(self)
	}

}
