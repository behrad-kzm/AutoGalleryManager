//
//  BEKMultiCellCollection.swift
//  BEKMultiCellCollection
//
//  Created by Behrad Kazemi on 4/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit

public class BEKMultiCellCollection: UICollectionView {
	
	private var bekDataSource = BEKDataSource()
	public var bekDelegate = BEKCollectionDelegate()
	public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.dataSource = bekDataSource
		bekDelegate.dataSource = bekDataSource
		self.delegate = bekDelegate
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.dataSource = bekDataSource
		bekDelegate.dataSource = bekDataSource
		self.delegate = bekDelegate
	}
	func register(cell: BEKGenericCellType){
		
		if let nib = cell.nib {
			register(nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
			return
		}
		register(cell.type, forCellWithReuseIdentifier: cell.reuseIdentifier)
	}
	public func insert(cell: BEKGenericCellType, atIndex index: Int, completion: (Bool) -> Void = {_ in}){
		if index < 0 || index > bekDataSource.cells.count {
			completion(false)
		}
		bekDataSource.cells.insert(cell, at: index)
		register(cell: cell)
		bekDelegate.dataSource = bekDataSource
		reloadData()
		completion(true)
	}
	public func push(cell: BEKGenericCellType){
		bekDataSource.cells.append(cell)
		register(cell: cell)
		bekDelegate.dataSource = bekDataSource
		reloadData()
	}
	public func push(cells: [BEKGenericCellType]){
		bekDataSource.cells.append(contentsOf: cells)
		cells.forEach { register(cell: $0) }
		bekDelegate.dataSource = bekDataSource
		reloadData()
	}
	public func remove(cellAtIndex index: Int) {
		bekDataSource.cells.remove(at: index)
		bekDelegate.dataSource = bekDataSource
		reloadData()
	}
	public func removeAll() {
		bekDataSource.cells.removeAll()
		bekDelegate.dataSource = bekDataSource
		reloadData()
	}
	public func onClick(action: @escaping (BEKGenericCellType) -> Void){
		bekDelegate.addAction(ForCellClicked: action)
	}
}

