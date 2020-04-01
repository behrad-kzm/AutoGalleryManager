//
//  TitleCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable

class TitleCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	var title = ""
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		titleLabel.font = UIFont.getBoldFont(size: 18)
		// Configure the view for the selected state
	}
	
}

extension TitleCell: BEKBindableCell {
	typealias ViewModeltype = String
	func bindData(withViewModel viewModel: String) {
		title = viewModel
		titleLabel.text = title
	}
}
