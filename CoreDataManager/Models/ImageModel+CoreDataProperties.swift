//
//  ImageModel+CoreDataProperties.swift
//  CoreDataManager
//
//  Created by Behrad Kazemi on 4/5/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import CoreData
import Domain

extension ImageModel {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModel> {
    return NSFetchRequest<ImageModel>(entityName: "ImageModel")
  }
  

  @NSManaged public var id: String?
	@NSManaged public var data: Data
	@NSManaged public var imageId: String?
	
}

extension ImageModel {
  func asDomain() -> ImageDomainModel {
		return ImageDomainModel(id: id, data: data, imageId: imageId)
  }
}
