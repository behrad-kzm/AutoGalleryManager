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
	@IBOutlet weak var noContentLabel: UILabel!
	
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
	
	@IBAction func addModelAction(_ sender: Any) {
		navigator.toAddNewModel(type: controllerType)
	}
	
	func setupUI(){
		searchContainer.layer.cornerRadius = searchContainer.bounds.height / 2
		searchContainer.layer.borderColor = UIColor.lightGray.cgColor
		searchContainer.layer.borderWidth = 0.5
		if tableView.visibleCells.count > 0 {
			tableView.removeAll()
			tableView.reloadData()
		}
		tableView.rowHeight = 100.0
		
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
extension LandingListController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? AdvertiseCell{
			navigator.toDetails(viewModel: cell.vm)
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
		
		DatabaseManager.shared.getSellers(response: { [tableView](items) in
			noContentLabel.isHidden = true
			let viewModels = items.compactMap{$0.asViewModel()}.filter(byKey: filter)
			tableView?.push(cells: viewModels.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
			
		}) { (error) in
			noContentLabel.isHidden = false
		}
	}
	
	func loadCustomerView(filter: String) {
		
		DatabaseManager.shared.getCustomers(response: { [tableView](items) in
			noContentLabel.isHidden = true
			let viewModels = items.compactMap{$0.asViewModel()}.filter(byKey: filter)
			tableView?.push(cells: viewModels.compactMap{BEKGenericCell<AdvertiseCell>(viewModel: $0.asType())})
			
		}) { (error) in
			noContentLabel.isHidden = false
		}
	}
}
