//
//  SellerModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public struct SellerDomainModel {
	public let id: String?
	public let carName: String
	public let creationDate: Date
	public let descriptionText: String
	public let bodyColored: BodyColoredType
	public let phoneNumber: String
	public let price: Int16
	public let userName: String
	public let yearModel: Int16
	public let favorite: Bool
	public let brandName: String
	public let color: String
	public let title: String
	public let kilometer: Int16
	public let contactDescription: String
	
	public init(id: String?,
							title: String,
							carName: String,
							creationDate: Date,
							descriptionText: String,
							bodyColored: BodyColoredType,
							phoneNumber: String,
							price: Int16,
							userName: String,
							kilometer: Int16,
							contactDesc: String,
							yearModel: Int16,
							color: String,
							favorite: Bool,
							brandName: String) {
		self.id = id
		self.title = title
		self.color = color
		self.carName = carName
		self.creationDate = creationDate
		self.descriptionText = descriptionText
		self.bodyColored = bodyColored
		self.phoneNumber = phoneNumber
		self.price = price
		self.userName = userName
		self.yearModel = yearModel
		self.brandName = brandName
		self.favorite = favorite
		self.contactDescription = contactDesc
		self.kilometer = kilometer
	}
}
