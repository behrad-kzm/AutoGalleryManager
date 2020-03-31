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
