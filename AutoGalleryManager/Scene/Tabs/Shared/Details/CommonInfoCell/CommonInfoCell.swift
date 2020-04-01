//
//  CommonInfoCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/2/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable

class CommonInfoCell: UITableViewCell {
	
	@IBOutlet weak var shadowContainer: UIView!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		containerView.layer.cornerRadius = 8
		containerView.clipsToBounds = true
		shadowContainer.dropShadow(color: .black, opacity: 0.2, offSet: .zero, radius: 4, cornerRadius: 8)
		descriptionLabel.font = UIFont.getBoldFont(size: 12)
		titleLabel.font = UIFont.getRegularFont(size: 12)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

extension CommonInfoCell: BEKBindableCell {
	typealias ViewModeltype = CommonInfoVM
	func bindData(withViewModel viewModel: CommonInfoVM) {
		titleLabel.text = viewModel.title + " : "
		descriptionLabel.text = viewModel.description
	}
}
