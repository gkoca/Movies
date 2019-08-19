//
//  Decoders.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation

public enum Decoders {
	public static let basicDateDecoder: JSONDecoder = {
		let decoder = JSONDecoder()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM YYYY"
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		return decoder
	}()
}
