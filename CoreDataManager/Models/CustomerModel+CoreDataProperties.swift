//
//  CustomerModel+CoreDataProperties.swift
//  CoreDataManager
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import CoreData
import Domain

extension CustomerModel {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerModel> {
    return NSFetchRequest<CustomerModel>(entityName: "CustomerModel")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var bodyColored: Int16
  @NSManaged public var carName: String?
  @NSManaged public var creationDate: Date
  @NSManaged public var descriptionText: String?
	@NSManaged public var contactDescription: String?
  @NSManaged public var id: String?
  @NSManaged public var phoneNumber: String?
	@NSManaged public var priceFrom: Int16
	@NSManaged public var priceTo: Int16
	@NSManaged public var favorite: Bool
	@NSManaged public var userName: String?
	@NSManaged public var year: Int16
	
}

extension CustomerModel {
  func asDomain() -> CustomerDomainModel {
		return CustomerDomainModel(id: id, title: title ?? "", carName: carName ?? "", creationDate: creationDate, descriptionText: descriptionText ?? "", contactDesc: contactDescription ?? "", bodyColored: BodyColoredType(rawValue: bodyColored) ?? .unknown, phoneNumber: phoneNumber ?? "", userName: userName ?? "", priceFrom: priceFrom, priceTo: priceTo, favorite: favorite, year: year)
  }
}
