//
//  DetailsController.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable

class DetailsController: UIViewController {
	
	@IBOutlet weak var callLabel: UILabel!
	@IBOutlet weak var callButtonContainer: UIView!
	var controllerType: AdvertiseViewModelType
	var navigator: Navigator!
	var titleLabel: UILabel!
	
	
	@IBOutlet weak var tableView: BEKMultiCellTable!
	init(navigator: Navigator, controllerType: AdvertiseViewModelType) {
		self.navigator = navigator
		self.controllerType = controllerType
		super.init(nibName: "DetailsController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeUI()
		view.layoutIfNeeded()
		view.layoutSubviews()
		// Do any additional setup after loading the view.
	}
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: false)
		titleLabel.removeFromSuperview()
		super.viewWillDisappear(animated)
	}
	@IBAction func callAction(_ sender: Any) {
		let phoneNumberText: String
		switch controllerType {
		case let .seller(vm):
			phoneNumberText = vm.phoneNumber
		case let .customer(vm):
			phoneNumberText = vm.phoneNumber
		}
		callNumber(phoneNumber: phoneNumberText)
	}
	
	private func callNumber(phoneNumber:String) {
		if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
			
			let application:UIApplication = UIApplication.shared
			if (application.canOpenURL(phoneCallURL)) {
				application.open(phoneCallURL, options: [:], completionHandler: nil)
			}
		}
	}
	
	func setupNavigationBar(titleText: String) {
		navigationController?.setNavigationBarHidden(false, animated: true)
		if #available(iOS 11.0, *) {
			
			navigationController?.navigationBar.prefersLargeTitles = true
			titleLabel = UILabel()
			titleLabel.text = titleText
			titleLabel.font = UIFont.getBoldFont(size: 24)
			titleLabel.translatesAutoresizingMaskIntoConstraints = false
			titleLabel.textAlignment = .right
			let targetView = self.navigationController?.navigationBar
			targetView?.addSubview(titleLabel)
			titleLabel.anchor(top: nil, left: nil, bottom: targetView?.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 8, paddingRight: 32, width: view.bounds.width - 32, height: 32)
			
			titleLabel.centerXAnchor.constraint(equalTo: (targetView?.centerXAnchor)!).isActive = true
			
		} else {
			// Fallback on earlier versions
		}
	}
}

extension DetailsController {
	func makeUI(){
		callLabel.font = UIFont.getBoldFont(size: 15)
		callLabel.textColor = .white
		callButtonContainer.layer.cornerRadius = callButtonContainer.bounds.height / 2
		callButtonContainer.layoutIfNeeded()
		callButtonContainer.backgroundColor = .systemGreen
		callButtonContainer.clipsToBounds = true
		
		switch controllerType {
		case let .seller(vm):
			setupUI(forViewModel: vm)
		case let .customer(vm):
			setupUI(forViewModel: vm)
		}
		addContactCell()
	}
	
	func setupUI(forViewModel viewModel: SellerAdViewModel){
		callLabel.text = "CallWith".localize() + " " + viewModel.userName
		setupNavigationBar(titleText: viewModel.title)
		[
			CommonInfoVM(title: "Brand_Title".localize(), description: viewModel.brandName),
			CommonInfoVM(title: "CarName_Title".localize(), description: viewModel.carName),
			CommonInfoVM(title: "BodyColor_Title".localize(), description: viewModel.bodyColored),
			CommonInfoVM(title: "Year_Title".localize(), description: viewModel.yearModel),
			CommonInfoVM(title: "Color_Title".localize(), description: viewModel.color),
			CommonInfoVM(title: "Automatic_Title".localize(), description: viewModel.gearBoxType),
			CommonInfoVM(title: "Description_Title".localize(), description: viewModel.descriptionText),
			CommonInfoVM(title: "Price_Title".localize(), description: viewModel.price)
			//			CommonInfoVM(title: "Date_Title".localize(), description: viewModel.),
			].forEach { (item) in
				addInfoCell(model: item)
		}
	}
	
	func setupUI(forViewModel viewModel: CustomerAdViewModel){
		callLabel.text = "CallWith".localize() + " " + viewModel.userName
		setupNavigationBar(titleText: viewModel.title)
		[
			CommonInfoVM(title: "CarName_Title".localize(), description: viewModel.carName),
			CommonInfoVM(title: "BodyColor_Title".localize(), description: viewModel.bodyColored),
			CommonInfoVM(title: "Year_Title".localize(), description: viewModel.yearModel),
			CommonInfoVM(title: "Description_Title".localize(), description: viewModel.descriptionText),
			CommonInfoVM(title: "Price_Title".localize(), description: viewModel.priceRange),
			CommonInfoVM(title: "Date_Title".localize(), description: viewModel.date)
			].forEach { (item) in
				addInfoCell(model: item)
		}
	}
	
	func addContactCell(){
		tableView?.push(cell: BEKGenericCell<ContactInfoCell>(viewModel: controllerType.asAdvertiseConvertable().getContactInfo()))
	}
	
	func addInfoCell(model: CommonInfoVM){
		tableView?.push(cell: BEKGenericCell<CommonInfoCell>(viewModel: model))
	}
}
