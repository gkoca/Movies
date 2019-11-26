//
//  MovieSearchListContracts.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

protocol MovieSearchListViewModelProtocol {
	var notifier: ((MovieSearchListViewModelOutput) -> Void)? { get set }
	func search(by title: String, year: String, type: String)
	func loadMore()
	func selectMovie(at index: Int)
	func getNumberOfItems() -> Int
	func getMoviePoster(at index: Int) -> UIImage?
	func getMoviePoster(at index: Int, completion: @escaping (UIImage?) -> Void)
	func getMovieTitle(at index: Int) -> String
	func getMovieYear(at index: Int) -> String
	func getMovieType(at index: Int) -> String
}

extension MovieSearchListViewModelProtocol {
	func search(by title: String, year: String = "", type: String = "") {
		search(by: title, year: year, type: type)
	}
}

enum MovieSearchListViewModelOutput {
	case setLoading(Bool)
	case showMovieList
	case navigate(MovieSearchListViewRoute)
}

enum MovieSearchListViewRoute {
	case detail(MovieDetailViewModelProtocol)
}
