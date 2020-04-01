//
//  LandingListController.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable
import CoreDataManager
import Domain
import RxSwift
import RxCocoa
class LandingListController: UIViewController {
	
	@IBOutlet weak var tableView: BEKMultiCellTable!
	var controllerType: AdvertiseFlatViewModelType
	var navigator: LandingNavigator!
	
	@IBOutlet weak var clearImageView: UIImageView!
	@IBOutlet weak var searchContainer: UIView!
	@IBOutlet weak var searchTextField: UITextField!
	let disposeBag = DisposeBag()
	var titleLabel: UILabel!
	init(navigator: LandingNavigator, controllerType: AdvertiseFlatViewModelType) {
		self.navigator = navigator
		self.controllerType = controllerType
		super.init(nibName: "LandingListController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		searchTextField.font = UIFont.getRegularFont(size: 14)
		searchTextField.rx.text.subscribe(onNext: { [setupUI](searchKey) in
			setupUI()
		}).disposed(by: disposeBag)
		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
	}
	func setupUI(){
		searchContainer.layer.cornerRadius = searchContainer.bounds.height / 2
		searchContainer.layer.borderColor = UIColor.lightGray.cgColor
		searchContainer.layer.borderWidth = 0.5
		tableView.removeAll()
		tableView.rowHeight = 100.0
		navigationController?.navigationBar.backItem?.title = "Back".localize()
		switch controllerType {
		case .seller:
			loadSellerView(filter: searchTextField.text ?? "")
			setupNavigationBar(titleText: "Tab_2_Title".localize())
		default:
			loadCustomerView(filter: searchTextField.text ?? "")
			setupNavigationBar(titleText: "Tab_1_Title".localize())
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupUI()
	}
	
	@IBAction func clearSearch(_ sender: Any) {
		searchTextField.text = ""
		setupUI()
	}
	
	func setupNavigationBar(titleText: String) {
		navigationItem.title = .none
		
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
//			self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
//			self.navigationController?.navigationBar.shadowImage = UIImage()
//			self.navigationController?.navigationBar.layoutIfNeeded()
			
			titleLabel = UILabel()
			titleLabel.text = titleText
			titleLabel.font = UIFont.getBoldFont(size: 24)
			titleLabel.translatesAutoresizingMaskIntoConstraints = false
			titleLabel.textAlignment = .right
			let targetView = self.navigationController?.navigationBar
			targetView?.addSubview(titleLabel)
			titleLabel.anchor(top: nil, left: nil, bottom: targetView?.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 32, paddingBottom: 8, paddingRight: 32, width: view.bounds.width - 32, height: 40)
			
			titleLabel.centerXAnchor.constraint(equalTo: (targetView?.centerXAnchor)!).isActive = true
			
		} else {
			// Fallback on earlier versions
		}
	}
}

//MARK:- makers
extension LandingListController {
	func makeNavigationController() -> UINavigationController{
		let result = UINavigationController()
		result.navigationBar.prefersLargeTitles = true
		result.setNavigationBarHidden(false, animated: false)
		result.viewControllers = [self]
		return result
	}
}

//MARK:- Loaders
extension LandingListController {
	
	func loadSellerView(filter: String){
		
		tabBarItem = UITabBarItem(title: "Tab_2_Title".localize(), image: UIImage(named: "Tab_2"), tag: 0)
		DatabaseManager.shared.getSellers(response: { [tableView](items) in
			let viewModels = items.compactMap{$0.asViewModel()}.filter(byKey: filter)
			tableView?.push(cells: viewModels.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
			
		}) { (error) in
			let models = [
				SellerDomainModel(id: "test", title: "", carName: "باکستر", creationDate: Date(), descriptionText: "خیلی تر و تمیز واقع در پاسداران گلستان دهم معاوضه هم دارد - کروک - نیم فول - داخل اسپورت پلاس و pdk ندارد.", bodyColored: .noColor, phoneNumber: "09125889838", price: 1552, userName: "امیر خدابین", yearModel: 2011, color: "مشکی", isAutomatic: true, brandName: "پورشه"),
				SellerDomainModel(id: "test", title: "", carName: "پانامرا", creationDate: Date(), descriptionText: "خیلی تر و تمیز واقع در پاسداران گلستان دهم معاوضه هم دارد - کروک - نیم فول - داخل اسپورت پلاس و pdk ندارد.", bodyColored: .noColor, phoneNumber: "09125889838", price: 389, userName: "بهراد کاظمی", yearModel: 2011, color: "آبی", isAutomatic: true, brandName: "پورشه"),
				SellerDomainModel(id: "test", title: "", carName: "تایکان", creationDate: Date(), descriptionText: "خیلی تر و تمیز واقع در پاسداران گلستان دهم معاوضه هم دارد - کروک - نیم فول - داخل اسپورت پلاس و pdk ندارد.", bodyColored: .noColor, phoneNumber: "09125889838", price: 530, userName: "بهراد کاظمی", yearModel: 2011, color: "زرد", isAutomatic: true, brandName: "پورشه"),
				SellerDomainModel(id: "test", title: "آقای میمنت", carName: "کیمن", creationDate: Date(), descriptionText: "خیلی تر و تمیز واقع در پاسداران گلستان دهم معاوضه هم دارد - کروک - نیم فول - داخل اسپورت پلاس و pdk ندارد.", bodyColored: .noColor, phoneNumber: "09125889838", price: 452, userName: "بهراد کاظمی", yearModel: 2011, color: "سبز", isAutomatic: true, brandName: "پورشه")
				].compactMap{$0.asViewModel()}.filter(byKey: filter)
			tableView?.push(cells: models.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
		}
	}
	
	func loadCustomerView(filter: String) {
		tabBarItem = UITabBarItem(title: "Tab_1_Title".localize(), image: UIImage(named: "Tab_1"), tag: 0)
		DatabaseManager.shared.getCustomers(response: { [tableView](items) in
			let viewModels = items.compactMap{$0.asViewModel()}.filter(byKey: filter)
			tableView?.push(cells: viewModels.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
			
		}) { (error) in
			let models = [
				CustomerDomainModel(id: "Test", title: "", carName: "x3", creationDate: Date(), descriptionText: "فنی سالم پول به صورت چند فقره چک آماده است با زمین هم معاوضه دارد", bodyColored: .singlePiece, phoneNumber: "09125889838", priceRange: "۱۲۰۰ میلیون تومان", userName: "بهراد کاظمی", year: 2018),
				CustomerDomainModel(id: "Test", title: "", carName: "بورگوارد", creationDate: Date(), descriptionText: "فنی سالم پول به صورت چند فقره چک آماده است با زمین هم معاوضه دارد", bodyColored: .singlePiece, phoneNumber: "09125889838", priceRange: "۸۰۰ میلیون تومان", userName: "آقای مدیری", year: 2019),
				CustomerDomainModel(id: "Test", title: "", carName: "پاسات", creationDate: Date(), descriptionText: "فنی سالم پول به صورت چند فقره چک آماده است با زمین هم معاوضه دارد", bodyColored: .singlePiece, phoneNumber: "09125889838", priceRange: "۱۲۰۰ میلیون تومان", userName: "حاج منصور", year: 2019),
				CustomerDomainModel(id: "Test", title: "", carName: "x6", creationDate: Date(), descriptionText: "فنی سالم پول به صورت چند فقره چک آماده است با زمین هم معاوضه دارد", bodyColored: .singlePiece, phoneNumber: "09125889838", priceRange: "۱۹۰۰ میلیون تومان", userName: "بهراد کاظمی", year: 2015)
				].compactMap{$0.asViewModel()}.filter(byKey: filter)
						tableView?.push(cells: models.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
		}
	}
}

extension BEKMultiCellTable {
	func removeAll(){
		let count = numberOfRows(inSection: 0)
		(0..<count).forEach { (_) in
			remove(cellAtIndex: 0)
		}
	}
}
extension LandingListController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? AdvertiseCell{
			navigator.toDetails(viewModel: cell.vm)
		}
	}
}
