//
//  SellerModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public struct SellerModel {
	public let id: String?
	public let carName: String
	public let creationDate: Date
	public let descriptionText: String
	public let bodyColored: BodyColoredType
	public let phoneNumber: String
	public let price: String
	public let userName: String
	public let yearModel: String
	public let isAutomatic: Bool
	public let brandName: String
	
	public init(id: String?,
							carName: String,
							creationDate: Date,
							descriptionText: String,
							bodyColored: BodyColoredType,
							phoneNumber: String,
							price: String,
							userName: String,
							yearModel: String,
							isAutomatic: Bool,
							brandName: String) {
		self.id = id
		self.carName = carName
		self.creationDate = creationDate
		self.descriptionText = descriptionText
		self.bodyColored = bodyColored
		self.phoneNumber = phoneNumber
		self.price = price
		self.userName = userName
		self.yearModel = yearModel
		self.brandName = brandName
		self.isAutomatic = isAutomatic
	}
}
