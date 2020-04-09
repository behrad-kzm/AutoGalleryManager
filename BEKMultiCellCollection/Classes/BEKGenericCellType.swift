//
//  BEKGenericCellType.swift
//  BEKMultiCellCollection
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit.UICollectionViewCell

public protocol BEKGenericCellType {
	
	var reuseIdentifier: String { get }
	var type: AnyClass { get }
	var nib: UINib? { get set }
	var cellSize: CGSize { get set}
	
	mutating func bind(toCell cell: UICollectionViewCell, withSize size: CGSize)
}
