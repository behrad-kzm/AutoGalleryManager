//
//  DataBaseManager.swift
//  CoreDataManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import CoreData
import Domain

public class DatabaseManager {
	
	
	private(set) lazy var sellerDB = SasCoreData<SellerModel>()
	private(set) lazy var customerDB = SasCoreData<CustomerModel>()
	public static var shared = {
		return DatabaseManager()
	}()
	
	public func add(Customer customer: CustomerDomainModel, completion: ((Bool) -> Void)?) {
		
		let customerData = NSEntityDescription.insertNewObject(forEntityName: "CustomerModel", into: customerDB.persistentContainer.viewContext) as! CustomerModel
		
		customerData.setValue(customer.id, forKey: "id")
		customerData.setValue(customer.title, forKey: "title")
		customerData.setValue(customer.carName, forKey: "carName")
		customerData.setValue(customer.creationDate, forKey: "creationDate")
		customerData.setValue(customer.descriptionText, forKey: "descriptionText")
		customerData.setValue(customer.bodyColored.rawValue, forKey: "bodyColored")
		customerData.setValue(customer.phoneNumber, forKey: "phoneNumber")
		customerData.setValue(customer.priceTo, forKey: "priceTo")
		customerData.setValue(customer.priceFrom, forKey: "priceFrom")
		customerData.setValue(customer.userName, forKey: "userName")
		customerData.setValue(customer.year, forKey: "year")
		
		customerDB.update(customerData) {[completion] (completed) in
			if completion != nil {
				completion!(completed)
			}
		}
	}
	
	public func add(Seller seller: SellerDomainModel, completion: ((Bool) -> Void)?) {
		
		let sellerData = NSEntityDescription.insertNewObject(forEntityName: "SellerModel", into: sellerDB.persistentContainer.viewContext) as! SellerModel
		
		sellerData.setValue(seller.id, forKey: "id")
		sellerData.setValue(seller.carName, forKey: "carName")
		sellerData.setValue(seller.creationDate, forKey: "creationDate")
		sellerData.setValue(seller.descriptionText, forKey: "descriptionText")
		sellerData.setValue(seller.bodyColored.rawValue, forKey: "bodyColored")
		sellerData.setValue(seller.phoneNumber, forKey: "phoneNumber")
		sellerData.setValue(seller.price, forKey: "price")
		sellerData.setValue(seller.userName, forKey: "userName")
		sellerData.setValue(seller.yearModel, forKey: "yearModel")
		sellerData.setValue(seller.favorite, forKey: "favorite")
		sellerData.setValue(seller.kilometer, forKey: "kilometer")
		sellerData.setValue(seller.contactDescription, forKey: "contactDescription")
		sellerData.setValue(seller.brandName, forKey: "brandName")
		sellerData.setValue(seller.color, forKey: "color")
		sellerData.setValue(seller.title, forKey: "title")
		
		
		sellerDB.update(sellerData) {[completion] (completed) in
			if completion != nil {
				completion!(completed)
			}
		}
	}
	
	public func getSellers(response: ([SellerDomainModel]) -> Void, error: (Error) -> Void) {
		sellerDB.getAll(predicate: nil) { [response, error] (result) in
			switch result {
			case .success(let resp):
				response(resp.compactMap{$0.asDomain()})
			case .failure(let err):
				error(err)
			}
		}
	}
	
	public func delete(SellerIds sellerIds: [String], completion: ((Bool) -> Void)?) {
		let predicate = NSPredicate(format: "ANY id IN %@", sellerIds)
		sellerDB.batchDelete(predicate: predicate) { (updated) in
			if completion != nil {
				completion!(updated)
			}
		}
	}
	public func getCustomers(response: ([CustomerDomainModel]) -> Void, error: (Error) -> Void) {
		customerDB.getAll(predicate: nil) { [response, error] (result) in
			switch result {
			case .success(let resp):
				response(resp.compactMap{$0.asDomain()})
			case .failure(let err):
				error(err)
			}
		}
	}
	
	public func delete(CustomerIds customerIds: [String], completion: ((Bool) -> Void)?) {
		let predicate = NSPredicate(format: "ANY id IN %@", customerIds)
		customerDB.batchDelete(predicate: predicate) { (updated) in
			if completion != nil {
				completion!(updated)
			}
		}
	}
	public func delete(forIds ids: [String], completion: ((Bool) -> Void)?){
		delete(CustomerIds: ids) { (updated) in
			completion?(updated)
		}
		delete(SellerIds: ids) { (updated) in
			completion?(updated)
		}
	}
	public func set(answer: Bool, itemId id: String, completion: ((Bool) -> Void)?, error: (Error) -> Void) {
		let predicate = NSPredicate(format: "id == %@", id)
		
		customerDB.getAll(predicate: predicate) {[completion, error] (result) in
			switch result {
			case .success(let allNotifs):
				allNotifs.forEach { (notif) in
					//					notif.favorite [TODO] -force
					self.customerDB.update(notif) {[/*manager = AppAnalytics.shared,*/ completion] (completed) in
						//            manager.log(eventName: "question_answered", parameters: ["questionEvent": notif.asSimpleNotification().eventType.asEventProtocol().getName(), "questionAnswer": answer.rawValue])
						if completion != nil {
							completion!(completed)
						}
					}
				}
			case .failure(let err):
				error(err)
			}
		}
		
		sellerDB.getAll(predicate: predicate) {[completion, error] (result) in
			switch result {
			case .success(let allNotifs):
				allNotifs.forEach { (notif) in
					notif.favorite = answer
					self.sellerDB.update(notif) {[/*manager = AppAnalytics.shared,*/ completion] (completed) in
						//            manager.log(eventName: "question_answered", parameters: ["questionEvent": notif.asSimpleNotification().eventType.asEventProtocol().getName(), "questionAnswer": answer.rawValue])
						if completion != nil {
							completion!(completed)
						}
					}
				}
			case .failure(let err):
				error(err)
			}
		}
	}
	
	func insert(ImagesWithModel: String){
		
	}
}
extension Array {
	func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
		var set = Set<T>() //the unique list kept in a Set for fast retrieval
		var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
		for value in self {
			if !set.contains(map(value)) {
				set.insert(map(value))
				arrayOrdered.append(value)
			}
		}
		
		return arrayOrdered
	}
}
