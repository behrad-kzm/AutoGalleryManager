//
//  ContactInfoCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable
class ContactInfoCell: UITableViewCell {
	
	@IBOutlet weak var shadowContainer: UIView!
	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		containerView.layer.cornerRadius = 8
		containerView.clipsToBounds = true
		
		shadowContainer.dropShadow(color: .black, opacity: 0.2, offSet: .zero, radius: 4, cornerRadius: 8)
		detailLabel.font = UIFont.getRegularFont(size: 13)
		phoneLabel.font = UIFont.getRegularFont(size: 12)
		titleLabel.font = UIFont.getBoldFont(size: 15)
		titleLabel.text = "ContactInfo".localize()

	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

extension ContactInfoCell: BEKBindableCell {
	typealias ViewModeltype = ContactVM
	func bindData(withViewModel viewModel: ContactVM) {
		detailLabel.text = viewModel.userName
		phoneLabel.text = viewModel.phoneNumber
	}
}
