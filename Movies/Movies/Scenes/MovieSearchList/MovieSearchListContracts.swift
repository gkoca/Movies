//
//  MovieSearchListContracts.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation

protocol MovieSearchListViewModelProtocol {
	var delegate: MovieSearchListViewModelDelegate? { get set }
	func load()
	func selectMovie(at index: Int)
}

protocol MovieSearchListViewModelDelegate: class {
	
}
