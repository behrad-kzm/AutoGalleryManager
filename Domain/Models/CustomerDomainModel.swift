//
//  CustomerModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public struct CustomerDomainModel {
	public let id: String?
	public let carName: String
	public let creationDate: Date
	public let descriptionText: String
	public let bodyColored: BodyColoredType
	public let phoneNumber: String
	public let priceRange: String
	public let userName: String
	public let year: Int16
	
	public init(id: String?,
							carName: String,
							creationDate: Date,
							descriptionText: String,
							bodyColored: BodyColoredType,
							phoneNumber: String,
							priceRange: String,
							userName: String,
							year: Int16) {
		self.id = id
		self.carName = carName
		self.creationDate = creationDate
		self.descriptionText = descriptionText
		self.bodyColored = bodyColored
		self.phoneNumber = phoneNumber
		self.priceRange = priceRange
		self.userName = userName
		self.year = year
	}
}
