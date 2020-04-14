//
//  ImagePreviewController.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit

class ImagePreviewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	var imageData: Data?
	override func viewDidLoad() {
		super.viewDidLoad()

		if let safeData = imageData{
			imageView.image = UIImage(data: safeData)
		}
		// Do any additional setup after loading the view.
	}
	
}
