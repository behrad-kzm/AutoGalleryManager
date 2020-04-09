//
//  BEKDataSource.swift
//  BEKMultiCellCollection
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

public class BEKDataSource: NSObject, UICollectionViewDataSource {
	
	var cells = [BEKGenericCellType]()
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cells.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var genericCell = cells[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genericCell.reuseIdentifier, for: indexPath)
		genericCell.bind(toCell: cell, withSize: genericCell.cellSize)
		return cell
	}
	
	
}
