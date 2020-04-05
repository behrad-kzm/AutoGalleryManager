//
//  ImageDomainModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 4/5/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public struct ImageDomainModel {
	public let id: String?
	public let data: Data
	public let imageId: String?
	
	public init(id: String?,
							data: Data,
							imageId: String?) {
		self.id = id
		self.data = data
		self.imageId = imageId
	}
}
