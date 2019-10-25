//
//  OMDBApiServiceProtocols.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import AlamofireImage

public enum Error: Swift.Error {
    case serializationError(internal: Swift.Error)
    case networkError(internal: Swift.Error)
}

public protocol MovieSearchServiceProtocol {
	func searchMovies(by title: String, type: String, year: String, page: Int, completion: @escaping (Swift.Result<MovieSearch, Error>) -> Void)
}

public protocol MovieDetailServiceProtocol {
	func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Swift.Result<MovieDetail, Error>) -> Void)
}

public protocol MoviePosterDownloadProtocol {
    func fetchPoster(_ url: String, completion: @escaping (Swift.Result<Image, Error>) -> Void)
}

public protocol OMDBApiServiceProtocol: MovieSearchServiceProtocol, MovieDetailServiceProtocol, MoviePosterDownloadProtocol {
}
