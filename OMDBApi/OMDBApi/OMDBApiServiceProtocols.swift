//
//  OMDBApiServiceProtocols.swift
//  OMDBApi
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import AlamofireImage

public protocol MovieSearchServiceProtocol {
	func searchMovies(by title: String, type: String, year: String, page: Int, completion: @escaping (Result<MovieSearch>) -> Void)
}

public protocol MovieDetailServiceProtocol {
	func fetchMovieDetailByIMDBId(_ id: String, completion: @escaping (Result<MovieDetail>) -> Void)
}

public protocol MoviePosterDownloadProtocol {
	func fetchPoster(_ url: String, completion: @escaping (Result<Image>) -> Void)
}

public protocol OMDBApiServiceProtocol: MovieSearchServiceProtocol, MovieDetailServiceProtocol, MoviePosterDownloadProtocol {
}
