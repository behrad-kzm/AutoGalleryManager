//
//  BEKCollectionDelegate.swift
//  BEKMultiCellCollection
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

public class BEKCollectionDelegate: NSObject,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var dataSource: BEKDataSource?
	public var onClick: ((BEKGenericCellType) -> Void)?
	
	public func addAction(ForCellClicked action: @escaping (BEKGenericCellType) -> Void){
		onClick = action
	}
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if let safeDS = dataSource, safeDS.cells.count > indexPath.row {
			return safeDS.cells[indexPath.row].cellSize
		}
		return .zero
	}
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if let safeDS = dataSource, safeDS.cells.count > indexPath.row {
			let model = safeDS.cells[indexPath.row]
			onClick?(model)
		}
	}
}
