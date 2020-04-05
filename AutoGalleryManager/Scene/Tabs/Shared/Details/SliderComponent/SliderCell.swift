//
//  SliderCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/5/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellTable

class SliderCell: UITableViewCell {

	@IBOutlet weak var collectionView: UICollectionView!
	var model: SliderVM = SliderVM(images: [Data]())
	override func awakeFromNib() {
        super.awakeFromNib()
		
		collectionView.register(UINib(nibName: "SliderItemCell", bundle: nil), forCellWithReuseIdentifier: "id")
        // Initialization code
	}
	func getBannerLayout() -> UICollectionViewFlowLayout {
		let bannerListLayout = SWInflateLayout()
		bannerListLayout.scrollDirection = .horizontal
		bannerListLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		bannerListLayout.itemSize = CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.height)
		return bannerListLayout
	}
}
extension SliderCell: BEKBindableCell{
	typealias ViewModelType = SliderVM
	func bindData(withViewModel viewModel: SliderVM) {
		model = viewModel
		collectionView.collectionViewLayout = getBannerLayout()
		collectionView.reloadData()
	}
}
extension SliderCell: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return model.images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? SliderItemCell else {
			return UICollectionViewCell()
		}
		if model.images.count > indexPath.row{
			cell.imageView.image = UIImage(data: model.images[indexPath.row])
			cell.removeContainer.isHidden = true
		}
		return cell
	}
	
	
}
