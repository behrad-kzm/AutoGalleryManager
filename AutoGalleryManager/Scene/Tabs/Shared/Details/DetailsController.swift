//
//  DetailsController.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
	
	@IBOutlet weak var callLabel: UILabel!
	@IBOutlet weak var callButtonContainer: UIView!
	var controllerType: AdvertiseViewModelType
	var navigator: Navigator!
	
	init(navigator: Navigator, controllerType: AdvertiseViewModelType) {
		self.navigator = navigator
		self.controllerType = controllerType
		super.init(nibName: "LandingListController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		makeUI()
		// Do any additional setup after loading the view.
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
		navigationItem.title = .none
		
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
			self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
			self.navigationController?.navigationBar.shadowImage = UIImage()
			self.navigationController?.navigationBar.layoutIfNeeded()
			let titleLabel = UILabel()
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

extension DetailsController {
	func makeUI(){
		switch controllerType {
		case let .seller(vm):
			setupUI(forViewModel: vm)
		case let .customer(vm):
			setupUI(forViewModel: vm)
		}
	}
	
	func setupUI(forViewModel viewModel: SellerAdViewModel){
		
	}
	
	func setupUI(forViewModel viewModel: CustomerAdViewModel){
		
	}
}
