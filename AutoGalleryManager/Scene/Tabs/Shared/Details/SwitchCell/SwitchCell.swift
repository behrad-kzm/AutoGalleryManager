//
//  SwitchCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/3/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable
import FaveButton
import MHSoftUI
protocol SwitchCellDelegate {
	func newState(selected: Bool)
}
class SwitchCell: UITableViewCell {
	

	@IBOutlet weak var removeButton: UIButton!
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var faveContainer: UIView!
	var model: SwitchCellVM!
	var faveButton: FaveButton!
	override func awakeFromNib() {
		editButton.addSoftUIEffectForButton()
		removeButton.addSoftUIEffectForButton()
		faveButton = FaveButton(
			frame: CGRect(x: 0, y: 0, width: 48, height: 48),
			faveIconNormal: UIImage(named: "Fave1")
		)
		faveContainer.addSubview(faveButton)
		faveButton.delegate = self
		faveButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		faveButton.center = CGPoint(x: faveContainer.bounds.width / 2, y: faveContainer.bounds.height / 2)
		super.awakeFromNib()
	}
	
	@IBAction func removeAction(_ sender: Any) {
		Vibrator.vibrate(hardness: 5)
		model.removeAction()
	}
	
	@IBAction func editAction(_ sender: Any) {
		Vibrator.vibrate(hardness: 5)
		model.editAction()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
	}
}
extension SwitchCell: FaveButtonDelegate{
	func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
		model.delegate(selected)
	}
}

extension SwitchCell: BEKBindableCell {
	typealias ViewModeltype = SwitchCellVM
	func bindData(withViewModel viewModel: SwitchCellVM) {
		model = viewModel
		faveButton.isSelected = viewModel.isOn
		
		
	}
}
