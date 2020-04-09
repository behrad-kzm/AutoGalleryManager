//
//  SliderCell+BEKCollection.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import BEKMultiCellTable
extension SliderCell: BEKBindableCell{
	typealias ViewModelType = SliderVM
	func bindData(withViewModel viewModel: SliderVM) {
		model = viewModel
		collectionView.reloadData()
	}
}
