//
//  DetailsController.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable
import BEKMultiCellCollection
import CoreDataManager
class DetailsController: UIViewController {
	
	@IBOutlet weak var callLabel: UILabel!
	@IBOutlet weak var callButtonContainer: UIView!
	var controllerType: AdvertiseViewModelType
	var navigator: DetailsNavigator!
	
	
	@IBOutlet weak var tableView: BEKMultiCellTable!
	init(navigator: DetailsNavigator, controllerType: AdvertiseViewModelType) {
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
		let cell = BEKGenericCell<TitleCell>(viewModel: titleText)
		tableView.push(cell: cell)
	}
	
}

extension DetailsController {
	func makeUI(){
		setupNavigationBar(titleText: controllerType.asViewModel().title)
		callLabel.font = UIFont.getBoldFont(size: 15)
		callLabel.textColor = .white
		callButtonContainer.layer.cornerRadius = callButtonContainer.bounds.height / 2
		callButtonContainer.layoutIfNeeded()
		callButtonContainer.backgroundColor = .systemGreen
		callButtonContainer.clipsToBounds = true
		
		if let safeID = controllerType.asAdvertiseConvertable().id{
			addSliderCell(modelID: safeID)
			addSwitchCell(status: controllerType.asAdvertiseConvertable().favorite, modelID: safeID)
		}
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
		
		[
			CommonInfoVM(title: "Brand_Title".localize(), description: viewModel.brandName),
			CommonInfoVM(title: "CarName_Title".localize(), description: viewModel.carName),
			CommonInfoVM(title: "BodyColor_Title".localize(), description: viewModel.bodyColored),
			CommonInfoVM(title: "Year_Title".localize(), description: viewModel.yearModel),
			CommonInfoVM(title: "Color_Title".localize(), description: viewModel.color),
			CommonInfoVM(title: "InnerColor_Title".localize(), description: viewModel.innerColor),
			CommonInfoVM(title: "Kilometer_Title".localize(), description: String(viewModel.kilometer)),
			CommonInfoVM(title: "Description_Title".localize(), description: viewModel.descriptionText),
			CommonInfoVM(title: "Price_Title".localize(), description: viewModel.price),
			CommonInfoVM(title: "Date_Title".localize(), description: viewModel.creationDateString)
			//			CommonInfoVM(title: "Date_Title".localize(), description: viewModel.),
			].forEach { (item) in
				addInfoCell(model: item)
		}
	}
	
	func setupUI(forViewModel viewModel: CustomerAdViewModel){
		callLabel.text = "CallWith".localize() + " " + viewModel.userName
		let priceString = " از " + " \(viewModel.priceFrom) " + "Million".localize() + " تا " + " \(viewModel.priceTo) " + "Million".localize()
		
		[
			CommonInfoVM(title: "Brand_Title".localize(), description: viewModel.brandName),
			CommonInfoVM(title: "CarName_Title".localize(), description: viewModel.carName),
			CommonInfoVM(title: "BodyColor_Title".localize(), description: viewModel.bodyColored),
			CommonInfoVM(title: "Year_Title".localize(), description: viewModel.yearModel),
			CommonInfoVM(title: "Description_Title".localize(), description: viewModel.descriptionText),
			CommonInfoVM(title: "Price_Title".localize(), description: priceString),
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
	
	func addSwitchCell(status: Bool, modelID: String){
		
		let cell = BEKGenericCell<SwitchCell>(viewModel: SwitchCellVM(isOn: status, delegate: {(newState) in
			
			DatabaseManager.shared.set(answer: newState, itemId: modelID, completion: { (completed) in
				if completed {
				}
			}) { (error) in
				
			}
		}, removeAction: { [navigator] in
			DatabaseManager.shared.delete(forIds: [modelID]) { [navigator](updated) in
				if updated {
					navigator?.back()
				}
			}
			}, editAction: { [navigator, controllerType] in
				navigator?.toAddNewModel(type: controllerType)
		}))
		
		tableView?.push(cell: cell)
	}
	
	func addSliderCell(modelID: String){
		DatabaseManager.shared.getImageModels(forModelId: modelID, response: { [tableView](items) in
			let viewModelItems = items.compactMap { (model) -> SliderCellItemVM in
				return  SliderCellItemVM(model: model, editing: false)
			}
			var viewModelSlider = SliderVM(items: viewModelItems)
			viewModelSlider.navigator = self.navigator
			let cell = BEKGenericCell<SliderCell>(viewModel: viewModelSlider)

			tableView?.push(cell: cell)
		}) { (error) in
			
		}
		
	}
}
