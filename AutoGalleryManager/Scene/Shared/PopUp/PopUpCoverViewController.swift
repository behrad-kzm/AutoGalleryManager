//
//  ErrorViewController.swift
//  BEKApps
//
//  Created by Behrad Kazemi on 12/7/19.
//  Copyright © 2019 BEKApps. All rights reserved.
//

import UIKit

class PopUpCoverViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var buttonLabel: UILabel!
  @IBOutlet weak var buttonContainerView: UIView!
  
  @IBOutlet weak var mainView: UIView!
  var viewModel: PopUpCoverViewModel!
  
  override func loadView() {
    super.loadView()
    setupUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AppSoundEffects().playErrorSound()
    Vibrator.vibrate(hardness: 1)
  }
  @IBAction func buttonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  private func setupUI(){
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    
    imageView.image = viewModel.image
    if let color = viewModel.imageColor{
      imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
      imageView.tintColor = color
    }
    
    buttonLabel.text = "OK".localize()
    
    mainView.layer.shadowColor = UIColor.black.cgColor
    mainView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    mainView.layer.shadowOpacity = 0.5
    mainView.layer.shadowRadius = 4.0
    mainView.layer.cornerRadius = 48.0
    containerView.layer.cornerRadius = 48.0
    containerView.layer.masksToBounds = true
    
    
    buttonContainerView.layer.cornerRadius = buttonContainerView.frame.height / 2
    buttonContainerView.clipsToBounds = true
    
  }
  
}
