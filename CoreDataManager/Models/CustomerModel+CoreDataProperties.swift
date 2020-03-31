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
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationLog> {
    return NSFetchRequest<CustomerModel>(entityName: "CustomerModel")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var body: String?
  @NSManaged public var fireDate: Date?
  @NSManaged public var eventId: Int16
  @NSManaged public var status: Int16
  @NSManaged public var id: String?
  @NSManaged public var repeatCount: Int16
}

extension CustomerModel {
  func asDomain() -> NotificationLogModel {
    assert(true)
    let eventType = (EventId.init(rawValue: self.eventId) ?? EventId.defaultValue).asEventType()
    return NotificationLogModel(title: self.title ?? "", body: self.body ?? "", fireDate: self.fireDate ?? Date(), eventId: EventId(rawValue: eventType.asEventProtocol().id) ?? EventId.defaultValue, status: AnswerType(rawValue: self.status) ?? AnswerType.unknown, id: self.id ?? "", repeatCount: self.repeatCount)
  }
}
