//
//  SliderItemCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/5/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellCollection
import Domain
class SliderItemCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	var model: SliderCellItemVM!
	var cellSize: CGSize = .zero
	@IBOutlet weak var removeContainer: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension SliderItemCell: BEKBindableCell{
	
	typealias ViewModelType = SliderCellItemVM
	func bindData(withViewModel viewModel: SliderCellItemVM, size: CGSize) {
		cellSize = size
		model = viewModel
		removeContainer.isHidden = !viewModel.editing
		imageView.image = UIImage(data: viewModel.model.data)
	}
}
