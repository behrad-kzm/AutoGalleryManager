//
//  SliderCell.swift
//  AutoGalleryManager
//
//  Created by Behrad Kazemi on 4/5/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import BEKMultiCellCollection

import Domain
class SliderCell: UITableViewCell {
	@IBOutlet weak var collectionView: BEKMultiCellCollection!
	var model: SliderVM! {
		didSet {
			refresh()
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	func refresh(){
		collectionView.removeAll()
		collectionView.reloadData()
		let cells = model.items.compactMap { (item) -> BEKGenericCellType in
			return BEKGenericCollectionCell<SliderItemCell>(viewModel: item, size: CGSize(width: collectionView.bounds.width - 32 , height: collectionView.bounds.height))
		}
		if let safeNavigator = model.navigator{
			collectionView.onClick { [safeNavigator](type) in
				if let cell = type as? BEKGenericCollectionCell<SliderItemCell> {
					let imageData = cell.viewModel.model.data
					safeNavigator.toImagePreview(data: imageData)
				}
			}
		}
		collectionView.push(cells: cells)
		collectionView.reloadData()
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		refresh()
	}
	func getBannerLayout() -> UICollectionViewFlowLayout {
		let bannerListLayout = UICollectionViewFlowLayout()
		bannerListLayout.scrollDirection = .horizontal
		bannerListLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		bannerListLayout.itemSize = CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.height)
		return bannerListLayout
	}
}

