//
//  OptionalExt.swift
//  Movies
//
//  Created by Gökhan KOCA on 20.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

extension Optional where Wrapped: Collection {
	
	var isNilOrEmpty: Bool {
		return self?.isEmpty ?? true
	}
	
}
