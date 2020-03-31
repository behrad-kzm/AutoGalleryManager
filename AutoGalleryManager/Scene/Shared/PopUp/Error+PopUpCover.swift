//
//  Error+PopUpCover.swift
//  BEKApps
//
//  Created by Behrad Kazemi on 12/9/19.
//  Copyright © 2019 BEKApps. All rights reserved.
//

import Foundation
import UIKit

extension Error {
  func asPopUpCoverViewModel() -> PopUpCoverViewModel{
    let error = self as NSError
    
    let descriptionText: String
    switch error.code {
    case -1004:
      descriptionText = "ConnectionProblem".localize()
    default:
      descriptionText = error.userInfo["message"] as? String ?? "UnknownError".localize()
    }
    let color = UIColor.systemOrange
    return PopUpCoverViewModel(image: UIImage(named: "Warning")!, title: "AnErrorOccured".localize() , description: descriptionText, imageColor: color)
  }
}
