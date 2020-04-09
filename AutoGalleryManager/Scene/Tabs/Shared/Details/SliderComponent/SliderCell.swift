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
			collectionView.removeAll()
			collectionView.reloadData()
			let cells = model.items.compactMap { (item) -> BEKGenericCellType in
				return BEKGenericCollectionCell<SliderItemCell>(viewModel: item, size: CGSize(width: collectionView.bounds.width - 32 , height: collectionView.bounds.height))
			}
			collectionView.push(cells: cells)
			collectionView.reloadData()
		}
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func getBannerLayout() -> UICollectionViewFlowLayout {
		let bannerListLayout = UICollectionViewFlowLayout()
		bannerListLayout.scrollDirection = .horizontal
		bannerListLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		bannerListLayout.itemSize = CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.height)
		return bannerListLayout
	}
}

