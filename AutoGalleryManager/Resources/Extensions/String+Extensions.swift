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
}
