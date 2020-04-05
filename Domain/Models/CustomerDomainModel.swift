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
	public let title: String
	public let carName: String
	public let creationDate: Date
	public let descriptionText: String
	public let bodyColored: BodyColoredType
	public let phoneNumber: String
	public let userName: String
	public let year: Int16
	public let priceFrom: Int16
	public let priceTo: Int16
	public let favorite: Bool
	public let contactDescription: String
	
	public init(id: String?,
							title: String,
							carName: String,
							creationDate: Date,
							descriptionText: String,
							contactDesc: String,
							bodyColored: BodyColoredType,
							phoneNumber: String,
							userName: String,
							priceFrom: Int16,
							priceTo: Int16,
							favorite: Bool,
							year: Int16) {
		self.id = id
		self.carName = carName
		self.creationDate = creationDate
		self.descriptionText = descriptionText
		self.bodyColored = bodyColored
		self.phoneNumber = phoneNumber
		self.userName = userName
		self.year = year
		self.title = title
		self.priceFrom = priceFrom
		self.priceTo = priceTo
		self.contactDescription = contactDesc
		self.favorite = favorite
	}
}
