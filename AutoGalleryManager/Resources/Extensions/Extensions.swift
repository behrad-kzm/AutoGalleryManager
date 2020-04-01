//
//  Extensions.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import UIKit

extension BodyColoredType {
	func getTitle() -> String{
		switch self {
		case .noColor:
			return "no_BodyColor".localize()
		case .singlePiece:
			return "single_BodyColor".localize()
		case .twoPiece:
			return "two_BodyColor".localize()
		case .threeAndMore:
			return "three_BodyColor".localize()
		case .over:
			return "over_BodyColor".localize()
		case .complete:
			return "complete_BodyColor".localize()
		default:
			return "unknown_BodyColor".localize()
		}
	}
}

extension UIFont {
	static func getRegularFont(size:CGFloat) -> UIFont{
		return UIFont(name: "IRANSans", size: size)!
	}
	
	static func getBoldFont(size:CGFloat) -> UIFont{
		return UIFont(name: "IRANSans-Bold", size: size)!
	}
}

extension Array where Element == SellerAdViewModel {
	func filter(byKey key: String) -> [SellerAdViewModel] {
		if key.isEmpty {
			return self
		}
		return filter { (item) -> Bool in
			let title = item.title.contains(key)
			let bodyColored = item.bodyColored.contains(key)
			let brand = item.brandName.contains(key)
			let carName = item.carName.contains(key)
			let userName = item.userName.contains(key)
			let yearModel = item.yearModel.contains(key)
			let color = item.color.contains(key)
			return title || bodyColored || brand || carName || userName || yearModel || color
		}
	}
}
extension Array where Element == CustomerAdViewModel {
	func filter(byKey key: String) -> [CustomerAdViewModel] {
//		if key.isEmpty {
			return self
//		}
		
	}
}
