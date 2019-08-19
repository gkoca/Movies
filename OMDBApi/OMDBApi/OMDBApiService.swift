//
//  OMDBApiService.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation
import Alamofire

public protocol MovieSearchServiceProtocol {
	func searchMovies(completion: @escaping (Result<MovieSearchResponse>) -> Void)
}

public protocol MovieDetailServiceProtocol {
	func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Result<MovieDetailResponse>) -> Void)
	func fetchMovieDetailByTitle(_ title: String, completion: @escaping (Result<MovieDetailResponse>) -> Void)
}

public protocol MovieServiceProtocol: MovieSearchServiceProtocol, MovieDetailServiceProtocol {
	
}

public class OMDBApiService: MovieServiceProtocol {
	private var apiKey = ""
	private var baseUrl = ""
	
	public enum Error: Swift.Error {
		case serializationError(internal: Swift.Error)
		case networkError(internal: Swift.Error)
	}
	
	public init() {
		if let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
			apiKey = key
			baseUrl = "http://www.omdbapi.com/?apikey=[\(apiKey)]&"
		} else {
			fatalError("can not get api key")
		}
	}
	
	public func searchMovies(completion: @escaping (Result<MovieSearchResponse>) -> Void) {
		let urlString = baseUrl + "s=Batman&page=2"
		request(urlString).responseData { (response) in
			switch response.result {
			case .success(let data):
				let decoder = Decoders.basicDateDecoder
				do {
					let response = try decoder.decode(MovieSearchResponse.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(Error.serializationError(internal: error)))
				}
			case .failure(let error):
				completion(.failure(Error.networkError(internal: error)))
			}
		}
	}
	
	public func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Result<MovieDetailResponse>) -> Void) {
		
	}
	
	public func fetchMovieDetailByTitle(_ title: String, completion: @escaping (Result<MovieDetailResponse>) -> Void) {
		
	}
	
}
