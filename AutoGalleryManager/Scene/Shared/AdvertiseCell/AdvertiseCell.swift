//
//  AdvertiseCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable

class AdvertiseCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	
	@IBOutlet weak var imageTitle: UIImageView!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var shadowBackgroundView: UIView!
	var vm: AdvertiseViewModelType!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		containerView.layer.cornerRadius = 8
		containerView.clipsToBounds = true
		imageTitle.layer.cornerRadius = 8
		imageTitle.clipsToBounds = true
		
		shadowBackgroundView.dropShadow(color: .black, opacity: 0.2, offSet: .zero, radius: 4, cornerRadius: 8)
		
		titleLabel.font = UIFont.getBoldFont(size: 16)
		detailLabel.font = UIFont.getRegularFont(size: 13)
		priceLabel.font = UIFont.getRegularFont(size: 12)
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}

extension AdvertiseCell: BEKBindableCell {
    typealias ViewModeltype = AdvertiseViewModelType
    func bindData(withViewModel viewModel: AdvertiseViewModelType) {
			vm = viewModel
			priceLabel.textColor = (vm.flat() == .seller) ? .red : .systemGreen
			let adViewModel = vm.asViewModel()
			titleLabel.text = adViewModel.title
			detailLabel.text = adViewModel.subtitle
			priceLabel.text = adViewModel.price
			imageTitle.image = UIImage(named: adViewModel.imageName)
    }
}
