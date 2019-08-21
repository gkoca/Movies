//
//  OMDBApiService.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

//TODO: Seperate & cleanup
public protocol MovieSearchServiceProtocol {
	func searchMovies(by title: String, type: String, year: String, page: Int, completion: @escaping (Result<MovieSearch>) -> Void)
}

public protocol MovieDetailServiceProtocol {
	func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Result<MovieDetail>) -> Void)
	func fetchMovieDetailByTitle(_ title: String, completion: @escaping (Result<MovieDetail>) -> Void)
}

public protocol MoviePosterDownloadProtocol {
	func fetchPoster(_ url: String, completion: @escaping (Result<Image>) -> Void)
}

public protocol MovieServiceProtocol: MovieSearchServiceProtocol, MovieDetailServiceProtocol, MoviePosterDownloadProtocol {
	
}

public class OMDBApiService: MovieServiceProtocol {
	
	
	private var apiKey = ""
	private var baseUrl = ""
	
	public enum Error: Swift.Error {
		case serializationError(internal: Swift.Error)
		case networkError(internal: Swift.Error)
	}
	
	public init() {
		if let key = Bundle(for: type(of: self)).object(forInfoDictionaryKey: "API_KEY") as? String {
			apiKey = key
			baseUrl = "http://www.omdbapi.com/?apikey=\(apiKey)&"
		} else {
			fatalError("can not get api key")
		}
	}
	
	public func fetchPoster(_ url: String, completion: @escaping (Result<Image>) -> Void) {
		request(url).responseImage { response in
			switch response.result {
			case .success(let image):
				completion(.success(image))
			case .failure(let error):
				completion(.failure(Error.networkError(internal: error)))
			}
		}
	}
	
	public func searchMovies(by title: String, type: String, year: String, page: Int, completion: @escaping (Result<MovieSearch>) -> Void) {
		var urlString = baseUrl + "s=\(title)&page=\(page)"
		if type.count > 0 && type.lowercased() != "any" {
			urlString += "&type=\(type.lowercased())"
		}
		if let yearValue = Int(year), yearValue >= 1890, yearValue <= 2020 {
			urlString += "&year=\(yearValue)"
		}
		debugPrint("==================================================")
		debugPrint(urlString)
		debugPrint("==================================================")
		request(urlString).responseData { (response) in
			switch response.result {
			case .success(let data):
				let decoder = Decoders.basicDateDecoder
				do {
					let response = try decoder.decode(MovieSearch.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(Error.serializationError(internal: error)))
				}
			case .failure(let error):
				completion(.failure(Error.networkError(internal: error)))
			}
		}
	}
	
	public func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Result<MovieDetail>) -> Void) {
		let urlString = baseUrl + "i=\(id)&plot=full"
		request(urlString).responseData { (response) in
			switch response.result {
			case .success(let data):
				let decoder = Decoders.basicDateDecoder
				do {
					let response = try decoder.decode(MovieDetail.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(Error.serializationError(internal: error)))
				}
			case .failure(let error):
				completion(.failure(Error.networkError(internal: error)))
			}
		}
	}
	
	public func fetchMovieDetailByTitle(_ title: String, completion: @escaping (Result<MovieDetail>) -> Void) {
		let urlString = baseUrl + "t=\(title)&plot=full"
		request(urlString).responseData { (response) in
			switch response.result {
			case .success(let data):
				let decoder = Decoders.basicDateDecoder
				do {
					let response = try decoder.decode(MovieDetail.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(Error.serializationError(internal: error)))
				}
			case .failure(let error):
				completion(.failure(Error.networkError(internal: error)))
			}
		}
	}
	
}
