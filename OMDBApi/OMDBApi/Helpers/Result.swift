//
//  Result.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation

public enum Result<Value> {
	case success(Value)
	case failure(Error)
}
