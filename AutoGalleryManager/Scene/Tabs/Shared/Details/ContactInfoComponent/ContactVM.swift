//
//  ContactVM.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
struct ContactVM {
	let phoneNumber: String
	let userName: String
	
	init(phone: String, user: String) {
		self.phoneNumber = "Mobile".localize() + " : " + phone
		self.userName = "Name".localize() + " : " + user
	}
}

extension AdvertiseConvertable {
	func getContactInfo() -> ContactVM {
		return ContactVM(phone: phoneNumber, user: userName)
	}
}
