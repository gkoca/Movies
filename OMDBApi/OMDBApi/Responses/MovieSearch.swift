//
//  MovieSearch.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation

public struct MovieSearch: Decodable {
	let response: Bool?
	let search: [Search]?
	let totalResults: Int?
	
	enum CodingKeys: String, CodingKey {
		case response = "Response"
		case search = "Search"
		case totalResults = "totalResults"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		if let responseValue = try? values.decodeIfPresent(String.self, forKey: .response), responseValue.lowercased() == "true" {
			response = true
		} else {
			response = false
		}
		if let totalResultsValue = try values.decodeIfPresent(String.self, forKey: .totalResults), let value = Int(totalResultsValue) {
			totalResults = value
		} else {
			totalResults = 0
		}
		search = try values.decodeIfPresent([Search].self, forKey: .search)
	}
}

public struct Search: Decodable {
	let imdbID, poster, title, type, year: String?

	enum CodingKeys: String, CodingKey {
		case imdbID = "imdbID"
		case poster = "Poster"
		case title = "Title"
		case type = "Type"
		case year = "Year"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
		poster = try values.decodeIfPresent(String.self, forKey: .poster)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		year = try values.decodeIfPresent(String.self, forKey: .year)
	}
}
