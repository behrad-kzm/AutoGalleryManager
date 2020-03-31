//
//  DataBaseErrorType.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/17/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public enum CoreDataError: Error {
  case updateError
  case addError
  case deleteError
  case isEmpty
  case getError
  case unknown
}
