//
//  MovieSearchListContracts.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

protocol MovieSearchListViewModelProtocol {
	var delegate: MovieSearchListViewModelDelegate? { get set }
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

enum MovieSearchListViewModelOutput: Equatable {
	case setLoading(Bool)
	case showMovieList
}

enum MovieSearchListViewRoute {
	case detail(MovieSearchListViewModelProtocol)
}

protocol MovieSearchListViewModelDelegate: class {
	func handleViewModelOutput(_ output: MovieSearchListViewModelOutput)
	func navigate(to route: MovieSearchListViewRoute)
}
