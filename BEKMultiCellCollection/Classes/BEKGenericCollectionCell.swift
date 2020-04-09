//
//  BEKGenericCollectionCell.swift
//  BEKMultiCellCollection
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit
public struct BEKGenericCollectionCell<CellType>: BEKGenericCellType where CellType: UICollectionViewCell, CellType: BEKBindableCell {
	public var cellSize: CGSize
	public var nib: UINib?
	public let viewModel: CellType.ViewModelType
	public let reuseIdentifier = NSStringFromClass(CellType.self)
	public let type: AnyClass = CellType.self
	public init(viewModel: CellType.ViewModelType, withNib nib: UINib? = UINib(nibName: NSStringFromClass(CellType.self).components(separatedBy: ".").last ?? "", bundle: nil), size: CGSize) {
		self.nib = nib
		self.cellSize = size
		self.viewModel = viewModel
	}
	public mutating func bind(toCell cell: UICollectionViewCell, withSize size: CGSize) {
		if let cell = cell as? CellType {
			cell.cellSize = size
			cell.bindData(withViewModel: viewModel, size: size)
		}
	}
}
