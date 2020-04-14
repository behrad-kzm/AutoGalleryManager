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
import BEKMultiCellCollection
//import RxDataSources
class AddNewModelViewController: UIViewController {
	
	@IBOutlet weak var innerColorContainer: UIStackView!
	@IBOutlet weak var gearboxMainContainer: UIStackView!
	@IBOutlet weak var colorMainContainer: UIStackView!
	@IBOutlet weak var brandMainContainer: UIStackView!
	@IBOutlet weak var imageCollectionContainer: UIView!
	@IBOutlet weak var imageCollection: BEKMultiCellCollection!
	
	@IBOutlet weak var detailsContainerView: UIView!
	@IBOutlet weak var carDetailsContainerView: UIView!
	@IBOutlet weak var contactDetailsContainerView: UIView!
	@IBOutlet weak var descriptionContainer: UIView!
	@IBOutlet weak var priceFromContainer: UIStackView!
	@IBOutlet weak var priceToContainer: UIStackView!
	
	@IBOutlet weak var innerColorTextField: UITextField!
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
	
	@IBOutlet weak var innerColorLabel: UILabel!
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
	
	@IBOutlet weak var contactDescriptionContainer: UIView!
	
	@IBOutlet weak var mainScrollView: UIScrollView!
	@IBOutlet weak var detailsLabel: UILabel!
	@IBOutlet weak var carDetailsLabel: UILabel!
	@IBOutlet weak var contactDetailsLabel: UILabel!
	@IBOutlet weak var largeTitleLabel: UILabel!
	var navigator: Navigator!
	var globalSafeModelId = UUID().uuidString
	var images = [ImageDomainModel](){
		didSet{
			loadImages()
		}
	}
	
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
		if let id = controllerType.asAdvertiseConvertable().id {
			self.globalSafeModelId = id
		}
		
		super.init(nibName: "AddNewModelViewController", bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		bodyPicker.dataSource = self
		bodyPicker.delegate = self
		mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		loadSlider()
	}
	func setupUI() { //Fill here if needed
		contactInfoDescriptionTextView.textAlignment = .right
		descriptionTextView.textAlignment = .right
		descriptionContainer.layer.cornerRadius = 4
		descriptionContainer.layer.borderColor = UIColor.lightGray.cgColor
		descriptionContainer.layer.borderWidth = 1
		imageCollectionContainer.layer.cornerRadius = 8
		imageCollectionContainer.layer.borderWidth = 1
		imageCollectionContainer.layer.borderColor = UIColor.lightGray.cgColor
		
		contactDescriptionContainer.layer.cornerRadius = 8
		contactDescriptionContainer.layer.borderWidth = 1
		contactDescriptionContainer.layer.borderColor = UIColor.lightGray.cgColor
		var textFields = [phoneTextField,
											userNameTextField,
											yearTextField,
											innerColorTextField,
											colorTextField,
											priceTextField,
											carNameTextField,
											brandTextField]
		
		var labels = [phoneLabel,
									userNameLabel,
									yearLabel,
									colorLabel,
									innerColorLabel,
									priceLabel,
									carNameLabel,
									brandLabel]
		
		if controllerType == .customer {
			imageCollectionContainer.isHidden = true
			largeTitleLabel.text = "خریدار جدید"
			colorMainContainer.isHidden = true
			innerColorContainer.isHidden = true
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
			imageCollectionContainer.isHidden = false
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
				innerColorTextField.text = vm.innerColor
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
		func loadImages(){
			print("Reload Images")

				imageCollection.removeAll()
				let viewModelItems = images.compactMap { (model) -> SliderCellItemVM in
					return  SliderCellItemVM(model: model, editing: true)
				}
				let cells = viewModelItems.compactMap({ (vm) -> BEKGenericCellType in
					return BEKGenericCollectionCell<SliderItemCell>(viewModel: vm, size:  CGSize(width: imageCollection.bounds.width - 64 , height: imageCollection.bounds.height))
				})
				imageCollection.push(cells: cells)
		}
	func loadSlider(){
		
		if let safeId = editingControllerType?.asAdvertiseConvertable().id {
			DatabaseManager.shared.getImageModels(forModelId: safeId, response: { [unowned self](items) in
				self.images = items
			}) { (error) in
				
			}
		}
		imageCollection.onClick { [loadSlider, unowned self](type) in
			
			if let cell = type as? BEKGenericCollectionCell<SliderItemCell>, let imageId = cell.viewModel.model.imageId {
				DatabaseManager.shared.delete(ImageModels: [imageId]) { [loadSlider](updated) in
					loadSlider()
				}
				self.images = self.images.filter({ (item) -> Bool in
					item.imageId != imageId
				})
			}
		}
	}
	
	@IBAction func addImage(_ sender: Any) {
		let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
			self.openCamera()
		}))
		
		alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
			self.openGallery()
		}))
		
		alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func saveData(_ sender: Any) {
		var safeID = globalSafeModelId
		
		if let safeModelId = editingControllerType?.asAdvertiseConvertable().id  {

			safeID = safeModelId
			DatabaseManager.shared.delete(forIds: [safeID]) { (updated) in
			}
		}else {
			
			images.forEach { (item) in
				DatabaseManager.shared.add(ImageModel: item) { (updated) in
				}
			}
		}
		
		switch controllerType {
		case .seller:
			let bodyColored = bodyColorItems[bodyPicker.selectedRow(inComponent: 0)]
			let model = SellerDomainModel(id: safeID,
																		title:"",
																		carName: carNameTextField.text ?? "",
																		creationDate: Date(),
																		descriptionText: descriptionLabel.text ?? "",
																		bodyColored: bodyColored,
																		phoneNumber: phoneTextField.text?.toEnDigits ?? "",
																		price: Int64(priceTextField.text?.toEnDigits ?? "") ?? 0,
																		userName: userNameTextField.text ?? "",
																		kilometer: Int64(kilometerTextField.text?.toEnDigits ?? "") ?? 0,
																		contactDesc: contactInfoDescriptionTextView.text ,
																		yearModel: Int16(yearTextField.text?.toEnDigits ?? "") ?? 0,
																		color: colorTextField.text ?? "",
																		innerColor: innerColorTextField.text ?? "",
																		favorite: automaticSwitch.isOn,
																		brandName: brandTextField.text ?? "")
			
			DatabaseManager.shared.add(Seller: model) { [navigator](updated) in
				navigator?.toTabbar()
			}
			break
		case .customer:
			let bodyColored = bodyColorItems[bodyPicker.selectedRow(inComponent: 0)]
			let model = CustomerDomainModel(id: safeID,
																			title: "" ,
																			carName: carNameTextField.text ?? "",
																			creationDate: Date(),
																			descriptionText: descriptionLabel.text ?? "",
																			contactDesc: contactInfoDescriptionTextView.text,
																			brandName: brandTextField.text ?? "",
																			bodyColored: bodyColored,
																			phoneNumber: phoneTextField.text?.toEnDigits ?? "",
																			userName: userNameTextField.text ?? "",
																			priceFrom: Int64(priceFromTextField.text?.toEnDigits ?? "") ?? 0,
																			priceTo: Int64(priceToTextField.text?.toEnDigits ?? "") ?? 0,
																			favorite: automaticSwitch.isOn,
																			year: Int16(yearTextField.text?.toEnDigits ?? "") ?? 0)
			
			DatabaseManager.shared.add(Customer: model) { [navigator](updated) in
				navigator?.toTabbar()
			}
			break
		}
		
	}
	func openCamera()
	{
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerController.SourceType.camera
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
		else
		{
			let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	func openGallery()
	{
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.allowsEditing = false
			imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
			self.present(imagePicker, animated: true, completion: nil)
		}
		else
		{
			let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
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

extension AddNewModelViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	//MARK:-- ImagePicker delegate
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let pickedImage = info[.originalImage] as? UIImage, let imageData = pickedImage.jpegData(compressionQuality: 0) {
			if let safeModelId = editingControllerType?.asAdvertiseConvertable().id  {
				let imageModel = ImageDomainModel(id: safeModelId, data: imageData, imageId: UUID().uuidString)
				DatabaseManager.shared.add(ImageModel: imageModel) { [loadSlider](updated) in
					loadSlider()
				}
			}else {
				let imageModel = ImageDomainModel(id: globalSafeModelId, data: imageData, imageId: UUID().uuidString)
				images.append(imageModel)
			}
		}
		picker.dismiss(animated: true, completion: nil)
	}
}
