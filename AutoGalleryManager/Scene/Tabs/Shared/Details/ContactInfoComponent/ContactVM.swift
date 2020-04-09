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
	let desciptionText: String
	init(phone: String, user: String, desciptionText: String) {
		self.phoneNumber = "Mobile".localize() + " : " + phone
		self.userName = "Name".localize() + " : " + user
		self.desciptionText = desciptionText
	}
}

extension AdvertiseConvertable {
	func getContactInfo() -> ContactVM {
		return ContactVM(phone: phoneNumber, user: userName, desciptionText: contactDescription)
	}
}
