//
//  MovieDetail.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation

public struct MovieDetail: Decodable {
	
	public let actors, awards, boxOffice, country, director, genre, imdbID, imdbRating,
	imdbVotes, language, metascore, plot, poster, production, rated, runtime,
	title, type, website, writer, year, DVD, released: String?
	
	public let ratings: [Rating]?
	public let response: Bool?
	
	enum CodingKeys: String, CodingKey {
		case actors = "Actors"
		case awards = "Awards"
		case boxOffice = "BoxOffice"
		case country = "Country"
		case director = "Director"
		case dVD = "DVD"
		case genre = "Genre"
		case imdbID = "imdbID"
		case imdbRating = "imdbRating"
		case imdbVotes = "imdbVotes"
		case language = "Language"
		case metascore = "Metascore"
		case plot = "Plot"
		case poster = "Poster"
		case production = "Production"
		case rated = "Rated"
		case ratings = "Ratings"
		case released = "Released"
		case response = "Response"
		case runtime = "Runtime"
		case title = "Title"
		case type = "Type"
		case website = "Website"
		case writer = "Writer"
		case year = "Year"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actors = try values.decodeIfPresent(String.self, forKey: .actors)
		awards = try values.decodeIfPresent(String.self, forKey: .awards)
		boxOffice = try values.decodeIfPresent(String.self, forKey: .boxOffice)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		director = try values.decodeIfPresent(String.self, forKey: .director)
		DVD = try values.decodeIfPresent(String.self, forKey: .dVD)
		genre = try values.decodeIfPresent(String.self, forKey: .genre)
		imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
		imdbRating = try values.decodeIfPresent(String.self, forKey: .imdbRating)
		imdbVotes = try values.decodeIfPresent(String.self, forKey: .imdbVotes)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		metascore = try values.decodeIfPresent(String.self, forKey: .metascore)
		plot = try values.decodeIfPresent(String.self, forKey: .plot)
		poster = try values.decodeIfPresent(String.self, forKey: .poster)
		production = try values.decodeIfPresent(String.self, forKey: .production)
		rated = try values.decodeIfPresent(String.self, forKey: .rated)
		ratings = try values.decodeIfPresent([Rating].self, forKey: .ratings)
		released = try values.decodeIfPresent(String.self, forKey: .released)
		if let responseValue = try? values.decodeIfPresent(String.self, forKey: .response), responseValue.lowercased() == "true" {
			response = true
		} else {
			response = false
		}
		runtime = try values.decodeIfPresent(String.self, forKey: .runtime)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		writer = try values.decodeIfPresent(String.self, forKey: .writer)
		year = try values.decodeIfPresent(String.self, forKey: .year)
	}
	
}

public struct Rating: Decodable {
	
	public let source: String?
	public let value: String?
	
	enum CodingKeys: String, CodingKey {
		case source = "Source"
		case value = "Value"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}
	
}
