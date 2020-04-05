//
//  String+Extensions.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension String {
	func localize() -> String {
		return NSLocalizedString(self, comment: "")
	}
	
	var toEnDigits : String {
		let arabicNumbers = ["۰": "0","۱": "1","۲": "2","۳": "3","۴": "4","۵": "5","۶": "6","۷": "7","۸": "8","۹": "9"]
		var txt = self
		arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
		return txt
	}
	
}
