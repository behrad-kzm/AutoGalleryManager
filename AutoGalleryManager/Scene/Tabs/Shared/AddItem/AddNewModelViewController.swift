//
//  AddNewSeller.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 3/28/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreDataManager
import Domain
//import RxDataSources
class AddNewModelViewController: UIViewController {
	
	@IBOutlet weak var gearboxMainContainer: UIStackView!
	@IBOutlet weak var colorMainContainer: UIStackView!
	@IBOutlet weak var brandMainContainer: UIStackView!
	@IBOutlet weak var imageCollectionContainer: UIView!
	@IBOutlet weak var imageCollection: UICollectionView!
	
	@IBOutlet weak var detailsContainerView: UIView!
	@IBOutlet weak var carDetailsContainerView: UIView!
	@IBOutlet weak var contactDetailsContainerView: UIView!
	@IBOutlet weak var descriptionContainer: UIView!
	@IBOutlet weak var priceFromContainer: UIStackView!
	@IBOutlet weak var priceToContainer: UIStackView!
	
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var yearTextField: UITextField!
	@IBOutlet weak var colorTextField: UITextField!
	@IBOutlet weak var priceTextField: UITextField!
	@IBOutlet weak var carNameTextField: UITextField!
	@IBOutlet weak var brandTextField: UITextField!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var automaticSwitch: UISwitch!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var priceFromTextField: UITextField!
	@IBOutlet weak var priceToTextField: UITextField!
	@IBOutlet weak var kilometerTextField: UITextField!
	@IBOutlet weak var contactInfoDescriptionTextView: UITextView!
	@IBOutlet weak var bodyPicker: UIPickerView!
	
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var bodyColorLabel: UILabel!
	@IBOutlet weak var colorLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var carNameLabel: UILabel!
	@IBOutlet weak var brandLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var automaticLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	@IBOutlet weak var kilometerMainContainer: UIStackView!
	@IBOutlet weak var sellerPriceContainer: UIStackView!
	

	@IBOutlet weak var mainScrollView: UIScrollView!
	@IBOutlet weak var detailsLabel: UILabel!
	@IBOutlet weak var carDetailsLabel: UILabel!
	@IBOutlet weak var contactDetailsLabel: UILabel!
	@IBOutlet weak var largeTitleLabel: UILabel!
	var navigator: Navigator!
	@IBOutlet weak var saveButton: UIButton!

	let disposeBag = DisposeBag()
	let bodyColorItems = [BodyColoredType.noColor, .singlePiece, .twoPiece, .threeAndMore, .over, .complete, .unknown]
	var controllerType: AdvertiseFlatViewModelType
	var editingControllerType: AdvertiseViewModelType?
	init(navigator: Navigator, controllerType: AdvertiseFlatViewModelType) {
		self.navigator = navigator
		self.controllerType = controllerType
		super.init(nibName: "AddNewModelViewController", bundle: nil)
	}
	
	init(navigator: Navigator, controllerType: AdvertiseViewModelType) {
		self.navigator = navigator
		self.controllerType = controllerType.flat()
		self.editingControllerType = controllerType
		super.init(nibName: "AddNewModelViewController", bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageCollection.register(UINib(nibName: "SliderItemCell", bundle: nil), forCellWithReuseIdentifier: "id")
		imageCollection.delegate = self
		imageCollection.dataSource = self
		navigationController?.setNavigationBarHidden(false, animated: false)
		bodyPicker.dataSource = self
		bodyPicker.delegate = self
		mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
		setupUI()
	}
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: false)
		super.viewWillDisappear(animated)
	}
	
	func setupUI() { //Fill here if needed
		descriptionContainer.layer.cornerRadius = 4
		descriptionContainer.layer.borderColor = UIColor.lightGray.cgColor
		descriptionContainer.layer.borderWidth = 1
		
		var textFields = [phoneTextField,
											userNameTextField,
											yearTextField,
											colorTextField,
											priceTextField,
											carNameTextField,
											brandTextField]
		
		var labels = [phoneLabel,
									userNameLabel,
									yearLabel,
									colorLabel,
									priceLabel,
									carNameLabel,
									brandLabel]
		
		if controllerType == .customer {
			imageCollectionContainer.isHidden = true
			largeTitleLabel.text = "خریدار جدید"
			colorMainContainer.isHidden = true
			brandMainContainer.isHidden = true
			sellerPriceContainer.isHidden = true
			colorMainContainer.isHidden = true
			kilometerMainContainer.isHidden = true
			textFields = [phoneTextField,
										userNameTextField,
										yearTextField,
										priceTextField,
										carNameTextField
			]
			
			labels = [phoneLabel,
								userNameLabel,
								yearLabel,
								priceLabel,
								carNameLabel
			]
		} else {
			
			priceFromContainer.isHidden = true
			priceToContainer.isHidden = true
		}
		
		//		let validData = Observable.combineLatest(textFields.compactMap{$0?.rx.text}).map{
		//			$0.filter { (string) -> Bool in
		//				return string?.isEmpty ?? true
		//			}.isEmpty
		//		}
		zip(textFields.compactMap{$0}, labels.compactMap{$0}).forEach { (textField, label) in
			textField.rx.text.map{$0?.isEmpty ?? true}.map{$0 ? UIColor.red : UIColor.darkText}.skip(1).subscribe(onNext: { (color) in
				label.textColor = color
			}).disposed(by: disposeBag)
		}
		
		loadModelIfNeeded()
		//		validData.bind(to: saveButton.rx.isUserInteractionEnabled).disposed(by: disposeBag)
	}
	
	func loadModelIfNeeded() {
		if let safeModel = editingControllerType{
			switch safeModel {
			case let .seller(vm):
				phoneTextField.text = vm.phoneNumber
				userNameTextField.text = vm.userName
				yearTextField.text = String(vm.model.yearModel)
				colorTextField.text = vm.color
				priceTextField.text = String(vm.model.price)
				carNameTextField.text = vm.carName
				brandTextField.text = vm.brandName
				titleTextField.text = vm.title
				automaticSwitch.isOn = vm.favorite
				descriptionTextView.text = vm.descriptionText
				kilometerTextField.text = String(vm.kilometer)
				contactInfoDescriptionTextView.text = vm.contactDescription
				let index = Int(bodyColorItems.lastIndex(where: { (item) -> Bool in
					return item == vm.model.bodyColored
					}) ?? 0)
				bodyPicker.selectRow(index, inComponent: 0, animated: true)
//				DataBa
//				imageCollection.rx.items(cellIdentifier: "id", cellType: SliderItemCell.self)
				break
			case let .customer(vm):
				phoneTextField.text = vm.phoneNumber
				userNameTextField.text = vm.userName
				yearTextField.text = String(vm.model.year)
				carNameTextField.text = vm.carName
				titleTextField.text = vm.title
				automaticSwitch.isOn = vm.favorite
				descriptionTextView.text = vm.descriptionText
				priceFromTextField.text = String(vm.model.priceFrom)
				priceToTextField.text = String(vm.model.priceTo)
//				kilometerTextField.text = String(vm.kilometer)
				contactInfoDescriptionTextView.text = vm.contactDescription
				let index = Int(bodyColorItems.lastIndex(where: { (item) -> Bool in
					return item == vm.model.bodyColored
					}) ?? 0)
				bodyPicker.selectRow(index, inComponent: 0, animated: true)
				
				break
			}
		}
	}
	
	@IBAction func saveData(_ sender: Any) {
		var safeID = UUID().uuidString
		
		if let safeModelId = editingControllerType?.asAdvertiseConvertable().id  {
			safeID = safeModelId
		}
		
		switch controllerType {
		case .seller:
			let bodyColored = bodyColorItems[bodyPicker.selectedRow(inComponent: 0)]
			let model = SellerDomainModel(id: safeID,
																		title: titleTextField.text ?? "" ,
																		carName: carNameTextField.text ?? "",
																		creationDate: Date(),
																		descriptionText: descriptionLabel.text ?? "",
																		bodyColored: bodyColored,
																		phoneNumber: phoneTextField.text?.toEnDigits ?? "",
																		price: Int16(priceTextField.text?.toEnDigits ?? "") ?? 0,
																		userName: userNameTextField.text ?? "",
																		kilometer: Int16(kilometerTextField.text?.toEnDigits ?? "") ?? 0, contactDesc: contactInfoDescriptionTextView.text ,
																		yearModel: Int16(yearTextField.text?.toEnDigits ?? "") ?? 0,
																		color: colorTextField.text ?? "",
																		favorite: automaticSwitch.isOn,
																		brandName: brandTextField.text ?? "")
			
			DatabaseManager.shared.add(Seller: model) { [navigator](updated) in
				navigator?.toTabbar()
			}
			break
		case .customer:
			let bodyColored = bodyColorItems[bodyPicker.selectedRow(inComponent: 0)]
			let model = CustomerDomainModel(id: safeID,
																			title: titleTextField.text ?? "" ,
																			carName: carNameTextField.text ?? "",
																			creationDate: Date(),
																			descriptionText: descriptionLabel.text ?? "", contactDesc: contactInfoDescriptionTextView.text,
																			bodyColored: bodyColored,
																			phoneNumber: phoneTextField.text?.toEnDigits ?? "",
																			userName: userNameTextField.text ?? "",
																			priceFrom: Int16(priceFromTextField.text?.toEnDigits ?? "") ?? 0,
																			priceTo: Int16(priceToTextField.text?.toEnDigits ?? "") ?? 0,
																			favorite: automaticSwitch.isOn,
																			year: Int16(yearTextField.text?.toEnDigits ?? "") ?? 0)
			
			DatabaseManager.shared.add(Customer: model) { [navigator](updated) in
				navigator?.toTabbar()
			}
			break
		}
	}
}

extension AddNewModelViewController: UIPickerViewDataSource, UIPickerViewDelegate{
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return bodyColorItems.count
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var label = UILabel()
		if let v = view as? UILabel { label = v }
		label.font = UIFont.getRegularFont(size: 12)
		label.text =  bodyColorItems.compactMap{$0.getTitle()}[row]
		label.textAlignment = .center
		return label
	}
}
