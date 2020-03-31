//
//  SellerModel+CoreDataProperties.swift
//  CoreDataManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import CoreData
import Domain

extension SellerModel {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<SellerModel> {
    return NSFetchRequest<SellerModel>(entityName: "SellerModel")
  }
  
  @NSManaged public var title: String?
	@NSManaged public var id: String?
	@NSManaged public var carName: String?
	@NSManaged public var creationDate: Date
	@NSManaged public var descriptionText: String?
	@NSManaged public var bodyColored: Int16
	@NSManaged public var phoneNumber: String?
	@NSManaged public var price: String?
	@NSManaged public var userName: String?
	@NSManaged public var yearModel: Int16
	@NSManaged public var isAutomatic: Bool
	@NSManaged public var brandName: String?
	
}

extension SellerModel {
  func asDomain() -> SellerDomainModel {
		return SellerDomainModel(id: id, carName: carName ?? "", creationDate: creationDate, descriptionText: descriptionText ?? "", bodyColored: BodyColoredType(rawValue: bodyColored) ?? .unknown, phoneNumber: phoneNumber ?? "", price: price ?? "", userName: userName ?? "", yearModel: yearModel, isAutomatic: isAutomatic, brandName: brandName ?? "")
  }
}
