//
//  SwitchCellVM.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/3/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
struct  SwitchCellVM {
	let isOn: Bool
	var title: String = "Favorite_Title".localize()
	let delegate: (Bool) -> Void
	let removeAction: () -> Void
	let editAction: () -> Void
}
