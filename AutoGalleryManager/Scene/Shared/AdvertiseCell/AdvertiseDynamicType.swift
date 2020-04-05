//
//  AdvertiseDynamicType.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
enum AdvertiseViewModelType {
	case seller(SellerAdViewModel)
	case customer(CustomerAdViewModel)
	func asViewModel() -> AdvertiseViewModel {
		switch self {
		case let .seller(item):
			return item.asAdvertiseViewModel()
		case let .customer(item):
			return item.asAdvertiseViewModel()
		}
	}
	func flat() -> AdvertiseFlatViewModelType {
		switch self {
		case .seller(_):
			return .seller
		default:
			return .customer
		}
	}
	func asAdvertiseConvertable() -> AdvertiseConvertable {
		switch self {
		case let .seller(item):
			return item
		case let .customer(item):
			return item
		}
	}
}
enum AdvertiseFlatViewModelType {
	case seller
	case customer
	
}
protocol AdvertiseConvertable {
	var id: String? { get }
	var phoneNumber: String { get }
	var userName: String { get }
	var favorite: Bool { get }
	var title: String { get }
	func asAdvertiseViewModel() -> AdvertiseViewModel
	func asType() -> AdvertiseViewModelType
}
